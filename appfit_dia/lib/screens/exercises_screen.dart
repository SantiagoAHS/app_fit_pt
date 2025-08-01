import 'package:flutter/material.dart';
import '../widgets/app_scaffold.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:appfit_dia/screens/mobile/exersices_mobile.dart';
import 'package:appfit_dia/screens/watch/exercises_watch.dart';
import 'package:appfit_dia/screens/tv/exercieses_tv.dart';

class ExercisesScreen extends StatefulWidget {
  const ExercisesScreen({super.key});

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  final List<Map<String, String>> routines = const [
    {'title': 'Barbell Rows', 'time': '45 Minutes', 'reps': '3 Rep'},
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

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? get userId => FirebaseAuth.instance.currentUser?.uid;

  Future<void> _guardarRutinaCompletada(int index, bool isCompleted) async {
    if (userId == null) return;

    final rutina = routines[index];
    final docRef = _firestore.collection('rutinas_completadas').doc('$userId-${rutina['title']}');

    if (isCompleted) {
      await docRef.set({
        'title': rutina['title'],
        'time': rutina['time'],
        'reps': rutina['reps'],
        'completedAt': FieldValue.serverTimestamp(),
      });
    } else {
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

  void _onChanged(int index, bool value) async {
    setState(() {
      selected[index] = value;
    });
    await _guardarRutinaCompletada(index, value);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isVerySmallScreen = screenWidth < 300;
    final isSmallScreen = screenWidth < 600;

    return AppScaffold(
      title: 'Ejercicios',
      body: isVerySmallScreen
          ? ExercisesWatchLayout(routines: routines, selected: selected, onChanged: _onChanged)
          : isSmallScreen
              ? ExercisesMobileLayout(routines: routines, selected: selected, onChanged: _onChanged)
              : ExercisesLargeScreenLayout(routines: routines, selected: selected, onChanged: _onChanged),
      appBarActions: const [],
    );
  }
}
