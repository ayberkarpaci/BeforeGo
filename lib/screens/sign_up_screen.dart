import 'package:flutter/material.dart';

import '../routes.dart';
import '../utils/app_spacing.dart';
import '../utils/app_text_styles.dart';
import '../widgets/app_text_field.dart';
import '../widgets/primary_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _createAccount() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.home,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: AppSpacing.page,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('Create account', style: AppTextStyles.title),
                    const SizedBox(height: AppSpacing.lg),
                    AppTextField(
                      label: 'Full name',
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    AppTextField(
                      label: 'Email',
                      hint: 'you@example.com',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    AppTextField(
                      label: 'Password',
                      controller: _passwordController,
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    AppTextField(
                      label: 'Confirm password',
                      controller: _confirmController,
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    PrimaryButton(
                      label: 'Create account',
                      onPressed: _createAccount,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account?',
                          style: AppTextStyles.body,
                        ),
                        TextButton(
                          onPressed: () => Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.login,
                          ),
                          child: const Text('Log in'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
