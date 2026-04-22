import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'ambience.dart';

part 'session_state.freezed.dart';
part 'session_state.g.dart';

@HiveType(typeId: 2)
@freezed
class SessionState with _$SessionState {
  const factory SessionState({
    @HiveField(0) required String? id,
    @HiveField(1) required Ambience? ambience,
    @HiveField(2) required bool isPlaying,
    @HiveField(3) required Duration elapsed,
    @HiveField(4) required DateTime? startedAt,
  }) = _SessionState;

  const SessionState._();

  bool get isActive => ambience != null;

  Duration get remaining {
    if (ambience == null) return Duration.zero;
    final total = Duration(seconds: ambience!.durationInSeconds);
    return total > elapsed ? total - elapsed : Duration.zero;
  }

  factory SessionState.initial() => const SessionState(
    id: null,
    ambience: null,
    isPlaying: false,
    elapsed: Duration.zero,
    startedAt: null,
  );

  factory SessionState.fromJson(Map<String, dynamic> json) =>
      _$SessionStateFromJson(json);
}
