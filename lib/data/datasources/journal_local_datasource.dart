import 'package:hive/hive.dart';
import '../models/journal_entry.dart';

abstract class JournalLocalDataSource {
  Future<void> saveEntry(JournalEntry entry);
  Future<List<JournalEntry>> getAllEntries();
  Future<JournalEntry?> getEntryById(String id);
  Future<void> deleteEntry(String id);
}

class JournalLocalDataSourceImpl implements JournalLocalDataSource {
  static const String boxName = 'journal_entries';

  @override
  Future<void> saveEntry(JournalEntry entry) async {
    final box = await Hive.openBox<Map>(boxName);
    await box.put(entry.id, entry.toJson());
  }

  @override
  Future<List<JournalEntry>> getAllEntries() async {
    final box = await Hive.openBox<Map>(boxName);
    final entries = box.values
        .map((item) => JournalEntry.fromJson(Map<String, dynamic>.from(item)))
        .toList();
    // Sort by createdAt descending (newest first)
    entries.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return entries;
  }

  @override
  Future<JournalEntry?> getEntryById(String id) async {
    final box = await Hive.openBox<Map>(boxName);
    final item = box.get(id);
    if (item != null) {
      return JournalEntry.fromJson(Map<String, dynamic>.from(item));
    }
    return null;
  }

  @override
  Future<void> deleteEntry(String id) async {
    final box = await Hive.openBox<Map>(boxName);
    await box.delete(id);
  }
}
