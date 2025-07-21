import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

/// Bottom navigation item data model
class BottomNavItem {
  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final bool isActive;

  const BottomNavItem({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    this.isActive = false,
  });
}

/// Bottom Navigation Bar component for mobile responsive design
/// Provides navigation to main app sections on mobile devices
/// Hidden on tablet/desktop where sidebar navigation is used instead
/// TODO: Implement actual navigation routing in future versions
class BottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  // Static navigation items for V1 - matches smart city energy theme
  static final List<BottomNavItem> navItems = [
    BottomNavItem(
      label: 'Dashboard',
      icon: Icons.dashboard_outlined,
      selectedIcon: Icons.dashboard,
      isActive: true, // Current screen
    ),
    BottomNavItem(
      label: 'Analytics',
      icon: Icons.analytics_outlined,
      selectedIcon: Icons.analytics,
    ),
    BottomNavItem(
      label: 'Alerts',
      icon: Icons.notifications_outlined,
      selectedIcon: Icons.notifications,
    ),
    BottomNavItem(
      label: 'Devices',
      icon: Icons.devices_outlined,
      selectedIcon: Icons.devices,
    ),
    BottomNavItem(
      label: 'Settings',
      icon: Icons.settings_outlined,
      selectedIcon: Icons.settings,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1E293B), // Container color from PRD
        border: Border(
          top: BorderSide(
            color: Color(0xFF38BDF8), // Accent color from PRD
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: navItems.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isSelected = index == currentIndex;

              return Expanded(
                child: _buildNavItem(
                  context,
                  item,
                  isSelected,
                  () => onTap(index),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    BottomNavItem item,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isSelected ? item.selectedIcon : item.icon,
                size: 24,
                color: isSelected
                    ? const Color(0xFF38BDF8) // Accent color from PRD
                    : Colors.grey,
              ),
              const SizedBox(height: 4),
              Text(
                item.label,
                style: context.theme.typography.xs.copyWith(
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected
                      ? const Color(0xFF38BDF8) // Accent color from PRD
                      : Colors.grey,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
