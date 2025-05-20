import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final String title;
  final Widget body;

  const AppScaffold({Key? key, required this.title, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentRoute = ModalRoute.of(context)?.settings.name ?? '';

    // Función para crear ListTiles con estado seleccionado
    Widget buildDrawerItem({
      required String title,
      required String routeName,
      IconData? icon,
    }) {
      final bool selected = currentRoute == routeName;
      return ListTile(
        leading: icon != null ? Icon(icon, color: selected ? theme.colorScheme.primary : null) : null,
        title: Text(
          title,
          style: TextStyle(
            color: selected ? theme.colorScheme.primary : null,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        selected: selected,
        selectedTileColor: theme.colorScheme.primary.withOpacity(0.1), // Fondo suave
        onTap: () {
          if (!selected) {
            Navigator.pushReplacementNamed(context, routeName);
          } else {
            Navigator.pop(context); // Solo cierra el drawer si ya estás en la ruta
          }
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
        ),
        backgroundColor: theme.appBarTheme.backgroundColor,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              color: theme.primaryColor,
              padding: const EdgeInsets.all(16),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Menú',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            buildDrawerItem(title: 'Inicio', routeName: '/inicio', icon: Icons.home),
            buildDrawerItem(title: 'Estadísticas', routeName: '/estadisticas', icon: Icons.bar_chart),
            buildDrawerItem(title: 'Ejercicios', routeName: '/ejercicios', icon: Icons.fitness_center),
            buildDrawerItem(title: 'Ayuda', routeName: '/ayuda', icon: Icons.help),
          ],
        ),
      ),
      body: body,
    );
  }
}
