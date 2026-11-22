# Firestore schema draft

Must be reconciled with approved ERD and Member 2's CRUD implementation.
- `users/{uid}`: displayName, email, programme, year, isTutor
- `subjects/{subjectId}`: name, description
- `tutors/{uid}`: bio, subjects, ratingAggregate, sessionCount
- `tutors/{uid}/availability/{slotId}`: startAt, durationMinutes, mode, status
- `sessions/{sessionId}`: studentId, tutorId, subjectId, slotId, startAt, mode, status, createdAt
- `ratings/{ratingId}`: sessionId, studentId, tutorId, score, tags, comment, createdAt

Use authenticated IDs, server timestamps and transactional slot reservations. Never trust client availability.
