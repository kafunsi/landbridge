// TODO: Define the authentication repository interface.
import '../domain/auth_user.dart';

abstract class AuthRepository {
  Stream<AuthUser?> get authStateChanges;
  AuthUser? get currentUser;
  Future<AuthUser> signIn({required String email, required String password});
  Future<AuthUser> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  });
  Future<void> signOut();
  Future<void> sendPasswordReset(String email);
}