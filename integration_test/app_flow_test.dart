import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:studylink/app/app.dart';
import 'package:studylink/features/auth/data/auth_repository.dart';

class _FakeAuthRepository implements AuthRepository {
  @override
  Future<AuthProfile> signIn({required String email, required String password}) async =>
      AuthProfile(uid: 'student-1', name: 'Integration Student', email: email, programme: 'Software Eng.', year: 2, isTutor: false);

  @override
  Future<AuthProfile> signUp({
    required String name,
    required String email,
    required String password,
    required String programme,
    required int year,
    required bool isTutor,
  }) async =>
      AuthProfile(uid: 'student-1', name: name, email: email, programme: programme, year: year, isTutor: isTutor);

  @override
  Future<void> sendPasswordReset(String email) async {}

  @override
  Future<void> signOut() async {}
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('student can sign in, search subjects and open a tutor', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(ProviderScope(
      overrides: [authRepositoryProvider.overrideWithValue(_FakeAuthRepository())],
      child: const StudyLinkApp(),
    ));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'student@alustudent.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'password123');
    await tester.tap(find.widgetWithText(FilledButton, 'Sign in'));
    await tester.pumpAndSettle();
    expect(find.text('Your next session'), findsOneWidget);

    await tester.tap(find.text('Find'));
    await tester.pumpAndSettle();
    expect(find.text('Find help'), findsOneWidget);

    await tester.tap(find.text('Data Structures & Algorithms').first);
    await tester.pumpAndSettle();
    expect(find.textContaining('peer tutors'), findsOneWidget);

    await tester.tap(find.text('Kevin Habimana').first);
    await tester.pumpAndSettle();
    expect(find.text('CAN HELP WITH'), findsOneWidget);
  });
}
