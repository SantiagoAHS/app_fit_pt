import 'package:flutter/material.dart';
import '../../../widgets/step_counter_widget.dart';
import '../../../widgets/imc_display.dart';
import '../../../widgets/step_counter_weekly.dart';
import '../../../widgets/routines_complete.dart';

class StaticsMobileLayout extends StatelessWidget {
  const StaticsMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Bienvenido a la pantalla de estadísticas',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          const StepCounterWidget(),
          const SizedBox(height: 30),
          Card(
            elevation: 6,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: IMCDisplay(showChart: true),
            ),
          ),
          const SizedBox(height: 30),
          const Card(
            elevation: 6,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: WeeklyStepChart(),
            ),
          ),
          const SizedBox(height: 30),
          const Card(
            elevation: 6,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
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
