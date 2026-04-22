import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'journal_entry.freezed.dart';
part 'journal_entry.g.dart';

@HiveType(typeId: 3)
enum Mood {
  @HiveField(0)
  calm,
  @HiveField(1)
  grounded,
  @HiveField(2)
  energized,
  @HiveField(3)
  sleepy,
}

@HiveType(typeId: 1)
@freezed
class JournalEntry with _$JournalEntry {
  const factory JournalEntry({
    @HiveField(0) required String id,
    @HiveField(1) required String ambienceId,
    @HiveField(2) required String ambienceTitle,
    @HiveField(3) required String content,
    @HiveField(4) required Mood mood,
    @HiveField(5) required DateTime createdAt,
  }) = _JournalEntry;

  factory JournalEntry.fromJson(Map<String, dynamic> json) =>
      _$JournalEntryFromJson(json);
}
