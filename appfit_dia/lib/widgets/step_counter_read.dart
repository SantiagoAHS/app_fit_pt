import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StepsFromFirestoreWidget extends StatefulWidget {
  const StepsFromFirestoreWidget({super.key});

  @override
  State<StepsFromFirestoreWidget> createState() => _StepsFromFirestoreWidgetState();
}

class _StepsFromFirestoreWidgetState extends State<StepsFromFirestoreWidget> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? get userId => FirebaseAuth.instance.currentUser?.uid;

  int? _steps;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadSteps();
  }

  Future<void> _loadSteps() async {
    if (userId == null) {
      debugPrint("Usuario no autenticado, userId es null");
      setState(() {
        _steps = null;
        _loading = false;
      });
      return;
    }

    final String today = DateTime.now().toLocal().toIso8601String().substring(0, 10);
    debugPrint('Fecha actual detectada: $today');

    try {
      final querySnapshot = await _firestore
          .collection('pasos_por_dia')
          .where('usuario', isEqualTo: userId)
          .where('fecha', isEqualTo: today)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;
        final data = doc.data();
        debugPrint("Documento encontrado: ${doc.id}, data: $data");

        if (data.containsKey('pasos')) {
          final pasosRaw = data['pasos'];
          int pasosInt;
          if (pasosRaw is int) {
            pasosInt = pasosRaw;
          } else if (pasosRaw is double) {
            pasosInt = pasosRaw.toInt();
          } else {
            pasosInt = 0;
          }

          setState(() {
            _steps = pasosInt;
            _loading = false;
          });
          return;
        }
      } else {
        debugPrint("No se encontró documento con usuario=$userId y fecha=$today");
      }

      setState(() {
        _steps = 0;
        _loading = false;
      });
    } catch (e) {
      debugPrint('Error leyendo pasos: $e');
      setState(() {
        _steps = 0;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.directions_walk, color: Colors.green, size: 24),
            const SizedBox(width: 8),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pasos hoy',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                _loading
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(
                        (_steps?.toString() ?? '0'),
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.green.shade800,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
