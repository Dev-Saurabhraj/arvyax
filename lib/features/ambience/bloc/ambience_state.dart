part of 'ambience_bloc.dart';

abstract class AmbienceState extends Equatable {
  const AmbienceState();
}

class AmbienceInitial extends AmbienceState {
  const AmbienceInitial();

  @override
  List<Object?> get props => [];
}

class AmbienceLoading extends AmbienceState {
  const AmbienceLoading();

  @override
  List<Object?> get props => [];
}

class AmbienceLoaded extends AmbienceState {
  final List<Ambience> ambiences;
  final List<Ambience> filteredAmbiences;
  final String currentQuery;
  final String? currentTag;

  const AmbienceLoaded({
    required this.ambiences,
    required this.filteredAmbiences,
    this.currentQuery = '',
    this.currentTag,
  });

  @override
  List<Object?> get props => [
    ambiences,
    filteredAmbiences,
    currentQuery,
    currentTag,
  ];
}

class AmbienceError extends AmbienceState {
  final String message;

  const AmbienceError(this.message);

  @override
  List<Object?> get props => [message];
}
