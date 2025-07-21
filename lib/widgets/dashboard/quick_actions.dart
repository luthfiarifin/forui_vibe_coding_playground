import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

/// Quick action data model for operator controls
class QuickActionItem {
  final String label;
  final IconData icon;
  final Color? color;
  final VoidCallback? onPressed; // For V1, all actions are display-only

  const QuickActionItem({
    required this.label,
    required this.icon,
    this.color,
    this.onPressed,
  });
}

/// Quick Actions module providing common operator controls
/// Features interactive buttons for frequent grid management tasks
/// Uses ForUI FButton components with icons and labels
class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  // Static action data for V1 - display-only buttons
  static final List<QuickActionItem> actions = [
    QuickActionItem(
      label: 'Reroute Power',
      icon: Icons.swap_horiz,
      color: const Color(0xFF38BDF8), // Accent color from PRD
      onPressed: null, // V1: Display only
    ),
    QuickActionItem(
      label: 'System Diagnostics',
      icon: Icons.analytics,
      color: Colors.orange,
      onPressed: null, // V1: Display only
    ),
    QuickActionItem(
      label: 'Dispatch Team',
      icon: Icons.engineering,
      color: Colors.green,
      onPressed: null, // V1: Display only
    ),
    QuickActionItem(
      label: 'Emergency Mode',
      icon: Icons.emergency,
      color: Colors.red,
      onPressed: null, // V1: Display only
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Text(
          'Quick Actions',
          style: context.theme.typography.xl.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),

        // Actions grid
        FCard(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: LayoutBuilder(
              builder: (context, constraints) {
                // TODO: Responsive grid layout
                // Mobile: 2x2 grid (current)
                // Tablet: 4x1 horizontal row
                // Desktop: 4x1 horizontal row

                return GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.0,
                  children: actions
                      .map((action) => _buildActionButton(context, action))
                      .toList(),
                );
              },
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Footer note
        Text(
          'Actions require administrator privileges • Demo mode active',
          style: context.theme.typography.xs,
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, QuickActionItem action) {
    return FButton(
      style: FButtonStyle.outline(),
      onPress:
          action.onPressed ??
          () {
            // V1: Show placeholder feedback
            _showActionFeedback(context, action.label);
          },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: (action.color ?? const Color(0xFF38BDF8))
                ..withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(action.icon, size: 20),
          ),
          const SizedBox(height: 6),
          Flexible(
            child: Text(
              action.label,
              style: context.theme.typography.xs.copyWith(
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  void _showActionFeedback(BuildContext context, String actionName) {
    // V1: Simple feedback for demo purposes using ForUI toast
    // TODO: Implement actual action handlers in future versions
    showFToast(
      context: context,
      alignment: FToastAlignment.bottomLeft,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.check_circle_outline),
      title: Text(actionName),
      description: const Text('Demo mode - Action logged successfully'),
    );
  }
}
