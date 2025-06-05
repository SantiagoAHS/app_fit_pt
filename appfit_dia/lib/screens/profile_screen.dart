import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/peso_altura_form.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController alturaController = TextEditingController();
  final TextEditingController pesoIdealController = TextEditingController(); // agregado
  bool _isLoading = false;

  Future<void> _signOut() async {
  await FirebaseAuth.instance.signOut();

  if (!mounted) return;

  Navigator.of(context).pushNamedAndRemoveUntil(
    '/login',
    (Route<dynamic> route) => false,
  );
}

  Future<void> _saveData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final double? peso = double.tryParse(pesoController.text);
    final double? altura = double.tryParse(alturaController.text);
    final double? pesoIdeal = double.tryParse(pesoIdealController.text); // agregado

    if (peso == null || altura == null || pesoIdeal == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Datos inválidos')),
      );
      return;
    }

    setState(() => _isLoading = true);

    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'peso': peso,
      'altura': altura,
      'peso_ideal': pesoIdeal, // agregado
    }, SetOptions(merge: true));

    setState(() => _isLoading = false);
  }

  Widget _buildDataDisplay(String uid) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Text('No hay datos registrados');
        }

        final data = snapshot.data!.data()!;
        final peso = data['peso']?.toString() ?? 'N/A';
        final altura = data['altura']?.toString() ?? 'N/A';
        final pesoIdeal = data['peso_ideal']?.toString() ?? 'N/A'; // agregado

        return Column(
          children: [
            Text('Peso: $peso kg'),
            Text('Altura: $altura m'),
            Text('Peso ideal: $pesoIdeal kg'), // agregado
          ],
        );
      },
    );
  }

  Widget _buildForm() {
    return PesoAlturaForm(
      pesoController: pesoController,
      alturaController: alturaController,
      pesoIdealController: pesoIdealController, // agregado
      isLoading: _isLoading,
      onSave: _saveData,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isVerySmallScreen = screenWidth < 300;
    final isSmallScreen = screenWidth < 600;

    return AppScaffold(
      title: 'Perfil',
      body: isVerySmallScreen
          ? _buildVerySmallLayout()
          : isSmallScreen
              ? _buildMobileLayout()
              : _buildLargeScreenLayout(),
      appBarActions: const [],
    );
  }

  Widget _buildVerySmallLayout() {
  final user = FirebaseAuth.instance.currentUser;
  final email = user?.email ?? 'Correo no disponible';
  final uid = user?.uid ?? '';

  return SafeArea(
    child: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Perfil',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            email,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          ),
          const SizedBox(height: 10),
          _buildDataDisplay(uid), // Asegúrate de que este widget sea compacto
          const SizedBox(height: 10),
          _buildForm(), // Ajusta dentro de este widget los paddings y tamaños también
          const SizedBox(height: 12),
          ElevatedButton.icon(
            icon: const Icon(Icons.logout, size: 14),
            label: const Text('Salir', style: TextStyle(fontSize: 10)),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 6),
            ),
            onPressed: _signOut,
          ),
        ],
      ),
    ),
  );
}


  Widget _buildMobileLayout() {
    final user = FirebaseAuth.instance.currentUser;
    final email = user?.email ?? 'Correo no disponible';
    final uid = user?.uid ?? '';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Bienvenido a tu perfil', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 8),
          Text(email, style: const TextStyle(fontSize: 16, color: Colors.grey)),
          const SizedBox(height: 20),
          _buildDataDisplay(uid),
          const SizedBox(height: 20),
          _buildForm(),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            icon: const Icon(Icons.logout),
            label: const Text('Cerrar sesión'),
            onPressed: _signOut,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLargeScreenLayout() {
    final user = FirebaseAuth.instance.currentUser;
    final email = user?.email ?? 'Correo no disponible';
    final uid = user?.uid ?? '';

    return Center(
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade50,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 6))
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Bienvenido a tu perfil',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(email, style: const TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(height: 20),
              _buildDataDisplay(uid),
              const SizedBox(height: 20),
              _buildForm(),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.logout),
                label: const Text('Cerrar sesión'),
                onPressed: _signOut,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
