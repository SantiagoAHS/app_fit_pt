import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/app_scaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _messages = [
    '¡Bienvenido a FitApp!',
    'Activa tu cuerpo. Renueva tu mente.',
    'Cada paso cuenta.',
    'Tu rutina comienza ahora.',
  ];

  int _currentMessageIndex = 0;
  bool _visible = false;

  @override
  void initState() {
    super.initState();

    // Primera animación
    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() => _visible = true);
    });

    // Cambiar frases cada 3 segundos
    Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _currentMessageIndex = (_currentMessageIndex + 1) % _messages.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isVerySmallScreen = screenWidth < 300;
    final isSmallScreen = screenWidth < 600;

    return AppScaffold(
      title: 'Inicio',
      body: isVerySmallScreen
          ? _buildVerySmallLayout()
          : isSmallScreen
              ? _buildMobileLayout()
              : _buildLargeScreenLayout(),
      appBarActions: const [],
    );
  }

  Widget _buildVerySmallLayout() {
    return SafeArea(
      child: Center(
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 800),
          opacity: _visible ? 1.0 : 0.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    _messages[_currentMessageIndex],
                    key: ValueKey(_messages[_currentMessageIndex]),
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

  Widget _buildMobileLayout() {
    return const Center(
      child: Text(
        'Bienvenido a la pantalla de inicio',
        style: TextStyle(fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildLargeScreenLayout() {
    return const Center(
      child: Text(
        'Bienvenido a la pantalla de inicio en una pantalla grande',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }
}
