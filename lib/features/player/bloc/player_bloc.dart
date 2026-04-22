import 'dart:async';
import 'package:audio_session/audio_session.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:uuid/uuid.dart';
import '../../../data/models/ambience.dart';
import '../../../data/models/session_state.dart';
import '../../../data/repositories/session_repository.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  final SessionRepository sessionRepository;
  final AudioPlayer audioPlayer = AudioPlayer();

  StreamSubscription? _positionSubscription;
  StreamSubscription? _processingStateSubscription;
  Timer? _sessionTimer;
  SessionState? _currentSession;
  bool _isLooping = false;

  PlayerBloc({required this.sessionRepository}) : super(const PlayerInitial()) {
    on<StartSession>(_onStartSession);
    on<PlayAudio>(_onPlayAudio);
    on<PauseAudio>(_onPauseAudio);
    on<StopAudio>(_onStopAudio);
    on<SeekAudio>(_onSeekAudio);
    on<ToggleLoop>(_onToggleLoop);
    on<UpdatePlayerState>(_onUpdatePlayerState);
    on<EndSession>(_onEndSession);
    on<RestoreSession>(_onRestoreSession);
  }

  Future<void> _onStartSession(
    StartSession event,
    Emitter<PlayerState> emit,
  ) async {
    try {
      final sessionId = const Uuid().v4();
      _currentSession = SessionState(
        id: sessionId,
        ambience: event.ambience,
        isPlaying: true,
        elapsed: Duration.zero,
        startedAt: DateTime.now(),
      );

      await sessionRepository.saveSessionState(_currentSession!);
      _isLooping = false;
      await _configureAudioSession();
      await audioPlayer.setLoopMode(LoopMode.off);
      await audioPlayer.setAsset(event.ambience.audioPath);
      await audioPlayer.play();

      emit(PlayerActive(sessionState: _currentSession!, isLooping: _isLooping));
      _setupPositionListener();
      _setupCompletionListener();
      _setupSessionTimer(event.ambience.durationInSeconds);
    } catch (e) {
      emit(PlayerError('Failed to start session: ${e.toString()}'));
    }
  }

  Future<void> _onPlayAudio(PlayAudio event, Emitter<PlayerState> emit) async {
    try {
      if (_currentSession != null) {
        if (audioPlayer.processingState == ProcessingState.completed ||
            _currentSession!.remaining <= Duration.zero) {
          await audioPlayer.seek(Duration.zero);
          _currentSession = _currentSession!.copyWith(elapsed: Duration.zero);
        }

        await _configureAudioSession();
        await audioPlayer.play();
        _currentSession = _currentSession!.copyWith(isPlaying: true);
        await sessionRepository.saveSessionState(_currentSession!);
        emit(
          PlayerActive(sessionState: _currentSession!, isLooping: _isLooping),
        );
      }
    } catch (e) {
      emit(PlayerError('Failed to play audio: ${e.toString()}'));
    }
  }

  Future<void> _onPauseAudio(
    PauseAudio event,
    Emitter<PlayerState> emit,
  ) async {
    try {
      if (_currentSession != null) {
        await audioPlayer.pause();
        _currentSession = _currentSession!.copyWith(isPlaying: false);
        await sessionRepository.saveSessionState(_currentSession!);
        emit(PlayerPaused(_currentSession!, isLooping: _isLooping));
      }
    } catch (e) {
      emit(PlayerError('Failed to pause audio: ${e.toString()}'));
    }
  }

  Future<void> _onStopAudio(StopAudio event, Emitter<PlayerState> emit) async {
    try {
      await audioPlayer.stop();
      _sessionTimer?.cancel();
      _positionSubscription?.cancel();
    } catch (e) {
      emit(PlayerError('Failed to stop audio: ${e.toString()}'));
    }
  }

  Future<void> _onSeekAudio(SeekAudio event, Emitter<PlayerState> emit) async {
    try {
      if (_currentSession != null) {
        await audioPlayer.seek(event.position);
        _currentSession = _currentSession!.copyWith(elapsed: event.position);
        await sessionRepository.saveSessionState(_currentSession!);
        emit(
          PlayerActive(sessionState: _currentSession!, isLooping: _isLooping),
        );
      }
    } catch (e) {
      emit(PlayerError('Failed to seek: ${e.toString()}'));
    }
  }

  Future<void> _onToggleLoop(
    ToggleLoop event,
    Emitter<PlayerState> emit,
  ) async {
    try {
      if (_currentSession != null) {
        _isLooping = !_isLooping;
        await audioPlayer.setLoopMode(_isLooping ? LoopMode.one : LoopMode.off);

        if (_currentSession!.isPlaying) {
          emit(
            PlayerActive(sessionState: _currentSession!, isLooping: _isLooping),
          );
        } else {
          emit(PlayerPaused(_currentSession!, isLooping: _isLooping));
        }
      }
    } catch (e) {
      emit(PlayerError('Failed to toggle loop: ${e.toString()}'));
    }
  }

  Future<void> _onUpdatePlayerState(
    UpdatePlayerState event,
    Emitter<PlayerState> emit,
  ) async {
    if (_currentSession != null) {
      _currentSession = _currentSession!.copyWith(
        elapsed: event.elapsed,
        isPlaying: event.isPlaying,
      );
      await sessionRepository.saveSessionState(_currentSession!);

      if (event.isPlaying) {
        emit(
          PlayerActive(sessionState: _currentSession!, isLooping: _isLooping),
        );
      } else {
        emit(PlayerPaused(_currentSession!, isLooping: _isLooping));
      }
    }
  }

  Future<void> _onEndSession(
    EndSession event,
    Emitter<PlayerState> emit,
  ) async {
    try {
      final endedSession = _currentSession;
      _currentSession = null;

      await audioPlayer.stop();
      _sessionTimer?.cancel();
      _positionSubscription?.cancel();
      _processingStateSubscription?.cancel();

      if (endedSession != null) {
        emit(SessionEnded(endedSession));
        await sessionRepository.clearSessionState();
      }
    } catch (e) {
      emit(PlayerError('Failed to end session: ${e.toString()}'));
    }
  }

  Future<void> _onRestoreSession(
    RestoreSession event,
    Emitter<PlayerState> emit,
  ) async {
    try {
      _currentSession = event.sessionState;
      if (_currentSession!.isPlaying) {
        emit(
          PlayerActive(sessionState: _currentSession!, isLooping: _isLooping),
        );
      } else {
        emit(PlayerPaused(_currentSession!, isLooping: _isLooping));
      }
    } catch (e) {
      emit(PlayerError('Failed to restore session: ${e.toString()}'));
    }
  }

  void _setupPositionListener() {
    _positionSubscription?.cancel();
    _positionSubscription = audioPlayer.positionStream.listen((position) {
      add(UpdatePlayerState(elapsed: position, isPlaying: audioPlayer.playing));
    });
  }

  void _setupCompletionListener() {
    _processingStateSubscription?.cancel();
    _processingStateSubscription = audioPlayer.processingStateStream.listen((
      processingState,
    ) {
      if (processingState == ProcessingState.completed && !_isLooping) {
        add(const EndSession());
      }
    });
  }

  void _setupSessionTimer(int durationInSeconds) {
    _sessionTimer?.cancel();
    _sessionTimer = Timer(Duration(seconds: durationInSeconds), () {
      add(const EndSession());
    });
  }

  Future<void> _configureAudioSession() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());
    await session.setActive(true);
  }

  @override
  Future<void> close() async {
    _positionSubscription?.cancel();
    _processingStateSubscription?.cancel();
    _sessionTimer?.cancel();
    await audioPlayer.dispose();
    return super.close();
  }
}
