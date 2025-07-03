import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'imc_chart.dart';

class IMCDisplay extends StatelessWidget {
  final bool showChart;
  const IMCDisplay({super.key, this.showChart = true});

  @override
  Widget build(BuildContext context) {
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
}
