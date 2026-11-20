import 'package:firebase_auth/firebase_auth.dart';
import '../domain/auth_user.dart';
import 'auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _auth;
  
  FirebaseAuthRepository(this._auth);

  @override
  Stream<AuthUser?> get authStateChanges => _auth.authStateChanges().map(
        (u) => u == null
            ? null
            : AuthUser(
                uid: u.uid,
                email: u.email,
                displayName: u.displayName,
                role: 'citizen', // Inapewa role ya msingi hapa
              ),
      );

  @override
  AuthUser? get currentUser {
    final u = _auth.currentUser;
    if (u == null) return null;
    return AuthUser(
      uid: u.uid, 
      email: u.email, 
      displayName: u.displayName,
      role: 'citizen', // Inapewa role ya msingi hapa
    );
  }

  @override
  Future<AuthUser> signIn({
    required String email,
    required String password,
  }) async {
    final cred = await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    final u = cred.user!;
    return AuthUser(
      uid: u.uid, 
      email: u.email, 
      displayName: u.displayName,
      role: 'citizen', // Inapewa role ya msingi hapa (AuthController itasoma role halisi kwenye Firestore)
    );
  }

  @override
  Future<AuthUser> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    final user = cred.user!;
    
    // Hifadhi jina kwenye Firebase Auth
    await user.updateDisplayName(fullName.trim());
    await user.reload();
    
    return AuthUser(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      phone: phone, // Tumeongeza hii
      role: 'citizen', // Inapewa role ya msingi hapa
    );
  }

  @override
  Future<void> signOut() => _auth.signOut();

  @override
  Future<void> sendPasswordReset(String email) =>
      _auth.sendPasswordResetEmail(email: email.trim());
}