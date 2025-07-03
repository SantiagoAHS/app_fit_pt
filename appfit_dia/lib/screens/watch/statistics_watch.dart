import 'package:flutter/material.dart';
import '../../../widgets/step_counter_widget.dart';
import '../../../widgets/routines_complete.dart';
import '../../../widgets/imc_display.dart'; // deberías crear este widget como se sugirió antes

class StaticsWatchLayout extends StatelessWidget {
  const StaticsWatchLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Estadísticas', style: TextStyle(fontSize: 14)),
          const SizedBox(height: 10),
          const StepCounterWidget(),
          const SizedBox(height: 20),
          Card(
            elevation: 6,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: IMCDisplay(showChart: false),
            ),
          ),
          const SizedBox(height: 20),
          Card(
            elevation: 6,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: RoutinesComplete(),
            ),
          ),
        ],
      ),
    );
  }
}
