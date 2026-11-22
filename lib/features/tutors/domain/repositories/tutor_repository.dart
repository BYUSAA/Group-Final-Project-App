import '../entities/subject.dart';
import '../entities/tutor.dart';

abstract interface class TutorRepository {
  Future<List<Subject>> searchSubjects(String query);
  Future<List<Tutor>> getTutorsBySubject(String subjectId);
  Future<Tutor> getTutorProfile(String tutorId);
}
