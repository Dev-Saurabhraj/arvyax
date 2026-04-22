part of 'player_bloc.dart';

abstract class PlayerEvent extends Equatable {
  const PlayerEvent();
}

class StartSession extends PlayerEvent {
  final Ambience ambience;

  const StartSession(this.ambience);

  @override
  List<Object?> get props => [ambience];
}

class PlayAudio extends PlayerEvent {
  const PlayAudio();

  @override
  List<Object?> get props => [];
}

class PauseAudio extends PlayerEvent {
  const PauseAudio();

  @override
  List<Object?> get props => [];
}

class StopAudio extends PlayerEvent {
  const StopAudio();

  @override
  List<Object?> get props => [];
}

class SeekAudio extends PlayerEvent {
  final Duration position;

  const SeekAudio(this.position);

  @override
  List<Object?> get props => [position];
}

class ToggleLoop extends PlayerEvent {
  const ToggleLoop();

  @override
  List<Object?> get props => [];
}

class UpdatePlayerState extends PlayerEvent {
  final Duration elapsed;
  final bool isPlaying;

  const UpdatePlayerState({required this.elapsed, required this.isPlaying});

  @override
  List<Object?> get props => [elapsed, isPlaying];
}

class EndSession extends PlayerEvent {
  const EndSession();

  @override
  List<Object?> get props => [];
}

class RestoreSession extends PlayerEvent {
  final SessionState sessionState;

  const RestoreSession(this.sessionState);

  @override
  List<Object?> get props => [sessionState];
}
