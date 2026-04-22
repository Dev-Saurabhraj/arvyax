part of 'journal_bloc.dart';

abstract class JournalState extends Equatable {
  const JournalState();
}

class JournalInitial extends JournalState {
  const JournalInitial();

  @override
  List<Object?> get props => [];
}

class JournalLoading extends JournalState {
  const JournalLoading();

  @override
  List<Object?> get props => [];
}

class JournalLoaded extends JournalState {
  final List<JournalEntry> entries;

  const JournalLoaded(this.entries);

  @override
  List<Object?> get props => [entries];
}

class JournalEntryDetail extends JournalState {
  final JournalEntry entry;

  const JournalEntryDetail(this.entry);

  @override
  List<Object?> get props => [entry];
}

class JournalSaved extends JournalState {
  final JournalEntry entry;

  const JournalSaved(this.entry);

  @override
  List<Object?> get props => [entry];
}

class JournalDeleted extends JournalState {
  const JournalDeleted();

  @override
  List<Object?> get props => [];
}

class JournalError extends JournalState {
  final String message;

  const JournalError(this.message);

  @override
  List<Object?> get props => [message];
}
