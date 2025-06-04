import 'package:flutter/material.dart';
import '../widgets/app_scaffold.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/imc_chart.dart';


class StaticsScreen extends StatelessWidget {
  const StaticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isVerySmallScreen = screenWidth < 300;
    final isSmallScreen = screenWidth < 600;

    return AppScaffold(
      title: 'Estadísticas',
      body: isVerySmallScreen
          ? _buildVerySmallLayout()
          : isSmallScreen
              ? _buildMobileLayout()
              : _buildLargeScreenLayout(),
      appBarActions: const [],
    );
  }

  Widget _buildIMCDisplay({bool showChart = true}) {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return const Text('Usuario no autenticado');
  }

  return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
    stream: FirebaseFirestore.instance.collection('users').doc(user.uid).snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData || !snapshot.data!.exists) {
        return const Text('Datos no disponibles');
      }

      final data = snapshot.data!.data()!;
      final peso = (data['peso'] as num?)?.toDouble();
      final altura = (data['altura'] as num?)?.toDouble();

      if (peso == null || altura == null || altura == 0) {
        return const Text('Peso o altura no válidos');
      }

      final alturaMetros = altura > 3 ? altura / 100 : altura;
      final imc = peso / (alturaMetros * alturaMetros);

      String clasificacion;
      if (imc < 18.5) {
        clasificacion = 'Bajo peso';
      } else if (imc < 25) {
        clasificacion = 'Normal';
      } else if (imc < 30) {
        clasificacion = 'Sobrepeso';
      } else {
        clasificacion = 'Obesidad';
      }

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('IMC: ${imc.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 6),
          Text('Clasificación: $clasificacion', style: const TextStyle(fontSize: 16)),
          if (showChart) ...[
            const SizedBox(height: 20),
            IMCChart(imc: imc),
          ]
        ],
      );
    },
  );
}

  Widget _buildVerySmallLayout() {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Estadísticas', style: TextStyle(fontSize: 14)),
          const SizedBox(height: 10),
          _buildIMCDisplay(showChart: false),
        ],
      ),
    ),
  );
}


  Widget _buildMobileLayout() {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Bienvenido a la pantalla de estadisticas',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        _buildIMCDisplay(showChart: true),
      ],
    ),
  );
}

Widget _buildLargeScreenLayout() {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(32),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Bienvenido a la pantalla de estadisticas',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        _buildIMCDisplay(showChart: true),
      ],
    ),
  );
}

}

