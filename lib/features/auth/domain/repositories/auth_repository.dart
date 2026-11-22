import '../entities/app_user.dart';

abstract interface class AuthRepository {
  Stream<AppUser?> watchAuthState();
  Future<AppUser> signUpWithEmail({required String name, required String email, required String password, required String programme, required int year, required bool isTutor});
  Future<AppUser> signInWithEmail({required String email, required String password});
  Future<AppUser> signInWithGoogle();
  Future<void> sendPasswordReset(String email);
  Future<void> sendEmailVerification();
  Future<AppUser> refreshEmailVerification();
  Future<void> signOut();
}
