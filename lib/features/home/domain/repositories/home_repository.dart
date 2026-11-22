import '../entities/home_summary.dart';

abstract interface class HomeRepository {
  Future<HomeSummary> getHomeSummary(String userId);
}
