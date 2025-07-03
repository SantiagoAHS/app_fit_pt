import 'package:flutter/material.dart';
import '../../../widgets/step_counter_widget.dart';
import '../../../widgets/imc_display.dart';
import '../../../widgets/step_counter_weekly.dart';
import '../../../widgets/routines_complete.dart';

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
           StepCounterWidget(),
           SizedBox(height: 30),
           Card(
            elevation: 6,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Padding(
              padding: EdgeInsets.all(32),
              child: IMCDisplay(showChart: true),
            ),
          ),
           SizedBox(height: 30),
           Card(
            elevation: 6,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Padding(
              padding: EdgeInsets.all(32),
              child: WeeklyStepChart(),
            ),
          ),
           SizedBox(height: 30),
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
