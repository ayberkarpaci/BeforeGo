import 'package:flutter/material.dart';

import '../routes.dart';
import '../widgets/placeholder_body.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password')),
      body: const PlaceholderBody(
        owner: 'Doğukan',
        links: [
          PlaceholderLink('Back to log in', AppRoutes.login, clearStack: true),
        ],
      ),
    );
  }
}
