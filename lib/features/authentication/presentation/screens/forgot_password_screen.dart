// TODO: Implement the password recovery screen.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared_widgets/app_button.dart';
import '../../../../shared_widgets/app_text_field.dart';
import '../../../../shared_widgets/spider_web_background.dart';
import '../../application/auth_controller.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  bool _loading = false;
  bool _sent = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      await ref
          .read(authControllerProvider.notifier)
          .sendPasswordReset(_emailCtrl.text.trim());
      if (!mounted) return;
      setState(() {
        _sent = true;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _loading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = ref.watch(appStringsProvider);
    return Scaffold(
      appBar: AppBar(title: Text(strings.resetPassword)),
      extendBodyBehindAppBar: true,
      body: SpiderWebBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.lg),
            child: _sent
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.mark_email_read_outlined, size: 72),
                        const SizedBox(height: AppSizes.md),
                        Text(
                          strings.resetLinkSent,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: AppSizes.lg),
                        AppButton(
                          label: strings.backToLogin,
                          outlined: true,
                          onPressed: () => context.go(RouteNames.login),
                        ),
                      ],
                    ),
                  )
                : Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: AppSizes.md),
                        Text(
                          strings.resetPassword,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: AppSizes.lg),
                        AppTextField(
                          label: strings.email,
                          controller: _emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: Icons.mail_outline,
                          validator: Validators.email,
                        ),
                        const SizedBox(height: AppSizes.md),
                        AppButton(
                          label: strings.sendResetLink,
                          isLoading: _loading,
                          onPressed: _submit,
                        ),
                        const SizedBox(height: AppSizes.md),
                        TextButton(
                          onPressed: () => context.go(RouteNames.login),
                          child: Text(strings.backToLogin),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}