import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/ambience.dart';
import '../../../data/repositories/ambience_repository.dart';

part 'ambience_event.dart';
part 'ambience_state.dart';

class AmbienceBloc extends Bloc<AmbienceEvent, AmbienceState> {
  final AmbienceRepository repository;

  AmbienceBloc({required this.repository}) : super(const AmbienceInitial()) {
    on<LoadAmbiences>(_onLoadAmbiences);
    on<FilterAmbiences>(_onFilterAmbiences);
  }

  Future<void> _onLoadAmbiences(
    LoadAmbiences event,
    Emitter<AmbienceState> emit,
  ) async {
    emit(const AmbienceLoading());
    try {
      final ambiences = await repository.getAmbiences();
      emit(AmbienceLoaded(ambiences: ambiences, filteredAmbiences: ambiences));
    } catch (e) {
      emit(AmbienceError('Failed to load ambiences: ${e.toString()}'));
    }
  }

  Future<void> _onFilterAmbiences(
    FilterAmbiences event,
    Emitter<AmbienceState> emit,
  ) async {
    final currentState = state;
    if (currentState is! AmbienceLoaded) return;

    final filtered = currentState.ambiences.where((ambience) {
      final matchesQuery =
          ambience.title.toLowerCase().contains(event.query.toLowerCase()) ||
          ambience.description.toLowerCase().contains(
            event.query.toLowerCase(),
          );
      final matchesTag = event.tag == null || ambience.tag == event.tag;
      return matchesQuery && matchesTag;
    }).toList();

    emit(
      AmbienceLoaded(
        ambiences: currentState.ambiences,
        filteredAmbiences: filtered,
        currentQuery: event.query,
        currentTag: event.tag,
      ),
    );
  }
}
