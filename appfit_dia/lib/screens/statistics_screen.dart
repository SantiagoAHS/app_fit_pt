import 'package:flutter/material.dart';
import '../widgets/app_scaffold.dart';
import 'package:appfit_dia/screens/mobile/statistics_mobile.dart';
import 'package:appfit_dia/screens/watch/statistics_watch.dart';
import 'package:appfit_dia/screens/tv/statistics_tv.dart';

class StaticsScreen extends StatelessWidget {
  const StaticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isVerySmallScreen = screenWidth < 300;
    final isSmallScreen = screenWidth < 600;

    return AppScaffold(
      title: 'Estadísticas',
      appBarActions: const [],
      body: isVerySmallScreen
          ? const StaticsWatchLayout()
          : isSmallScreen
              ? const StaticsMobileLayout()
              : const StaticsLargeLayout(),
    );
  }
}
