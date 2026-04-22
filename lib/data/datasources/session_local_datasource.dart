import 'package:hive/hive.dart';
import '../models/session_state.dart';

abstract class SessionLocalDataSource {
  Future<void> saveSessionState(SessionState state);
  Future<SessionState?> getSessionState();
  Future<void> clearSessionState();
}

class SessionLocalDataSourceImpl implements SessionLocalDataSource {
  static const String boxName = 'session_state';
  static const String key = 'active_session';

  @override
  Future<void> saveSessionState(SessionState state) async {
    final box = await Hive.openBox<Map>(boxName);
    await box.put(key, state.toJson());
  }

  @override
  Future<SessionState?> getSessionState() async {
    final box = await Hive.openBox<Map>(boxName);
    final item = box.get(key);
    if (item != null) {
      return SessionState.fromJson(Map<String, dynamic>.from(item));
    }
    return null;
  }

  @override
  Future<void> clearSessionState() async {
    final box = await Hive.openBox<Map>(boxName);
    await box.delete(key);
  }
}
