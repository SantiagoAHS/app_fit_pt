import 'package:flutter/material.dart';
import '../../../widgets/step_counter_read.dart'; // Aquí importamos el widget que solo lee pasos desde Firestore
import '../../../widgets/routines_complete.dart';
import '../../../widgets/imc_display.dart';

class StaticsWatchLayout extends StatelessWidget {
  const StaticsWatchLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Estadísticas',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),

          // Aquí mostramos los pasos desde Firestore, ideal para smartwatch/emuladores sin sensor
          const StepsFromFirestoreWidget(),

          const SizedBox(height: 10),
          // Tarjeta de IMC
          Card(
            elevation: 6,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.monitor_weight, size: 16, color: Colors.green),
                      SizedBox(width: 4),
                      Text(
                        'Índice de Masa Corporal',
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  IMCDisplay(showChart: false),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Tarjeta de rutinas completadas
          Card(
            elevation: 6,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.fitness_center, size: 16, color: Colors.green),
                      SizedBox(width: 4),
                      Text(
                        'Rutinas Completadas',
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  RoutinesComplete(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
