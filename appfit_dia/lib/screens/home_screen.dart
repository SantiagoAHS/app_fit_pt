import 'package:flutter/material.dart';
import '../widgets/app_scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      title: 'Inicio',
      body: Center(
        child: Text('Bienvenido a la pantalla de inicio'),
      ), appBarActions: [],
    );
  }
}
