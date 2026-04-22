part of 'player_bloc.dart';

abstract class PlayerState extends Equatable {
  const PlayerState();
}

class PlayerInitial extends PlayerState {
  const PlayerInitial();

  @override
  List<Object?> get props => [];
}

class PlayerStarting extends PlayerState {
  final Ambience ambience;

  const PlayerStarting(this.ambience);

  @override
  List<Object?> get props => [ambience];
}

class PlayerActive extends PlayerState {
  final SessionState sessionState;
  final List<int> frequencyData; // For audio visualization
  final bool isLooping;

  const PlayerActive({
    required this.sessionState,
    this.frequencyData = const [],
    this.isLooping = false,
  });

  @override
  List<Object?> get props => [sessionState, frequencyData, isLooping];
}

class PlayerPaused extends PlayerState {
  final SessionState sessionState;
  final bool isLooping;

  const PlayerPaused(this.sessionState, {this.isLooping = false});

  @override
  List<Object?> get props => [sessionState, isLooping];
}

class SessionEnded extends PlayerState {
  final SessionState sessionState;

  const SessionEnded(this.sessionState);

  @override
  List<Object?> get props => [sessionState];
}

class PlayerError extends PlayerState {
  final String message;

  const PlayerError(this.message);

  @override
  List<Object?> get props => [message];
}
