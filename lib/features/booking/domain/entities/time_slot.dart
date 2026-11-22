import 'package:equatable/equatable.dart';

class TimeSlot extends Equatable {
  const TimeSlot({
    required this.id,
    required this.tutorId,
    required this.startAt,
    this.durationMinutes = 45,
    required this.mode,
    this.isBooked = false,
  });
  final String id;
  final String tutorId;
  final DateTime startAt;
  final int durationMinutes;
  final String mode;
  final bool isBooked;
  @override
  List<Object?> get props => [id, tutorId, startAt, durationMinutes, mode, isBooked];
}
