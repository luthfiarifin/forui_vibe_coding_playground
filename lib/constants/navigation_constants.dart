import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

/// Navigation constants and data models
/// Contains all navigation items, icons, and labels used throughout the app
class NavigationConstants {
  /// Navigation menu items with hierarchy and metadata
  static const List<NavigationItem> navigationItems = [
    NavigationItem(
      id: 'dashboard',
      label: 'Dashboard',
      icon: FIcons.layoutDashboard,
      isImplemented: true, // Only Dashboard is implemented in V1.1
    ),
    NavigationItem(
      id: 'analytics',
      label: 'Analytics',
      icon: FIcons.box, // Use available icon
      isImplemented: false,
      children: [
        NavigationItem(
          id: 'power-trends',
          label: 'Power Trends',
          icon: FIcons.plus,
          isImplemented: false,
        ),
        NavigationItem(
          id: 'efficiency-reports',
          label: 'Efficiency Reports',
          icon: FIcons.file,
          isImplemented: false,
        ),
        NavigationItem(
          id: 'cost-analysis',
          label: 'Cost Analysis',
          icon: FIcons.ellipsis,
          isImplemented: false,
        ),
      ],
    ),
    NavigationItem(
      id: 'alerts',
      label: 'Alerts',
      icon: FIcons.bell,
      isImplemented: false,
      badge: '3', // Example badge for alerts
    ),
    NavigationItem(
      id: 'devices',
      label: 'Devices',
      icon: FIcons.code,
      isImplemented: false,
      children: [
        NavigationItem(
          id: 'smart-meters',
          label: 'Smart Meters',
          icon: FIcons.circleSlash,
          isImplemented: false,
        ),
        NavigationItem(
          id: 'transformers',
          label: 'Transformers',
          icon: FIcons.scaling,
          isImplemented: false,
        ),
        NavigationItem(
          id: 'generators',
          label: 'Generators',
          icon: FIcons.plus,
          isImplemented: false,
        ),
      ],
    ),
    NavigationItem(
      id: 'grid-management',
      label: 'Grid Management',
      icon: FIcons.settings,
      isImplemented: false,
      children: [
        NavigationItem(
          id: 'load-balancing',
          label: 'Load Balancing',
          icon: FIcons.ellipsis,
          isImplemented: false,
        ),
        NavigationItem(
          id: 'maintenance',
          label: 'Maintenance',
          icon: FIcons.settings,
          isImplemented: false,
        ),
        NavigationItem(
          id: 'emergency',
          label: 'Emergency',
          icon: FIcons.bell,
          isImplemented: false,
        ),
      ],
    ),
  ];

  /// Bottom navigation items for mobile layout
  static const List<NavigationItem> bottomNavigationItems = [
    NavigationItem(
      id: 'dashboard',
      label: 'Dashboard',
      icon: FIcons.layoutDashboard,
      selectedIcon: FIcons.layoutDashboard,
      isImplemented: true,
    ),
    NavigationItem(
      id: 'analytics',
      label: 'Analytics',
      icon: FIcons.box,
      selectedIcon: FIcons.box,
      isImplemented: false,
    ),
    NavigationItem(
      id: 'alerts',
      label: 'Alerts',
      icon: FIcons.bell,
      selectedIcon: FIcons.bell,
      isImplemented: false,
    ),
    NavigationItem(
      id: 'devices',
      label: 'Devices',
      icon: FIcons.code,
      selectedIcon: FIcons.code,
      isImplemented: false,
    ),
    NavigationItem(
      id: 'settings',
      label: 'Settings',
      icon: FIcons.settings,
      selectedIcon: FIcons.settings,
      isImplemented: false,
    ),
  ];

  /// Breadcrumb items for contextual navigation
  static const List<BreadcrumbItem> breadcrumbItems = [
    BreadcrumbItem(id: 'root', label: 'Energy Tracker', isRoot: true),
    BreadcrumbItem(id: 'dashboard', label: 'Dashboard', isCurrent: true),
  ];
}

/// Navigation item data model
class NavigationItem {
  final String id;
  final String label;
  final IconData icon;
  final IconData? selectedIcon;
  final bool isImplemented;
  final String? badge;
  final List<NavigationItem> children;

  const NavigationItem({
    required this.id,
    required this.label,
    required this.icon,
    this.selectedIcon,
    this.isImplemented = false,
    this.badge,
    this.children = const [],
  });

  /// Check if this item has children (submenu)
  bool get hasChildren => children.isNotEmpty;
}

/// Breadcrumb item data model
class BreadcrumbItem {
  final String id;
  final String label;
  final bool isRoot;
  final bool isCurrent;

  const BreadcrumbItem({
    required this.id,
    required this.label,
    this.isRoot = false,
    this.isCurrent = false,
  });
}
