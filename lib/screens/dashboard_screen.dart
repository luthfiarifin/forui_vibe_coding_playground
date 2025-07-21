import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../widgets/layout/header.dart';
import '../widgets/layout/main_content.dart';
import '../widgets/layout/bottom_navigation.dart';

/// Main dashboard screen for the Smart City Energy Tracker
/// This screen provides a comprehensive overview of city energy metrics,
/// charts, alerts, and system status in a mobile-first responsive layout
/// TODO: Implement routing to other sections when navigation is tapped
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentNavIndex = 0; // Dashboard tab is active

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      childPad: false,
      child: Builder(
        builder: (context) {
          return Column(
            children: [
              const Header(),
              const Expanded(child: MainContent()),
              BottomNavigation(
                currentIndex: _currentNavIndex,
                onTap: (index) => _handleNavigationTap(index, context),
              ),
            ],
          );
        },
      ),
    );
  }

  // V1: Dashboard is the only implemented screen
  void _handleNavigationTap(int index, BuildContext context) {
    // If the index is the same as the current index, do nothing
    if (index == _currentNavIndex) {
      return;
    }

    // Get the section name from navigation items
    final sectionName = BottomNavigation.navItems[index].label;

    // Show toast feedback for unimplemented sections
    // TODO: Replace with actual navigation routing in future versions
    _showNavigationFeedback(context, sectionName);
  }

  void _showNavigationFeedback(BuildContext context, String sectionName) {
    // V1: Simple feedback for demo purposes using ForUI toast
    // Following the same pattern as quick_actions.dart
    // TODO: Implement actual screen navigation in future versions
    showFToast(
      context: context,
      alignment: FToastAlignment.bottomLeft,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.construction_outlined),
      title: Text('$sectionName Section'),
      description: const Text('Coming soon - Feature under development'),
    );
  }
}
