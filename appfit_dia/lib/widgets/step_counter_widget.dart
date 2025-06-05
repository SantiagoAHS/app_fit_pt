import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';

class StepCounterWidget extends StatefulWidget {
  const StepCounterWidget({super.key});

  @override
  State<StepCounterWidget> createState() => _StepCounterWidgetState();
}

class _StepCounterWidgetState extends State<StepCounterWidget> {
  late Stream<StepCount> _stepCountStream;
  int _steps = 0;

  @override
  void initState() {
    super.initState();
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(
      _onStepCount,
      onError: _onStepCountError,
      cancelOnError: true,
    );
  }

  void _onStepCount(StepCount event) {
    setState(() {
      _steps = event.steps;
    });
  }

  void _onStepCountError(error) {
    debugPrint('Error en el contador de pasos: $error');
  }

  @override
Widget build(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;

  // Definir tamaños responsivos
  final margin = screenWidth < 400 ? 12.0 : 24.0;
  final verticalPadding = screenWidth < 400 ? 20.0 : 40.0;
  final horizontalPadding = screenWidth < 400 ? 15.0 : 30.0;
  final titleFontSize = screenWidth < 400 ? 18.0 : 24.0;
  final stepsFontSize = screenWidth < 400 ? 32.0 : 48.0;

  return Card(
    elevation: 6,
    margin: EdgeInsets.all(margin),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Pasos Contados',
            style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Text(
            '$_steps',
            style: TextStyle(fontSize: stepsFontSize, color: Colors.blueAccent),
          ),
        ],
      ),
    ),
  );
}
}
