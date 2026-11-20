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

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _loading = false;
  bool _agreed = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tafadhali kubali masharti ili kuendelea.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }
    
    setState(() => _loading = true);
    FocusScope.of(context).unfocus();

    await ref.read(authControllerProvider.notifier).register(
          fullName: _nameCtrl.text.trim(),
          email: _emailCtrl.text.trim(),
          phone: _phoneCtrl.text.trim(),
          password: _passCtrl.text,
        );
        
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
    final strings = ref.watch(appStringsProvider); // <-- Inahitaji app_strings.dart

    return Scaffold(
      appBar: AppBar(actions: const [ThemeToggleButton()]),
      extendBodyBehindAppBar: true,
      body: SpiderWebBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.lg),
            child: Column(
              children: [
                const AppLogo(size: 68, showText: false),
                const SizedBox(height: AppSizes.md),
                Text(
                  strings.createAccount,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: AppSizes.lg),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      AppTextField(
                        label: strings.fullName,
                        controller: _nameCtrl,
                        prefixIcon: Icons.person_outline,
                        validator: Validators.fullName,
                      ),
                      const SizedBox(height: AppSizes.md),
                      AppTextField(
                        label: strings.email,
                        controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icons.mail_outline,
                        validator: Validators.email,
                      ),
                      const SizedBox(height: AppSizes.md),
                      AppTextField(
                        label: strings.phone,
                        controller: _phoneCtrl,
                        keyboardType: TextInputType.phone,
                        prefixIcon: Icons.phone_outlined,
                        validator: Validators.phone,
                      ),
                      const SizedBox(height: AppSizes.md),
                      AppTextField(
                        label: strings.password,
                        controller: _passCtrl,
                        obscure: true,
                        prefixIcon: Icons.lock_outline,
                        validator: Validators.password,
                      ),
                      const SizedBox(height: AppSizes.md),
                      AppTextField(
                        label: strings.confirmPassword,
                        controller: _confirmCtrl,
                        obscure: true,
                        prefixIcon: Icons.lock_outline,
                        validator: (v) => Validators.confirmPassword(
                          v,
                          _passCtrl.text,
                        ),
                      ),
                      const SizedBox(height: AppSizes.sm),
                      CheckboxListTile(
                        value: _agreed,
                        onChanged: (v) => setState(() => _agreed = v ?? false),
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          strings.agreeTerms,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      const SizedBox(height: AppSizes.sm),
                      AppButton(
                        label: strings.register,
                        isLoading: _loading,
                        onPressed: _submit,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSizes.md),
                TextButton(
                  onPressed: () => context.go(RouteNames.login),
                  child: Text(strings.alreadyHaveAccount),
                ),
                const SizedBox(height: AppSizes.xxl), 
              ],
            ),
          ),
        ),
      ),
    );
  }
}