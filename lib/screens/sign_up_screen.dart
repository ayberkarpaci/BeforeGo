import 'package:flutter/material.dart';

import '../routes.dart';
import '../widgets/placeholder_body.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: const PlaceholderBody(
        owner: 'Umut',
        links: [
          PlaceholderLink('Create account', AppRoutes.home, clearStack: true),
          PlaceholderLink('Log in', AppRoutes.login),
        ],
      ),
    );
  }
}
