import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/session.dart';

class SessionModel extends Session {
  const SessionModel({
    required super.id, required super.studentId, required super.tutorId,
    required super.tutorName, required super.subjectId, required super.subjectName,
    required super.startAt, required super.durationMinutes, required super.mode,
    required super.location, required super.note, required super.status,
    super.slotId, super.rating,
  });

  factory SessionModel.fromMap(String id, Map<String, dynamic> map) {
    final status = (map['status'] ?? 'confirmed') as String;
    return SessionModel(
      id: id,
      studentId: (map['studentId'] ?? '') as String,
      tutorId: (map['tutorId'] ?? '') as String,
      tutorName: (map['tutorName'] ?? '') as String,
      subjectId: (map['subjectId'] ?? '') as String,
      subjectName: (map['subjectName'] ?? '') as String,
      startAt: (map['startAt'] as Timestamp).toDate(),
      durationMinutes: (map['durationMinutes'] ?? 45) as int,
      mode: (map['mode'] ?? 'Campus') as String,
      location: (map['location'] ?? '') as String,
      note: (map['note'] ?? '') as String,
      status: SessionStatus.values.firstWhere((value) => value.name == status, orElse: () => SessionStatus.confirmed),
      slotId: (map['slotId'] ?? '') as String,
      rating: map['rating'] as int?,
    );
  }

  Map<String, dynamic> toMap() => {
    'studentId': studentId, 'tutorId': tutorId, 'tutorName': tutorName,
    'subjectId': subjectId, 'subjectName': subjectName,
    'startAt': Timestamp.fromDate(startAt), 'durationMinutes': durationMinutes,
    'mode': mode, 'location': location, 'note': note, 'status': status.name,
    'slotId': slotId, 'rating': rating,
    'participantIds': [studentId, tutorId],
    'createdAt': FieldValue.serverTimestamp(),
    'updatedAt': FieldValue.serverTimestamp(),
  };
}
