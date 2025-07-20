import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:fl_chart/fl_chart.dart';

/// Energy Source data model for the pie chart
class EnergySource {
  final String name;
  final double percentage;
  final Color color;
  final IconData icon;

  const EnergySource({
    required this.name,
    required this.percentage,
    required this.color,
    required this.icon,
  });
}

/// Energy Source Breakdown pie chart module
/// Displays the percentage breakdown of different energy sources
/// Uses fl_chart for interactive pie visualization with legend
class EnergySourcePieChart extends StatelessWidget {
  const EnergySourcePieChart({super.key});

  // Static data for V1 - representing different energy sources
  static const List<EnergySource> energySources = [
    EnergySource(
      name: 'Solar',
      percentage: 35.2,
      color: Colors.yellow,
      icon: Icons.wb_sunny,
    ),
    EnergySource(
      name: 'Wind',
      percentage: 32.1,
      color: Color(0xFF38BDF8), // Accent color from PRD
      icon: Icons.air,
    ),
    EnergySource(
      name: 'Natural Gas',
      percentage: 22.4,
      color: Colors.orange,
      icon: Icons.local_fire_department,
    ),
    EnergySource(
      name: 'Hydro',
      percentage: 10.3,
      color: Colors.blue,
      icon: Icons.water_drop,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return FCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Chart header
            Text(
              'Energy Source Breakdown',
              style: context.theme.typography.xl.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),

            // Chart and legend layout
            LayoutBuilder(
              builder: (context, constraints) {
                // TODO: Responsive layout - side-by-side on tablet+
                final isWide = constraints.maxWidth > 600;

                if (isWide) {
                  return Row(
                    children: [
                      // Pie chart
                      Expanded(flex: 2, child: _buildPieChart()),
                      const SizedBox(width: 24),
                      // Legend
                      Expanded(flex: 1, child: _buildLegend(context)),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      _buildPieChart(),
                      const SizedBox(height: 24),
                      _buildLegend(context),
                    ],
                  );
                }
              },
            ),

            const SizedBox(height: 16),

            // Chart summary
            Text(
              'Total renewable: 67.3% • Real-time data',
              style: context.theme.typography.xs,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChart() {
    return SizedBox(
      height: 200,
      child: PieChart(
        PieChartData(
          sectionsSpace: 2,
          centerSpaceRadius: 50,
          sections: energySources.map((source) {
            return PieChartSectionData(
              color: source.color,
              value: source.percentage,
              title: '${source.percentage.toStringAsFixed(1)}%',
              radius: 60,
              titleStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              badgeWidget: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: source.color..withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                  border: Border.all(color: source.color, width: 1),
                ),
                child: Icon(source.icon, size: 16, color: source.color),
              ),
              badgePositionPercentageOffset: 1.3,
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildLegend(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: energySources.map((source) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              // Color indicator
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: source.color,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(width: 12),

              // Icon
              Icon(source.icon, size: 18, color: source.color),
              const SizedBox(width: 8),

              // Name and percentage
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      source.name,
                      style: context.theme.typography.sm.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${source.percentage.toStringAsFixed(1)}%',
                      style: context.theme.typography.xs,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
