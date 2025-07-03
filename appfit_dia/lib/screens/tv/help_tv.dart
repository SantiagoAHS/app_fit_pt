import 'package:flutter/material.dart';

class HelpLargeLayout extends StatelessWidget {
  const HelpLargeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final faqs = _getFaqs();

    return Center(
      child: Container(
        width: 800,
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        child: ListView.builder(
          itemCount: faqs.length,
          itemBuilder: (context, index) {
            final faq = faqs[index];
            return Card(
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ExpansionTile(
                title: Text(
                  faq['question']!,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(faq['answer']!, style: const TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            );
          },
        ),
      ),
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
