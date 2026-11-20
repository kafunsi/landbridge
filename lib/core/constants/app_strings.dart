import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Lightweight bilingual scaffold.
/// Phase 1 exposes EN + SW strings for auth-related screens.
/// Later phases can expand or swap for flutter_localizations.
class AppStrings {
  final String languageCode;
  const AppStrings(this.languageCode);

  bool get _sw => languageCode == 'sw';

  String get appName => _sw
      ? 'Landbridge - Mfumo wa Malalamiko ya Ardhi'
      : 'Landbridge - Land Complaints System';

  String get appNameShort => 'Landbridge';

  String get welcomeTitle =>
      _sw ? 'Karibu Landbridge' : 'Welcome to Landbridge';

  String get welcomeSubtitle => _sw
      ? 'Wasilisha malalamiko ya ardhi na mali, ambatanisha vielelezo, na fuatilia maendeleo kwa wakati halisi.'
      : 'Report land and property complaints, attach evidence, and track progress in real time.';

  String get getStarted => _sw ? 'Anza' : 'Get Started';
  String get alreadyHaveAccount =>
      _sw ? 'Tayari una akaunti?' : 'Already have an account?';
  String get createAccount => _sw ? 'Sajili Akaunti' : 'Create Account';
  String get login => _sw ? 'Ingia' : 'Login';
  String get register => _sw ? 'Sajili' : 'Register';
  String get logout => _sw ? 'Toka' : 'Logout';
  String get forgotPassword => _sw ? 'Umesahau nenosiri?' : 'Forgot Password?';
  String get resetPassword => _sw ? 'Weka upya nenosiri' : 'Reset Password';
  String get resetLinkSent => _sw
      ? 'Kiungo cha kuweka upya nenosiri kimetumwa kwenye barua pepe yako.'
      : 'A password reset link has been sent to your email.';
  String get email => _sw ? 'Barua Pepe' : 'Email';
  String get password => _sw ? 'Nenosiri' : 'Password';
  String get confirmPassword =>
      _sw ? 'Thibitisha Nenosiri' : 'Confirm Password';
  String get fullName => _sw ? 'Jina Kamili' : 'Full Name';
  String get phone => _sw ? 'Namba ya Simu' : 'Phone Number';
  String get settings => _sw ? 'Mipangilio' : 'Settings';
  String get theme => _sw ? 'Mandhari' : 'Theme';
  String get light => _sw ? 'Nuru' : 'Light';
  String get dark => _sw ? 'Giza' : 'Dark';
  String get language => _sw ? 'Lugha' : 'Language';
  String get english => 'English';
  String get kiswahili => 'Kiswahili';
  String get dontHaveAccount =>
      _sw ? 'Hauna akaunti?' : "Don't have an account?";
  String get sendResetLink => _sw ? 'Tuma Kiungo' : 'Send Reset Link';
  String get backToLogin => _sw ? 'Rudi kwenye kuingia' : 'Back to Login';
  String get agreeTerms => _sw
      ? 'Nakubali masharti na sera za faragha'
      : 'I agree to the Terms & Privacy Policy';
}

class AppLanguageController extends StateNotifier<String> {
  AppLanguageController() : super('en');

  void toggle() => state = state == 'en' ? 'sw' : 'en';
}

final appLanguageProvider =
    StateNotifierProvider<AppLanguageController, String>((ref) {
  return AppLanguageController();
});

final appStringsProvider = Provider<AppStrings>((ref) {
  return AppStrings(ref.watch(appLanguageProvider));
});
