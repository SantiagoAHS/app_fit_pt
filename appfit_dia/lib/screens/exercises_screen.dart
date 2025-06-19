import 'package:flutter/material.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/routine_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ExercisesScreen extends StatefulWidget {
  const ExercisesScreen({super.key});

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  final List<Map<String, String>> routines = const [
    {'title': 'Barbell Rows', 'time': '10 Minutes', 'reps': '3 Rep'},
    {'title': 'Push Ups', 'time': '8 Minutes', 'reps': '4 Rep'},
    {'title': 'Plank Hold', 'time': '5 Minutes', 'reps': '2 Rep'},
    {'title': 'Squats', 'time': '12 Minutes', 'reps': '5 Rep'},
    {'title': 'Deadlifts', 'time': '15 Minutes', 'reps': '4 Rep'},
  ];

  late List<bool> selected;

  @override
  void initState() {
    super.initState();
    selected = List.generate(routines.length, (_) => false);
    _cargarRutinasCompletadas();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isVerySmallScreen = screenWidth < 300;
    final isSmallScreen = screenWidth < 600;

    return AppScaffold(
      title: 'Ejercicios',
      body: isVerySmallScreen
          ? _buildVerySmallLayout()
          : isSmallScreen
              ? _buildMobileLayout()
              : _buildLargeScreenLayout(),
      appBarActions: const [],
    );
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? get userId => FirebaseAuth.instance.currentUser?.uid;

  Future<void> _guardarRutinaCompletada(int index, bool isCompleted) async {
    if (userId == null) return;

    final rutina = routines[index];
    final docRef = _firestore.collection('rutinas_completadas').doc('$userId-${rutina['title']}');

    if (isCompleted) {
      // Guardar rutina completada
      await docRef.set({
        'title': rutina['title'],
        'time': rutina['time'],
        'reps': rutina['reps'],
        'completedAt': FieldValue.serverTimestamp(),
      });
    } else {
      // Eliminar rutina si se desmarca
      await docRef.delete();
    }
  }

  Future<void> _cargarRutinasCompletadas() async {
  if (userId == null) return;

  final querySnapshot = await _firestore
      .collection('rutinas_completadas')
      .where(FieldPath.documentId, whereIn: routines.map((r) => '$userId-${r['title']}').toList())
      .get();

  final completedDocs = querySnapshot.docs.map((doc) => doc.id).toSet();

  setState(() {
    for (int i = 0; i < routines.length; i++) {
      final docId = '$userId-${routines[i]['title']}';
      selected[i] = completedDocs.contains(docId);
    }
  });
}

  Widget _buildVerySmallLayout() {
    return SafeArea(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        itemCount: routines.length,
        itemBuilder: (context, index) {
          final routine = routines[index];
          return RoutineCard(
            title: routine['title']!,
            time: routine['time']!,
            reps: routine['reps']!,
            height: 160,
            fontSize: 14,
            iconSize: 14,
            padding: const EdgeInsets.all(10),
            backgroundColor: const Color(0xFFe0f0ff),
            boxShadow: const [],
            isSelected: selected[index],
            onChanged: (value) async {
            setState(() {
              selected[index] = value;
            });
            await _guardarRutinaCompletada(index, value);
          },
          );
        },
      ),
    );
  }

  Widget _buildMobileLayout() {
    return SafeArea(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        itemCount: routines.length,
        itemBuilder: (context, index) {
          final routine = routines[index];
          return RoutineCard(
            title: routine['title']!,
            time: routine['time']!,
            reps: routine['reps']!,
            height: 180,
            fontSize: 16,
            iconSize: 16,
            padding: const EdgeInsets.all(14),
            backgroundColor: const Color(0xFFd0eaff),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 3),
              ),
            ],
            isSelected: selected[index],
            onChanged: (value) async {
            setState(() {
              selected[index] = value;
            });
            await _guardarRutinaCompletada(index, value);
          },
          );
        },
      ),
    );
  }

  Widget _buildLargeScreenLayout() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
        child: ListView.builder(
          itemCount: routines.length,
          itemBuilder: (context, index) {
            final routine = routines[index];
            return RoutineCard(
              title: routine['title']!,
              time: routine['time']!,
              reps: routine['reps']!,
              height: 200,
              fontSize: 20,
              iconSize: 20,
              padding: const EdgeInsets.all(20),
              backgroundColor: const Color(0xFFcce5ff),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.07),
                  blurRadius: 6,
                  offset: const Offset(0, 4),
                ),
              ],
              isSelected: selected[index],
              onChanged: (value) async {
              setState(() {
                selected[index] = value;
              });
              await _guardarRutinaCompletada(index, value);
            },
            );
          },
        ),
      ),
    );
  }
}
