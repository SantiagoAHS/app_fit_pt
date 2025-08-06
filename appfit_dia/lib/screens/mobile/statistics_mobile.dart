import 'package:flutter/material.dart';
import '../../../widgets/step_counter_widget.dart';
import '../../../widgets/imc_display.dart';
import '../../../widgets/step_counter_weekly.dart';
import '../../../widgets/routines_complete.dart';
import '../../../widgets/CaloriesBurnedWidget.dart';

class StaticsMobileLayout extends StatelessWidget {
  const StaticsMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Bienvenido a la pantalla de estadísticas',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 28, 86, 30),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),

          // Subtítulo Step Counter - centrado
          Align(
            alignment: Alignment.center,
            child: Text(
              'Contador de pasos',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.green.shade700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
          const StepCounterWidget(),

          const SizedBox(height: 10),
           const Text(
            'Calorías Quemadas',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.green),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          const CaloriesBurnedWidget(),

          // Subtítulo IMC - centrado
          Align(
            alignment: Alignment.center,
            child: Text(
              'Índice de Masa Corporal (IMC)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.green.shade700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
          Card(
            elevation: 6,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: IMCDisplay(showChart: true),
            ),
          ),

          const SizedBox(height: 30),

          // Subtítulo Weekly Steps - centrado
          Align(
            alignment: Alignment.center,
            child: Text(
              'Pasos semanales',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.green.shade700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
          // Aquí quitamos la card externa porque el widget ya es una card
          const WeeklyStepChart(),

          const SizedBox(height: 30),

          // Subtítulo Rutinas completadas - centrado
          Align(
            alignment: Alignment.center,
            child: Text(
              'Rutinas completadas',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.green.shade700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
          const Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: RoutinesComplete(),
            ),
          ),
        ],
      ),
    );
  }
}
