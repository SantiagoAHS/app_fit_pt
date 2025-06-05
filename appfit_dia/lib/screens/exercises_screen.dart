import 'package:flutter/material.dart';
import '../widgets/app_scaffold.dart';

class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({super.key});

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

  Widget _buildVerySmallLayout() {
    final List<Map<String, String>> routines = [
      {'title': 'Barbell Rows', 'time': '10 Minutes', 'reps': '3 Rep'},
      {'title': 'Push Ups', 'time': '8 Minutes', 'reps': '4 Rep'},
      {'title': 'Plank Hold', 'time': '5 Minutes', 'reps': '2 Rep'},
      {'title': 'Squats', 'time': '12 Minutes', 'reps': '5 Rep'},
      {'title': 'Deadlifts', 'time': '15 Minutes', 'reps': '4 Rep'},
    ];

    return SafeArea(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        itemCount: routines.length,
        itemBuilder: (context, index) {
          final routine = routines[index];
          return Container(
            width: double.infinity,
            height: 160,
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFe0f0ff),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                Text(
                  routine['title'] ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.timer, size: 14, color: Colors.blue),
                    const SizedBox(width: 4),
                    Text(routine['time'] ?? '', style: const TextStyle(fontSize: 12)),
                    const SizedBox(width: 12),
                    const Icon(Icons.fitness_center, size: 14, color: Colors.purple),
                    const SizedBox(width: 4),
                    Text(routine['reps'] ?? '', style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMobileLayout() {
    final List<Map<String, String>> routines = [
      {'title': 'Barbell Rows', 'time': '10 Minutes', 'reps': '3 Rep'},
      {'title': 'Push Ups', 'time': '8 Minutes', 'reps': '4 Rep'},
      {'title': 'Plank Hold', 'time': '5 Minutes', 'reps': '2 Rep'},
      {'title': 'Squats', 'time': '12 Minutes', 'reps': '5 Rep'},
      {'title': 'Deadlifts', 'time': '15 Minutes', 'reps': '4 Rep'},
    ];

    return SafeArea(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        itemCount: routines.length,
        itemBuilder: (context, index) {
          final routine = routines[index];
          return Container(
            width: double.infinity,
            height: 180,
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFd0eaff),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Text(
                  routine['title'] ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.timer, size: 16, color: Colors.blue),
                    const SizedBox(width: 6),
                    Text(routine['time'] ?? '', style: const TextStyle(fontSize: 14)),
                    const SizedBox(width: 16),
                    const Icon(Icons.fitness_center, size: 16, color: Colors.purple),
                    const SizedBox(width: 6),
                    Text(routine['reps'] ?? '', style: const TextStyle(fontSize: 14)),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLargeScreenLayout() {
    final List<Map<String, String>> routines = [
      {'title': 'Barbell Rows', 'time': '10 Minutes', 'reps': '3 Rep'},
      {'title': 'Push Ups', 'time': '8 Minutes', 'reps': '4 Rep'},
      {'title': 'Plank Hold', 'time': '5 Minutes', 'reps': '2 Rep'},
      {'title': 'Squats', 'time': '12 Minutes', 'reps': '5 Rep'},
      {'title': 'Deadlifts', 'time': '15 Minutes', 'reps': '4 Rep'},
    ];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
        child: ListView.builder(
          itemCount: routines.length,
          itemBuilder: (context, index) {
            final routine = routines[index];
            return Container(
              width: double.infinity,
              height: 200,
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFcce5ff),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.black.withOpacity(0.07),
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Text(
                    routine['title'] ?? '',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.timer, size: 20, color: Colors.blue),
                      const SizedBox(width: 8),
                      Text(routine['time'] ?? '', style: const TextStyle(fontSize: 16)),
                      const SizedBox(width: 20),
                      const Icon(Icons.fitness_center, size: 20, color: Colors.purple),
                      const SizedBox(width: 8),
                      Text(routine['reps'] ?? '', style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
