import 'package:flutter/material.dart';

class PesoAlturaForm extends StatelessWidget {
  final TextEditingController pesoController;
  final TextEditingController alturaController;
  final TextEditingController pesoIdealController;
  final bool isLoading;
  final VoidCallback onSave;

  const PesoAlturaForm({
    super.key,
    required this.pesoController,
    required this.alturaController,
    required this.pesoIdealController,
    required this.isLoading,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final isSmallScreen = screenWidth < 300; 

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView( // Importante para evitar overflow
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInputField('Peso (kg)', pesoController, isSmallScreen),
            const SizedBox(height: 10),
            _buildInputField('Altura (cm)', alturaController, isSmallScreen),
            const SizedBox(height: 10),
            _buildInputField('Peso ideal (kg)', pesoIdealController, isSmallScreen),
            const SizedBox(height: 16),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: onSave,
                    style: ElevatedButton.styleFrom(
                      padding: isSmallScreen
                          ? const EdgeInsets.symmetric(vertical: 8, horizontal: 4)
                          : null,
                      textStyle: TextStyle(fontSize: isSmallScreen ? 12 : 16),
                    ),
                    child: const Text('Guardar datos'),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller, bool isSmallScreen) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        contentPadding: EdgeInsets.symmetric(
          vertical: isSmallScreen ? 6 : 12,
          horizontal: isSmallScreen ? 8 : 16,
        ),
      ),
      style: TextStyle(fontSize: isSmallScreen ? 12 : 16),
      keyboardType: TextInputType.number,
    );
  }
}
