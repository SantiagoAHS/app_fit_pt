import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:permission_handler/permission_handler.dart';

class StepCounterWidget extends StatefulWidget {
  const StepCounterWidget({super.key});

  @override
  State<StepCounterWidget> createState() => _StepCounterWidgetState();
}

class _StepCounterWidgetState extends State<StepCounterWidget> {
  late Stream<StepCount> _stepCountStream;
  int _steps = 0;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? get userId => FirebaseAuth.instance.currentUser?.uid;

  @override
  void initState() {
    super.initState();
    _requestActivityPermission();

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(
      _onStepCount,
      onError: _onStepCountError,
      cancelOnError: true,
    );
  }

  Future<void> _requestActivityPermission() async {
    final status = await Permission.activityRecognition.status;

    if (!status.isGranted) {
      final result = await Permission.activityRecognition.request();
      if (result.isGranted) {
        debugPrint("Permiso ACTIVITY_RECOGNITION concedido ✅");
      } else {
        debugPrint("Permiso ACTIVITY_RECOGNITION denegado ❌");
      }
    } else {
      debugPrint("Permiso ACTIVITY_RECOGNITION ya otorgado 👍");
    }
  }

  void _onStepCount(StepCount event) async {
    if (userId == null) return;

    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final docId = '$userId-$today';
    final docRef = _firestore.collection('pasos_por_dia').doc(docId);
    final docSnapshot = await docRef.get();

    int sensorInicio;

    if (docSnapshot.exists && docSnapshot.data()!.containsKey('sensor_inicio')) {
      sensorInicio = docSnapshot['sensor_inicio'];
    } else {
      sensorInicio = event.steps;
      await docRef.set({
        'fecha': today,
        'usuario': userId,
        'sensor_inicio': sensorInicio,
        'timestamp': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    }

    final pasosDelDia = event.steps - sensorInicio;

    setState(() {
      _steps = pasosDelDia;
    });

    await docRef.set({
      'pasos': pasosDelDia,
      'timestamp': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  void _onStepCountError(error) {
    debugPrint('Error en el contador de pasos: $error');
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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
              'Pasos del día',
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
