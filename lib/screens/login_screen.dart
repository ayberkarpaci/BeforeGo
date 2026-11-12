import 'package:flutter/material.dart';

import '../routes.dart';
import '../widgets/placeholder_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: const PlaceholderBody(
        owner: 'Umut',
        links: [
          PlaceholderLink('Log in', AppRoutes.home, clearStack: true),
          PlaceholderLink('Forgot password?', AppRoutes.forgotPassword),
          PlaceholderLink('Sign up', AppRoutes.signUp),
        ],
      ),
    );
  }
}
