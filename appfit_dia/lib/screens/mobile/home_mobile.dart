import 'dart:async';
import 'package:flutter/material.dart';

class HomeMobileLayout extends StatefulWidget {
  final String message;
  final bool visible;

  const HomeMobileLayout({super.key, required this.message, required this.visible});

  @override
  State<HomeMobileLayout> createState() => _HomeMobileLayoutState();
}

class _HomeMobileLayoutState extends State<HomeMobileLayout> {
  final List<IconData> _icons = [
    Icons.directions_walk,
    Icons.fitness_center,
    Icons.favorite,
    Icons.accessibility_new,
  ];

  int _highlightedIconIndex = 0;
  Timer? _iconTimer;

  @override
  void initState() {
    super.initState();

    _iconTimer = Timer.periodic(const Duration(milliseconds: 600), (timer) {
      if (mounted) {
        setState(() {
          _highlightedIconIndex = (_highlightedIconIndex + 1) % _icons.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _iconTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 800),
          opacity: widget.visible ? 1.0 : 0.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Fila de iconos animados
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_icons.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(
                        _icons[index],
                        size: 40, // más grande
                        color: _highlightedIconIndex == index ? Colors.green : Colors.grey[400],
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 16),

                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    widget.message,
                    key: ValueKey(widget.message),
                    style: const TextStyle(
                      fontSize: 22, // más grande
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
