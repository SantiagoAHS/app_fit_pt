import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final String title;
  final Widget body;

  const AppScaffold({Key? key, required this.title, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentRoute = ModalRoute.of(context)?.settings.name ?? '';
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 300;

    void navigateTo(String routeName) {
      if (currentRoute != routeName) {
        Navigator.pushReplacementNamed(context, routeName);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontSize: isSmallScreen ? 16 : 20,
          ),
        ),
        backgroundColor: theme.appBarTheme.backgroundColor,
        actions: isSmallScreen
            ? [
                PopupMenuButton<String>(
                  onSelected: navigateTo,
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem(value: '/inicio', child: Text('Inicio')),
                    const PopupMenuItem(value: '/estadisticas', child: Text('Estadísticas')),
                    const PopupMenuItem(value: '/ejercicios', child: Text('Ejercicios')),
                    const PopupMenuItem(value: '/perfil', child: Text('Perfil')),
                    const PopupMenuItem(value: '/ayuda', child: Text('Ayuda')),
                  ],
                  icon: const Icon(Icons.menu, color: Colors.white),
                ),
              ]
            : null,
      ),
      drawer: isSmallScreen
          ? null
          : Drawer(
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
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Inicio'),
                    onTap: () => navigateTo('/inicio'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.bar_chart),
                    title: const Text('Estadísticas'),
                    onTap: () => navigateTo('/estadisticas'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.fitness_center),
                    title: const Text('Ejercicios'),
                    onTap: () => navigateTo('/ejercicios'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.help),
                    title: const Text('Ayuda'),
                    onTap: () => navigateTo('/ayuda'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Perfil'),
                    onTap: () => navigateTo('/perfil'),
                  ),
                ],
              ),
            ),
      body: Padding(
        padding: EdgeInsets.all(isSmallScreen ? 8 : 16),
        child: body,
      ),
    );
  }
}
