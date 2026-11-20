import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart'; // <-- Hii ilikuwa haipo
import '../../../../core/routing/route_names.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared_widgets/app_button.dart';
import '../../../../shared_widgets/app_logo.dart';
import '../../../../shared_widgets/app_text_field.dart';
import '../../../../shared_widgets/spider_web_background.dart';
import '../../../../shared_widgets/theme_toggle_button.dart';
import '../../application/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    
    FocusScope.of(context).unfocus();

    await ref
        .read(authControllerProvider.notifier)
        .signIn(_emailCtrl.text.trim(), _passCtrl.text);
        
    if (!mounted) return;
    setState(() => _loading = false);

    ref.read(authControllerProvider).when(
      data: (user) {
        if (user != null) {
          context.go(RouteNames.citizenHome);
        }
      },
      loading: () {},
      error: (e, _) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = ref.watch(appStringsProvider); // <-- Hii inahitaji import ya app_strings.dart

    return Scaffold(
      body: SpiderWebBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.lg),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [ThemeToggleButton()],
                ),
                const SizedBox(height: AppSizes.md),
                const AppLogo(size: 72),
                const SizedBox(height: AppSizes.xl),
                Text(
                  strings.login,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: AppSizes.lg),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      AppTextField(
                        label: strings.email,
                        controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icons.mail_outline,
                        validator: Validators.email,
                      ),
                      const SizedBox(height: AppSizes.md),
                      AppTextField(
                        label: strings.password,
                        controller: _passCtrl,
                        obscure: true,
                        prefixIcon: Icons.lock_outline,
                        validator: Validators.password,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _submit(),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () =>
                              context.push(RouteNames.forgotPassword),
                          child: Text(strings.forgotPassword),
                        ),
                      ),
                      const SizedBox(height: AppSizes.sm),
                      AppButton(
                        label: strings.login,
                        isLoading: _loading,
                        onPressed: _submit,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSizes.lg),
                TextButton(
                  onPressed: () => context.push(RouteNames.register),
                  child: Text(
                    '${strings.dontHaveAccount} ${strings.createAccount}',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}