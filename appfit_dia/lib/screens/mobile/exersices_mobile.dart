// archivo: lib/screens/exercises/mobile_layout.dart
import 'package:flutter/material.dart';
import '../../widgets/routine_card.dart';

class ExercisesMobileLayout extends StatelessWidget {
  final List<Map<String, String>> routines;
  final List<bool> selected;
  final Function(int, bool) onChanged;

  const ExercisesMobileLayout({
    super.key,
    required this.routines,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
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
            onChanged: (value) => onChanged(index, value),
          );
        },
      ),
    );
  }
}
