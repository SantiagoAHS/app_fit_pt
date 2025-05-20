import 'package:flutter/material.dart';
import '../widgets/app_scaffold.dart';

class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      title: 'Ejecicios',
      body: Center(
        child: Text('Bienvenido a la pantalla de ejercicios'),
      ),
    );
  }
}