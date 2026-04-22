part of 'journal_bloc.dart';

abstract class JournalEvent extends Equatable {
  const JournalEvent();
}

class LoadJournalEntries extends JournalEvent {
  const LoadJournalEntries();

  @override
  List<Object?> get props => [];
}

class SaveJournalEntry extends JournalEvent {
  final JournalEntry entry;

  const SaveJournalEntry(this.entry);

  @override
  List<Object?> get props => [entry];
}

class GetEntryById extends JournalEvent {
  final String id;

  const GetEntryById(this.id);

  @override
  List<Object?> get props => [id];
}

class DeleteJournalEntry extends JournalEvent {
  final String id;

  const DeleteJournalEntry(this.id);

  @override
  List<Object?> get props => [id];
}
