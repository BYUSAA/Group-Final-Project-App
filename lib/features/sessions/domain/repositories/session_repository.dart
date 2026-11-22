import '../entities/rating.dart';
import '../entities/session.dart';

abstract interface class SessionRepository {
  Future<List<Session>> getMySessions(String userId);
  Future<Session> getSessionDetails(String sessionId);
  Future<void> updateSessionNote({required String sessionId, required String note});
  Future<void> cancelSession({required String sessionId, required String reason});
  Future<void> submitRating(SessionRating rating);
}
