class AuthUser {
  final String uid;
  final String? email;
  final String? displayName;
  final String role;
  final String? phone;

  const AuthUser({
    required this.uid,
    this.email,
    this.displayName,
    this.role = 'citizen',
    this.phone,
  });

  AuthUser copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? role,
    String? phone,
  }) {
    return AuthUser(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      role: role ?? this.role,
      phone: phone ?? this.phone,
    );
  }
}