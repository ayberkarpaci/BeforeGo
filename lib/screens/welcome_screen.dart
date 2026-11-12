import 'package:flutter/material.dart';

import '../routes.dart';
import '../widgets/placeholder_body.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome')),
      body: const PlaceholderBody(
        owner: 'Umut',
        links: [
          PlaceholderLink('Log in', AppRoutes.login),
          PlaceholderLink('Create an account', AppRoutes.signUp),
        ],
      ),
    );
  }
}
