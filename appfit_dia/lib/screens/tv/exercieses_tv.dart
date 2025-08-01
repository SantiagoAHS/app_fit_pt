import 'package:flutter/material.dart';
import '../../widgets/routine_card.dart';

class ExercisesLargeScreenLayout extends StatelessWidget {
  final List<Map<String, String>> routines;
  final List<bool> selected;
  final Function(int, bool) onChanged;

  const ExercisesLargeScreenLayout({
    super.key,
    required this.routines,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Decide el número de columnas según ancho (por ejemplo, 3 columnas para pantallas muy grandes)
    int crossAxisCount = 2;
    if (screenWidth > 1200) {
      crossAxisCount = 3;
    } else if (screenWidth > 900) {
      crossAxisCount = 2;
    } else {
      crossAxisCount = 1;
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 3 / 2,  // Ancho / Alto (ajusta según tu card)
          ),
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
              onChanged: (value) => onChanged(index, value),
            );
          },
        ),
      ),
    );
  }
}
