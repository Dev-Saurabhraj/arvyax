import '../datasources/journal_local_datasource.dart';
import '../models/journal_entry.dart';

abstract class JournalRepository {
  Future<void> saveEntry(JournalEntry entry);
  Future<List<JournalEntry>> getAllEntries();
  Future<JournalEntry?> getEntryById(String id);
  Future<void> deleteEntry(String id);
}

class JournalRepositoryImpl implements JournalRepository {
  final JournalLocalDataSource localDataSource;

  JournalRepositoryImpl(this.localDataSource);

  @override
  Future<void> saveEntry(JournalEntry entry) async {
    await localDataSource.saveEntry(entry);
  }

  @override
  Future<List<JournalEntry>> getAllEntries() async {
    return await localDataSource.getAllEntries();
  }

  @override
  Future<JournalEntry?> getEntryById(String id) async {
    return await localDataSource.getEntryById(id);
  }

  @override
  Future<void> deleteEntry(String id) async {
    await localDataSource.deleteEntry(id);
  }
}
