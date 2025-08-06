import 'package:flutter/material.dart';

class DetalleRutinaScreen extends StatelessWidget {
  final String titulo;

  const DetalleRutinaScreen({super.key, required this.titulo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titulo)),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isLargeScreen = constraints.maxWidth > 800; // TV o tablet grande

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: isLargeScreen
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    // Título
                    Text(
                      titulo,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),

                    // Imagen centrada arriba
                    Center(child: _buildImagen(width: 300)),
                      const SizedBox(height: 32),
                      // Texto dividido en dos columnas
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Columna de ejercicios
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Duración: 45 minutos',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 12),
                                const Text('Nivel: Intermedio', style: TextStyle(fontSize: 16)),
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
                              ],
                            ),
                          ),
                          const SizedBox(width: 32),
                          // Columna de recomendaciones + botón
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                const SizedBox(height: 40),
                                Center(
                                  child: Column(
                                    children: [
                                      ElevatedButton.icon(
                                        icon: const Icon(Icons.logout, color: Colors.white),
                                        label: const Text('Regresar', style: TextStyle(color: Colors.white)),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                          textStyle: const TextStyle(fontSize: 20),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      const Text(
                                        'Gracias por entrenar con nosotros',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        titulo,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      _buildImagen(width: double.infinity),
                      const SizedBox(height: 16),
                      _buildTextContent(context),
                    ],
                  ),
          );
        },
      ),
    );
  }

  // Imagen con fondo blanco y ancho opcional
  Widget _buildImagen({double? width}) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(8.0),
      width: width,
      child: Image.asset(
        'assets/images/imagen_rutina.jpg',
        fit: BoxFit.contain,
      ),
    );
  }

  // Contenido móvil
  Widget _buildTextContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Duración: 45 minutos',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        const Text('Nivel: Intermedio', style: TextStyle(fontSize: 16)),
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
        const SizedBox(height: 32),
        Center(
          child: Column(
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text('Regresar', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  textStyle: const TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Gracias por entrenar con nosotros',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ],
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
