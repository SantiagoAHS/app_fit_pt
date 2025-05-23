import 'package:flutter/material.dart';
import '../widgets/app_scaffold.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      title: 'Perfil',
      body: Center(
        child: Text('Bienvenido a tu perfil'),
      ),
    );
  }
}