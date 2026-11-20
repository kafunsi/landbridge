import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/auth_repository.dart';
import '../data/firebase_auth_repository.dart';
import '../domain/auth_user.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => FirebaseAuthRepository(FirebaseAuth.instance),
);

final authStateProvider = StreamProvider<AuthUser?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
});

class AuthController extends StateNotifier<AsyncValue<AuthUser?>> {
  final AuthRepository _repo;
  final FirebaseFirestore _firestore;

  AuthController(this._repo, this._firestore)
      : super(const AsyncValue.data(null));

  Future<AuthUser> _fetchUserFromFirestore(User user) async {
    try {
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        final data = doc.data()!;
        return AuthUser(
          uid: user.uid,
          email: user.email,
          displayName: data['fullName'] ?? user.displayName,
          phone: data['phone'],
          role: data['role'] ?? 'citizen',
        );
      } else {
        return AuthUser(
          uid: user.uid,
          email: user.email,
          displayName: user.displayName,
          role: 'citizen',
        );
      }
    } catch (e) {
      return AuthUser(
        uid: user.uid,
        email: user.email,
        displayName: user.displayName,
        role: 'citizen',
      );
    }
  }

  Future<void> signIn(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      // Hapa tulikuwa tunahifadhi 'user' lakini hatukuutumia, ndio maana kulikuwa na warning.
      // Sasa tunasubiri tu signIn ikamilike.
      await _repo.signIn(email: email, password: password);
      
      final firebaseUser = FirebaseAuth.instance.currentUser!;
      final userWithRole = await _fetchUserFromFirestore(firebaseUser);
      
      state = AsyncValue.data(userWithRole);
    } catch (e, st) {
      state = AsyncValue.error(_mapAuthError(e), st);
    }
  }

  Future<void> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    try {
      final user = await _repo.register(
        fullName: fullName,
        email: email,
        phone: phone,
        password: password,
      );

      await _firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'fullName': fullName,
        'email': email,
        'phone': phone,
        'role': 'citizen', 
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Hapa tunatumia copyWith kuhakikisha tunaongeza phone na role kwenye state yetu
      state = AsyncValue.data(
        user.copyWith(role: 'citizen', phone: phone),
      );
    } catch (e, st) {
      state = AsyncValue.error(_mapAuthError(e), st);
    }
  }

  Future<void> sendPasswordReset(String email) async {
    await _repo.sendPasswordReset(email);
  }

  Future<void> signOut() async {
    await _repo.signOut();
    state = const AsyncValue.data(null);
  }

  Object _mapAuthError(Object e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'user-not-found':
          return 'No account was found for the provided email.';
        case 'wrong-password':
        case 'invalid-credential':
          return 'Incorrect email or password.';
        case 'email-already-in-use':
          return 'An account already exists with this email.';
        case 'invalid-email':
          return 'Please enter a valid email address.';
        case 'weak-password':
          return 'Password is too weak. Use at least 6 characters.';
        case 'network-request-failed':
          return 'Network error. Please check your connection.';
        default:
          return e.message ?? 'Authentication failed.';
      }
    }
    return e.toString();
  }
}

final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<AuthUser?>>((ref) {
  return AuthController(
    ref.watch(authRepositoryProvider),
    FirebaseFirestore.instance,
  );
});