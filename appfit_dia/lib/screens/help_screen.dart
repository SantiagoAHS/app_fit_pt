import 'package:flutter/material.dart';
import '../widgets/app_scaffold.dart';
import 'package:appfit_dia/screens/tv/help_tv.dart';
import 'package:appfit_dia/screens/watch/help_watch.dart';
import 'package:appfit_dia/screens/mobile/help_mobile.dart';

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
          ? const HelpWatchLayout()
          : isSmallScreen
              ? const HelpMobileLayout()
              : const HelpLargeLayout(),
      appBarActions: const [],
    );
  }
}
