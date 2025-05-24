import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Importa tus pantallas
import 'screens/home_screen.dart';
import 'screens/statistics_screen.dart';
import 'screens/exercises_screen.dart';
import 'screens/help_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/login_screen.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Inicializa Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mi App con Menú',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFc8d7e6),
        primaryColor: const Color(0xFF3691f6),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3691f6),
          primary: const Color(0xFF3691f6),
          secondary: const Color(0xFF78bcf5),
          surface: const Color(0xFFc8d7e6),
          onPrimary: Colors.white,
          onSecondary: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF053f7e),
          foregroundColor: Colors.white,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Color(0xFF797a87)),
          titleLarge: TextStyle(
            color: Color(0xFF053f7e),
            fontWeight: FontWeight.bold,
          ),
        ),
        drawerTheme: const DrawerThemeData(
          backgroundColor: Color(0xFFc8d7e6),
        ),
      ),

      // En vez de initialRoute, usamos home con StreamBuilder para decidir pantalla
      home: const AuthenticationWrapper(),

      routes: {
        '/inicio': (context) => const HomeScreen(),
        '/estadisticas': (context) => const StaticsScreen(),
        '/ejercicios': (context) => const ExercisesScreen(),
        '/perfil': (context) => const ProfileScreen(),
        '/ayuda': (context) => const HelpScreen(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}

// Widget que muestra pantalla según estado de autenticación
class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Si está cargando
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Si el usuario está logueado, muestra la pantalla principal
        if (snapshot.hasData) {
          return const HomeScreen();
        }

        // Si no está logueado, muestra la pantalla de login
        return const LoginScreen();
      },
    );
  }
}
