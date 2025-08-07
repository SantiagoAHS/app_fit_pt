import 'package:flutter/material.dart';
import '../../../widgets/imc_display.dart';
import '../../../widgets/step_counter_weekly.dart';
import '../../../widgets/routines_complete.dart';
import '../../../widgets/CaloriesBurnedWidget.dart';
import '../../../widgets/step_counter_readtv.dart';

class StaticsLargeLayout extends StatelessWidget {
  const StaticsLargeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Bienvenido a la pantalla de estadísticas',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 20),

          // Subtítulo para Step Counter
          Text(
            'Contador de Pasos',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          StepsFromtvFirestoreWidget(),

           Text(
            'Calorías Quemadas',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
          CaloriesBurnedWidget(),

          // Subtítulo para IMC
          Text(
            'Índice de Masa Corporal (IMC)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          Card(
            elevation: 6,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Padding(
              padding: EdgeInsets.all(32),
              child: IMCDisplay(showChart: true),
            ),
          ),

          SizedBox(height: 30),

          // Subtítulo para Weekly Step Chart
          Text(
            'Pasos Semanales',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          Padding(
            padding: EdgeInsets.all(32),
            child: WeeklyStepChart(),
          ),

          SizedBox(height: 30),

          // Subtítulo para Rutinas Completadas
          Text(
            'Rutinas Completadas',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          Card(
            elevation: 6,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Padding(
              padding: EdgeInsets.all(32),
              child: RoutinesComplete(),
            ),
          ),
        ],
      ),
    );
  }
}
