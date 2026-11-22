import '../../../sessions/domain/entities/session.dart';
import '../entities/time_slot.dart';

abstract interface class BookingRepository {
  Future<List<TimeSlot>> getOpenSlots(String tutorId, DateTime day);
  Future<Session> confirmBooking({
    required String studentId,
    required String tutorId,
    required String subjectId,
    required TimeSlot slot,
    required String note,
  });
}
