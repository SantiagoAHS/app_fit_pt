import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/statistics_screen.dart';
import 'screens/exercises_screen.dart';
import 'screens/help_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi App con Menú',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFc8d7e6), // Fondo: color5
        primaryColor: const Color(0xFF3691f6),             // color1
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3691f6),             // color1
          primary: const Color(0xFF3691f6),               // color1
          secondary: const Color(0xFF78bcf5),             // color2
          background: const Color(0xFFc8d7e6),            // color5
          onPrimary: Colors.white,
          onSecondary: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF053f7e),             // color3
          foregroundColor: Colors.white,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Color(0xFF797a87)), // color4
          titleLarge: TextStyle(
            color: Color(0xFF053f7e),                     // color3
            fontWeight: FontWeight.bold,
          ),
        ),
        drawerTheme: const DrawerThemeData(
          backgroundColor: Color(0xFFc8d7e6), // Fondo: color5
        ),
      ),
      initialRoute: '/inicio',
      routes: {
        '/inicio': (context) => const HomeScreen(),
        '/estadisticas': (context) => const StaticsScreen(),
        '/ejercicios': (context) => const ExercisesScreen(),
        '/ayuda': (context) => const HelpScreen(),
      },
    );
  }
}
