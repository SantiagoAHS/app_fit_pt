import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:appfit_dia/screens/watch/login_watch.dart';
import 'package:appfit_dia/screens/mobile/login_mobile.dart';
import 'package:appfit_dia/screens/tv/login_tv.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;

  void _login() async {
    setState(() => _isLoading = true);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.message}')),
      );
    }

    if (!mounted) return;
    setState(() => _isLoading = false);
  }

  Future<void> _signInWithGoogle() async {
    setState(() => _isLoading = true);

    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        setState(() => _isLoading = false);
        return;
      }

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al iniciar sesión con Google: $e')),
      );
    }

    if (!mounted) return;
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 300) {
      return LoginWatchLayout(
        emailController: emailController,
        passwordController: passwordController,
        isLoading: _isLoading,
        onLogin: _login,
        onGoogleSignIn: _signInWithGoogle,
      );
    } else if (screenWidth < 600) {
      return LoginMobileLayout(
        emailController: emailController,
        passwordController: passwordController,
        isLoading: _isLoading,
        onLogin: _login,
        onGoogleSignIn: _signInWithGoogle,
      );
    } else {
      return LoginLargeLayout(
        emailController: emailController,
        passwordController: passwordController,
        isLoading: _isLoading,
        onLogin: _login,
        onGoogleSignIn: _signInWithGoogle,
      );
    }
  }
}
