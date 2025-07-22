import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import '../shared/stat_card.dart';

/// KPI Grid module displaying key performance indicators
/// Shows 4 main metrics at the top of the dashboard for quick overview
/// Uses responsive grid layout that adapts to screen size
class KpiGrid extends StatelessWidget {
  const KpiGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(
            'Key Performance Indicators',
            style: context.theme.typography.xl.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        // KPI Grid
        LayoutBuilder(
          builder: (context, constraints) {
            // TODO: Responsive grid columns
            // Mobile: 2 columns (current)
            // Tablet: 4 columns
            // Desktop: 4 columns in a single row
            final crossAxisCount = constraints.maxWidth > 580 ? 4 : 2;

            // Dynamic aspect ratio using formula based on available width
            // Formula: starts at 0.5 for small screens, gradually increases to 1.5 for large screens
            final childAspectRatio = (0.5 + (constraints.maxWidth / 3000))
                .clamp(0.5, 1.5);

            return GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: childAspectRatio,
              children: const [
                StatCard(
                  icon: Icons.electric_bolt,
                  title: 'Total Power',
                  value: '847.2 MW',
                  subtitle: '+2.3% from last hour',
                  iconColor: Color(0xFF38BDF8), // Accent color
                ),
                StatCard(
                  icon: Icons.trending_up,
                  title: 'Grid Efficiency',
                  value: '98.7%',
                  subtitle: 'Optimal performance',
                  iconColor: Colors.green,
                  valueColor: Colors.green,
                ),
                StatCard(
                  icon: Icons.warning_amber,
                  title: 'Active Alerts',
                  value: '3',
                  subtitle: '1 critical, 2 warnings',
                  iconColor: Colors.orange,
                  valueColor: Colors.orange,
                ),
                StatCard(
                  icon: Icons.eco,
                  title: 'Renewable %',
                  value: '67.3%',
                  subtitle: 'Solar + Wind active',
                  iconColor: Colors.green,
                  valueColor: Colors.green,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
