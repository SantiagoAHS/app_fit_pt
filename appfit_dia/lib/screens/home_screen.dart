import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/app_scaffold.dart';
import 'package:appfit_dia/screens/watch/home_watch.dart';
import 'package:appfit_dia/screens/tv/home_tv.dart';
import 'package:appfit_dia/screens/mobile/home_mobile.dart';

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
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) {
        setState(() => _visible = true);
      }
    });

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted) {
        setState(() {
          _currentMessageIndex = (_currentMessageIndex + 1) % _messages.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isVerySmallScreen = screenWidth < 300;
    final isSmallScreen = screenWidth < 600;

    return AppScaffold(
      title: 'Inicio',
      appBarActions: const [],
      body: isVerySmallScreen
          ? HomeWatchLayout(
              message: _messages[_currentMessageIndex],
              visible: _visible,
            )
          : isSmallScreen
              ? HomeMobileLayout(
                  message: _messages[_currentMessageIndex],
                  visible: _visible,
                )
              : HomeLargeLayout(
                  message: _messages[_currentMessageIndex],
                  visible: _visible,
                ),
    );
  }
}
