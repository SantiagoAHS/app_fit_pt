import 'package:flutter/material.dart';

class HelpMobileLayout extends StatelessWidget {
  const HelpMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final faqs = _getFaqs();

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: faqs.length,
      itemBuilder: (context, index) {
        final faq = faqs[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 12),
          child: ExpansionTile(
            title: Text(faq['question']!, style: const TextStyle(fontWeight: FontWeight.w600)),
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

  List<Map<String, String>> _getFaqs() => [
    {'question': '¿Cómo empiezo con mi primera rutina de ejercicio?', 'answer': 'Después de registrarte, dirígete a la sección “Rutinas” y selecciona la de tu agrado. Recomendamos comenzar con la rutina de principiantes si no has entrenado recientemente.'},
    {'question': '¿Puedo entrenar sin equipo?', 'answer': 'Sí, muchas de nuestras rutinas están diseñadas para realizarse en casa sin ningún equipo.'},
    {'question': '¿Cuántos días a la semana debo entrenar?', 'answer': 'Depende de tu nivel y tus objetivos. Para principiantes, recomendamos 3-4 días a la semana.'},
    {'question': '¿Qué pasa si me salto un día?', 'answer': 'No te preocupes, puedes retomar desde el día siguiente.'},
    {'question': '¿Cómo puedo llevar un seguimiento de mi progreso?', 'answer': 'En la sección "Estadísticas".'},
    {'question': '¿Por qué no puedo acceder a mis estadísticas?', 'answer': 'Debes primero ingresar tus datos en la sección "Perfil".'},
    {'question': '¿Alguna otra duda?', 'answer': 'Contáctanos al: "241-176-4468".'},
  ]; 
}
