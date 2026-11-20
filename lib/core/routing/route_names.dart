// TODO: Define application route names.
class RouteNames {
  RouteNames._();
  static const splash = '/';
  static const welcome = '/welcome';
  static const login = '/login';
  static const register = '/register';
  static const forgotPassword = '/forgot-password';

  // Placeholders for future phases (used by auth redirect logic)
  static const citizenHome = '/citizen-home';
  static const officerHome = '/officer-home';
  static const adminHome = '/admin-home';
}