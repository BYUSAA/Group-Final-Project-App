import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:studylink/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:studylink/features/auth/presentation/pages/sign_in_page.dart';
import '../../../helpers/mocks.dart';

void main() {
  testWidgets('sign in page displays email and password fields', (tester) async {
    final bloc = AuthBloc(MockAuthRepository());
    await tester.pumpWidget(MaterialApp(home: BlocProvider.value(value: bloc, child: const SignInPage())));
    expect(find.text('ALU email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Sign in'), findsOneWidget);
    await bloc.close();
  });
}
