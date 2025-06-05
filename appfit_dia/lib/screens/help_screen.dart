import 'package:flutter/material.dart';
import '../widgets/app_scaffold.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isVerySmallScreen = screenWidth < 300;
    final isSmallScreen = screenWidth < 600;

    return AppScaffold(
      title: 'Ayuda',
      body: isVerySmallScreen
          ? _buildVerySmallLayout()
          : isSmallScreen
              ? _buildMobileLayout()
              : _buildLargeScreenLayout(),
      appBarActions: const [],
    );
  }

  Widget _buildVerySmallLayout() {
    return const Center(
      child: Text(
        'Ayuda (pantalla muy pequeña)',
        style: TextStyle(fontSize: 12),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildMobileLayout() {
    final faqs = [
    {
      'question': '¿Cómo empiezo con mi primera rutina de ejercicio?',
      'answer': 'Después de registrarte, dirígete a la sección “Rutinas” y selecciona la de tu agrado. Recomendamos comenzar con la rutina de principiantes si no has entrenado recientemente.',
    },
    {
      'question':'¿Puedo entrenar sin equipo?',
      'answer':'Sí, muchas de nuestras rutinas están diseñadas para realizarse en casa sin ningún equipo.',
    },
    {
      'question':'¿Cuántos días a la semana debo entrenar?',
      'answer':'Depende de tu nivel y tus objetivos. Para principiantes, recomendamos 3-4 días a la semana. Los intermedios o avanzados pueden entrenar 5-6 días.',
    },
    {
      'question':'¿Qué pasa si me salto un día?',
      'answer':'No te preocupes, la consistencia es más importante que la perfección. Puedes retomar desde el día siguiente sin problema.',
    },
    {
      'question':'¿Cómo puedo llevar un seguimiento de mi progreso?',
      'answer':'Puedes acceder a la sección de "Estadisticas" para ver un seguimiento de tu progeso.',
    },
    {
      'question': '¿Por qué no puedo acceder a mis estadisticas?',
      'answer': 'Para acceder a tus estadisticas personales debes primero ingresar tus datos en la sección de "Perfil"',
    },
    {
      'question':'¿Alguna otra duda?',
      'answer':'Contactanos al: "241-176-4468"',
    }
    

    ];

  return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: faqs.length,
      itemBuilder: (context, index) {
        final faq = faqs[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 12),
          child: ExpansionTile(
            title: Text(
              faq['question']!,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(faq['answer']!),
              ),
            ],
          ),
        );
      },
    );
  }
  

  Widget _buildLargeScreenLayout() {
    return const Center(
      child: Text(
        'Bienvenido a la pantalla de ayuda (pantalla grande)',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }
}
