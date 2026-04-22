part of 'ambience_bloc.dart';

abstract class AmbienceEvent extends Equatable {
  const AmbienceEvent();
}

class LoadAmbiences extends AmbienceEvent {
  const LoadAmbiences();

  @override
  List<Object?> get props => [];
}

class FilterAmbiences extends AmbienceEvent {
  final String query;
  final String? tag;

  const FilterAmbiences({required this.query, this.tag});

  @override
  List<Object?> get props => [query, tag];
}
