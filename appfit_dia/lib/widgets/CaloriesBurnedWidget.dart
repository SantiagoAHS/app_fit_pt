import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class CaloriesBurnedWidget extends StatelessWidget {
  const CaloriesBurnedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    if (userId == null) {
      return const Text('Usuario no autenticado');
    }

    final docId = '$userId-$today';
    final docRef = FirebaseFirestore.instance.collection('pasos_por_dia').doc(docId);

    return StreamBuilder<DocumentSnapshot>(
      stream: docRef.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Text('No hay datos disponibles');
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;
        final pasos = data['pasos'] ?? 0;
        final calorias = pasos * 0.04;

        // Guardamos las calorías en Firestore, si aún no están
        if (data['calorias_quemadas'] != calorias) {
          docRef.set({'calorias_quemadas': calorias}, SetOptions(merge: true));
        }

        return Card(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Calorías quemadas',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  calorias.toStringAsFixed(2),
                  style: const TextStyle(
                      fontSize: 36,
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 5),
                const Text('kcal'),
              ],
            ),
          ),
        );
      },
    );
  }
}
