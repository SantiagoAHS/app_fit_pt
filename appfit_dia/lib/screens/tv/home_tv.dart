import 'package:flutter/material.dart';

class HomeLargeLayout extends StatefulWidget {
  final String message;
  final bool visible;

  const HomeLargeLayout({
    super.key,
    required this.message,
    required this.visible,
  });

  @override
  State<HomeLargeLayout> createState() => _HomeLargeLayoutState();
}

class _HomeLargeLayoutState extends State<HomeLargeLayout> with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _animations;

  final List<IconData> _icons = [
    Icons.fitness_center,
    Icons.directions_run,
    Icons.self_improvement,
    Icons.sports_martial_arts,
  ];

  final List<Color> _colors = [
    Colors.deepPurple,
    Colors.teal,
    Colors.orange,
    Colors.blueAccent,
  ];

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(_icons.length, (index) {
      return AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1200),
      );
    });

    _animations = _controllers.map((controller) {
      return Tween<double>(begin: 1.0, end: 1.4).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOut),
      );
    }).toList();

    // Iniciar animaciones con retrasos escalonados para efecto secuencial
    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 400), () {
        if (mounted) {
          _controllers[i].repeat(reverse: true);
        }
      });
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
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
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_icons.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ScaleTransition(
                        scale: _animations[index],
                        child: Icon(_icons[index], color: _colors[index], size: 60),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 40),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    widget.message,
                    key: ValueKey(widget.message),
                    style: const TextStyle(
                      fontSize: 28,
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
