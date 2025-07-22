import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

/// Reusable stat card component for displaying KPI metrics
/// Used in the KPI Grid to show key performance indicators
/// Built with ForUI components for consistent theming
class StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String? subtitle;
  final Color? iconColor;
  final Color? valueColor;

  const StatCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.subtitle,
    this.iconColor,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return FCard(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon and title row
            Row(
              children: [
                Icon(
                  icon,
                  size: 24,
                  color:
                      iconColor ??
                      const Color(0xFF38BDF8), // Accent color from PRD
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: context.theme.typography.xs.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Value
            Text(
              value,
              style: context.theme.typography.xl.copyWith(
                color: valueColor,
                fontWeight: FontWeight.w700,
              ),
            ),

            // Optional subtitle
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(subtitle!, style: context.theme.typography.xs),
            ],
          ],
        ),
      ),
    );
  }
}
