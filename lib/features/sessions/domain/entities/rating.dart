import 'package:equatable/equatable.dart';

class SessionRating extends Equatable {
  const SessionRating({
    required this.sessionId,
    required this.studentId,
    required this.tutorId,
    required this.rating,
    required this.feedbackTags,
    required this.comment,
    required this.createdAt,
  });
  final String sessionId;
  final String studentId;
  final String tutorId;
  final int rating;
  final List<String> feedbackTags;
  final String comment;
  final DateTime createdAt;
  @override
  List<Object?> get props => [sessionId, studentId, tutorId, rating, feedbackTags, comment, createdAt];
}
