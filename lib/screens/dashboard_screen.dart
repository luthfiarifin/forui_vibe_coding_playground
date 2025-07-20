import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../widgets/layout/header.dart';
import '../widgets/layout/main_content.dart';

/// Main dashboard screen for the Smart City Energy Tracker
/// This screen provides a comprehensive overview of city energy metrics,
/// charts, alerts, and system status in a mobile-first responsive layout
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      childPad: false,
      child: Column(
        children: [
          const Header(),
          const Expanded(child: MainContent()),
        ],
      ),
    );
  }
}

// Export alias for backward compatibility with main.dart
typedef Application = DashboardScreen;
