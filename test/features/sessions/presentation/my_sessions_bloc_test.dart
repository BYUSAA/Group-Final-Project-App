import 'package:flutter_test/flutter_test.dart';
import 'package:studylink/features/sessions/domain/entities/session.dart';

void main() {
  test('session status values cover the booking lifecycle', () {
    expect(SessionStatus.values.map((s) => s.name), containsAll(['confirmed','cancelled','completed']));
  });
}
