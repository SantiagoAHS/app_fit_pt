import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StepsFromtvFirestoreWidget extends StatefulWidget {
  const StepsFromtvFirestoreWidget({super.key});

  @override
  State<StepsFromtvFirestoreWidget> createState() => _StepsFromtvFirestoreWidgetState();
}

class _StepsFromtvFirestoreWidgetState extends State<StepsFromtvFirestoreWidget> {
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
    return Center(
      child: Card(
        elevation: 6,
        margin: const EdgeInsets.all(24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 40),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.directions_walk, color: Colors.green, size: 64),
              const SizedBox(width: 40),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Pasos hoy',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _loading
                      ? const SizedBox(
                          height: 48,
                          width: 48,
                          child: CircularProgressIndicator(strokeWidth: 4),
                        )
                      : Text(
                          (_steps?.toString() ?? '0'),
                          style: TextStyle(
                            fontSize: 64,
                            color: Colors.green.shade800,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
