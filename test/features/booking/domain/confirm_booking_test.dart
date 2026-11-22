import 'package:flutter_test/flutter_test.dart';
import 'package:studylink/features/booking/domain/entities/time_slot.dart';

void main() {
  test('time slot holds the selected tutor, start time and mode', () {
    final start = DateTime(2026, 12, 1, 16);
    final slot = TimeSlot(id: 'slot-1', tutorId: 'tutor-1', startAt: start, durationMinutes: 45, mode: 'Campus');
    expect(slot.tutorId, 'tutor-1');
    expect(slot.startAt, start);
    expect(slot.durationMinutes, 45);
    expect(slot.isBooked, isFalse);
  });
}
