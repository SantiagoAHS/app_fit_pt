import 'package:flutter/material.dart';

class DetalleRutinaScreen extends StatelessWidget {
  final String titulo;

  const DetalleRutinaScreen({super.key, required this.titulo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titulo)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Duración: 45 minutos',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Nivel: Intermedio',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            const Text(
              'Ejercicios:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildEjercicio('1. Sentadillas', '3 series de 15 repeticiones'),
            _buildEjercicio('2. Lunges', '3 series de 12 por pierna'),
            _buildEjercicio('3. Peso muerto con mancuernas', '4 series de 10 repeticiones'),
            _buildEjercicio('4. Step-ups', '3 series de 12 repeticiones por pierna'),
            _buildEjercicio('5. Estiramientos', '10 minutos de enfriamiento'),
            const SizedBox(height: 24),
            const Text(
              'Recomendaciones:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '- Calienta antes de comenzar.\n'
              '- Hidrátate adecuadamente.\n'
              '- Mantén una buena postura durante cada ejercicio.\n'
              '- Escucha a tu cuerpo y descansa si lo necesitas.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildEjercicio(String nombre, String detalle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(nombre, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(detalle, style: const TextStyle(fontSize: 15)),
        ],
      ),
    );
  }
}
