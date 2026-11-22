import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:studylink/features/auth/domain/entities/app_user.dart';
import 'package:studylink/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:studylink/features/auth/presentation/bloc/auth_event.dart';
import 'package:studylink/features/auth/presentation/bloc/auth_state.dart';
import '../../../helpers/mocks.dart';

void main() {
  late MockAuthRepository repository;
  late AuthBloc bloc;
  setUp(() {
    repository = MockAuthRepository();
    bloc = AuthBloc(repository);
  });
  tearDown(() async => bloc.close());

  test('sign-in success emits authenticated state', () async {
    const user = AppUser(uid: 'u1', name: 'Aline', email: 'aline@alustudent.com', programme: 'Software Engineering', year: 2, isTutor: false, emailVerified: true);
    when(() => repository.signInWithEmail(email: any(named: 'email'), password: any(named: 'password'))).thenAnswer((_) async => user);
    final expectation = expectLater(bloc.stream, emitsInOrder([isA<AuthLoading>(), isA<AuthAuthenticated>()]));
    bloc.add(const SignInRequested('aline@alustudent.com', 'password123'));
    await expectation;
  });
}
