// archivo: lib/screens/exercises/very_small_layout.dart
import 'package:flutter/material.dart';
import '../../widgets/routine_card.dart';

class ExercisesWatchLayout extends StatelessWidget {
  final List<Map<String, String>> routines;
  final List<bool> selected;
  final Function(int, bool) onChanged;

  const ExercisesWatchLayout({
    super.key,
    required this.routines,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            itemCount: routines.length,
            itemBuilder: (context, index) {
              final routine = routines[index];

              return ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: constraints.maxWidth,
                ),
                child: RoutineCard(
                  title: routine['title']!,
                  time: routine['time']!,
                  reps: routine['reps']!,
                  height: 120,
                  fontSize: 12,
                  iconSize: 12,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  backgroundColor: const Color(0xFFe0f0ff),
                  boxShadow: const [],
                  isSelected: selected[index],
                  onChanged: (value) => onChanged(index, value),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
