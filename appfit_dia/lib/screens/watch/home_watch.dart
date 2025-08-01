import 'dart:async';
import 'package:flutter/material.dart';


class HomeWatchLayout extends StatefulWidget {
  final String message;
  final bool visible;

  const HomeWatchLayout({
    super.key,
    required this.message,
    required this.visible,
  });

  @override
  State<HomeWatchLayout> createState() => _HomeWatchLayoutState();
}

class _HomeWatchLayoutState extends State<HomeWatchLayout> {
  final List<IconData> icons = [
    Icons.favorite,
    Icons.directions_walk,
    Icons.local_fire_department,
    Icons.bolt,
  ];

  int _currentIndex = 0;
  late Timer _iconTimer;

  @override
  void initState() {
    super.initState();
    _iconTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % icons.length;
      });
    });
  }

  @override
  void dispose() {
    _iconTimer.cancel();
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
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: Icon(
                    icons[_currentIndex],
                    key: ValueKey(_currentIndex),
                    size: 40,
                    color: Colors.green.shade900,
                  ),
                ),
                const SizedBox(height: 12),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    widget.message,
                    key: ValueKey(widget.message),
                    style: const TextStyle(
                      fontSize: 12,
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
