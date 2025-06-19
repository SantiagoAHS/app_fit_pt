import 'package:flutter/material.dart';

class RoutineCard extends StatelessWidget {
  final String title;
  final String time;
  final String reps;
  final double height;
  final double fontSize;
  final double iconSize;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final List<BoxShadow> boxShadow;
  final bool isSelected;
  final ValueChanged<bool> onChanged;

  const RoutineCard({
    super.key,
    required this.title,
    required this.time,
    required this.reps,
    required this.height,
    required this.fontSize,
    required this.iconSize,
    required this.padding,
    required this.backgroundColor,
    required this.boxShadow,
    required this.isSelected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!isSelected), // Cambiar estado al tocar
      child: Container(
        height: height,
        margin: const EdgeInsets.only(bottom: 16),
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: boxShadow,
          border: Border.all(
            color: isSelected ? Colors.green : Colors.transparent,
            width: 2,
          ),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.timer, size: iconSize, color: Colors.blue),
                    const SizedBox(width: 6),
                    Text(time, style: TextStyle(fontSize: fontSize - 2)),
                    const SizedBox(width: 16),
                    Icon(Icons.fitness_center, size: iconSize, color: Colors.purple),
                    const SizedBox(width: 6),
                    Text(reps, style: TextStyle(fontSize: fontSize - 2)),
                  ],
                ),
              ],
            ),
            if (isSelected)
              const Positioned(
                top: 8,
                right: 8,
                child: Icon(Icons.check_circle, color: Colors.green, size: 24),
              ),
          ],
        ),
      ),
    );
  }
}
