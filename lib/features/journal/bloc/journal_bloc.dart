import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/journal_entry.dart';
import '../../../data/repositories/journal_repository.dart';

part 'journal_event.dart';
part 'journal_state.dart';

class JournalBloc extends Bloc<JournalEvent, JournalState> {
  final JournalRepository repository;

  JournalBloc({required this.repository}) : super(const JournalInitial()) {
    on<LoadJournalEntries>(_onLoadJournalEntries);
    on<SaveJournalEntry>(_onSaveJournalEntry);
    on<GetEntryById>(_onGetEntryById);
    on<DeleteJournalEntry>(_onDeleteJournalEntry);
  }

  Future<void> _onLoadJournalEntries(
    LoadJournalEntries event,
    Emitter<JournalState> emit,
  ) async {
    emit(const JournalLoading());
    try {
      final entries = await repository.getAllEntries();
      emit(JournalLoaded(entries));
    } catch (e) {
      emit(JournalError('Failed to load journal entries: ${e.toString()}'));
    }
  }

  Future<void> _onSaveJournalEntry(
    SaveJournalEntry event,
    Emitter<JournalState> emit,
  ) async {
    try {
      await repository.saveEntry(event.entry);
      emit(JournalSaved(event.entry));
      // Reload entries
      add(const LoadJournalEntries());
    } catch (e) {
      emit(JournalError('Failed to save entry: ${e.toString()}'));
    }
  }

  Future<void> _onGetEntryById(
    GetEntryById event,
    Emitter<JournalState> emit,
  ) async {
    try {
      final entry = await repository.getEntryById(event.id);
      if (entry != null) {
        emit(JournalEntryDetail(entry));
      } else {
        emit(const JournalError('Entry not found'));
      }
    } catch (e) {
      emit(JournalError('Failed to get entry: ${e.toString()}'));
    }
  }

  Future<void> _onDeleteJournalEntry(
    DeleteJournalEntry event,
    Emitter<JournalState> emit,
  ) async {
    try {
      await repository.deleteEntry(event.id);
      emit(const JournalDeleted());
      // Reload entries
      add(const LoadJournalEntries());
    } catch (e) {
      emit(JournalError('Failed to delete entry: ${e.toString()}'));
    }
  }
}
