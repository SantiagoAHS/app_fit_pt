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
import 'screens/detalle_rutina.dart';

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
        scaffoldBackgroundColor: const Color(0xFFF2F3F4),
        primaryColor: const Color(0xFF2ECC71),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2ECC71),
          primary: const Color(0xFF2ECC71),
          secondary: const Color(0xFF27AE60),
          surface: const Color(0xFFF2F3F4),
          onPrimary: Colors.white,
          onSecondary: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF145A32),
          foregroundColor: Colors.white,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Color(0xFF1C2833)),
          titleLarge: TextStyle(
            color: Color(0xFF145A32),
            fontWeight: FontWeight.bold,
          ),
        ),
        drawerTheme: const DrawerThemeData(
          backgroundColor: Color(0xFFF2F3F4),
        ),
      ),

      // En vez de initialRoute, usamos home con StreamBuilder para decidir pantalla
      home: const AuthenticationWrapper(),

      routes: {
        '/inicio': (context) => const HomeScreen(),
        '/home': (context) => const HomeScreen(),
        '/estadisticas': (context) => const StaticsScreen(),
        '/ejercicios': (context) => const ExercisesScreen(),
        '/perfil': (context) => const ProfileScreen(),
        '/ayuda': (context) => const HelpScreen(),
        '/login': (context) => const LoginScreen(),
        '/detalle_rutina': (context) => const DetalleRutinaScreen(titulo: 'Rutina'),
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
