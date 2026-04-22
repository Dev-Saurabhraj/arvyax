import '../datasources/session_local_datasource.dart';
import '../models/session_state.dart';

abstract class SessionRepository {
  Future<void> saveSessionState(SessionState state);
  Future<SessionState?> getSessionState();
  Future<void> clearSessionState();
}

class SessionRepositoryImpl implements SessionRepository {
  final SessionLocalDataSource localDataSource;

  SessionRepositoryImpl(this.localDataSource);

  @override
  Future<void> saveSessionState(SessionState state) async {
    await localDataSource.saveSessionState(state);
  }

  @override
  Future<SessionState?> getSessionState() async {
    return await localDataSource.getSessionState();
  }

  @override
  Future<void> clearSessionState() async {
    await localDataSource.clearSessionState();
  }
}
