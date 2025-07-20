import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(const SmartCityEnergyApp());
}

class SmartCityEnergyApp extends StatelessWidget {
  const SmartCityEnergyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = FThemes.zinc.dark;

    return MaterialApp(
      title: 'Smart City Energy Tracker',
      debugShowCheckedModeBanner: false,
      supportedLocales: FLocalizations.supportedLocales,
      localizationsDelegates: const [...FLocalizations.localizationsDelegates],
      builder: (_, child) => FTheme(data: theme, child: child!),
      theme: theme.toApproximateMaterialTheme(),
      home: const DashboardScreen(),
    );
  }
}
