import '../../domain/entities/home_summary.dart';

class HomeSummaryModel extends HomeSummary {
  const HomeSummaryModel({
    required super.displayName,
    required super.upcomingSubject,
    required super.tutorName,
    required super.nextSessionAt,
    required super.location,
    required super.subjects,
    required super.isDemo,
  });
}
