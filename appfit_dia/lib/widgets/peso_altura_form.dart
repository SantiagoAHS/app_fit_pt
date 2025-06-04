import 'package:flutter/material.dart';

class PesoAlturaForm extends StatelessWidget {
  final TextEditingController pesoController;
  final TextEditingController alturaController;
  final TextEditingController pesoIdealController; // agregado
  final bool isLoading;
  final VoidCallback onSave;

  const PesoAlturaForm({
    super.key,
    required this.pesoController,
    required this.alturaController,
    required this.pesoIdealController, // agregado
    required this.isLoading,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: pesoController,
          decoration: const InputDecoration(labelText: 'Peso (kg)'),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 10),
        TextField(
          controller: alturaController,
          decoration: const InputDecoration(labelText: 'Altura (cm)'),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 10),
        TextField(
          controller: pesoIdealController, // nuevo campo
          decoration: const InputDecoration(labelText: 'Peso ideal (kg)'),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
        isLoading
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: onSave,
                child: const Text('Guardar datos'),
              ),
      ],
    );
  }
}
