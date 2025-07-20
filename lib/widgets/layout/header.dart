import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

/// Header component for the Smart City Energy Tracker dashboard
/// Contains the app title and key navigation elements
/// Uses ForUI components for consistent styling
class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xFF1E293B), // Container color from PRD
        border: Border(
          bottom: BorderSide(
            color: Color(0xFF38BDF8), // Accent color from PRD
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          // App icon and title
          const Icon(
            Icons.energy_savings_leaf,
            color: Color(0xFF38BDF8), // Accent color from PRD
            size: 28,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Smart City Energy Tracker',
                  style: context.theme.typography.xl.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Real-time Grid Monitoring Dashboard',
                  style: context.theme.typography.sm,
                ),
              ],
            ),
          ),
          // TODO: Implement responsive navigation menu for tablet/desktop
          // Status indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.green..withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green, width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'Online',
                  style: context.theme.typography.xs.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
