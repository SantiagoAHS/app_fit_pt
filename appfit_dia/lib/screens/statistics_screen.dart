import 'package:flutter/material.dart';
import '../widgets/app_scaffold.dart';

class StaticsScreen extends StatelessWidget {
  const StaticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      title: 'Estadisticas',
      body: Center(
        child: Text('Bienvenido a la pantalla de estadísticas'),
      ),
    );
  }
}
