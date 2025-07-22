import 'package:flutter/material.dart';

/// Navigation controller for managing sidebar state and current navigation index
/// Handles responsive navigation state across mobile, tablet, and desktop layouts
class NavigationController extends ChangeNotifier {
  int _currentIndex = 0; // Dashboard is initially selected
  bool _sidebarExpanded =
      false; // Sidebar collapsed by default on tablet (PRD requirement)

  /// Current active navigation index (0: Dashboard, 1: Analytics, etc.)
  int get currentIndex => _currentIndex;

  /// Whether the sidebar is expanded (only relevant for tablet/desktop)
  bool get sidebarExpanded => _sidebarExpanded;

  /// Navigation to a specific section
  /// Only Dashboard (index 0) is fully implemented in V1.1
  void navigateToSection(int index) {
    if (_currentIndex != index) {
      _currentIndex = index;
      notifyListeners();
    }
  }

  /// Toggle sidebar expansion state (tablet/desktop only)
  void toggleSidebar() {
    _sidebarExpanded = !_sidebarExpanded;
    notifyListeners();
  }

  /// Set sidebar expansion state directly
  void setSidebarExpanded(bool expanded) {
    if (_sidebarExpanded != expanded) {
      _sidebarExpanded = expanded;
      notifyListeners();
    }
  }

  /// Auto-collapse sidebar after navigation on tablet
  void autoCollapseSidebar() {
    if (_sidebarExpanded) {
      _sidebarExpanded = false;
      notifyListeners();
    }
  }
}
