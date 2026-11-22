import 'package:equatable/equatable.dart';

class SubjectSummary extends Equatable {
  const SubjectSummary({required this.subjectId, required this.title, required this.tutorCount});
  final String subjectId;
  final String title;
  final int tutorCount;
  @override
  List<Object?> get props => [subjectId, title, tutorCount];
}

class HomeSummary extends Equatable {
  const HomeSummary({
    required this.displayName,
    required this.upcomingSubject,
    required this.tutorName,
    required this.nextSessionAt,
    required this.location,
    required this.subjects,
    required this.isDemo,
  });
  final String displayName;
  final String upcomingSubject;
  final String tutorName;
  final DateTime nextSessionAt;
  final String location;
  final List<SubjectSummary> subjects;
  final bool isDemo;
  @override
  List<Object?> get props => [displayName, upcomingSubject, tutorName, nextSessionAt, location, subjects, isDemo];
}
