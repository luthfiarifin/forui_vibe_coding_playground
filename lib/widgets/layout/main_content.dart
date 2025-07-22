import 'package:flutter/material.dart';
import '../dashboard/kpi_grid.dart';
import '../dashboard/power_trend_chart.dart';
import '../dashboard/energy_source_pie_chart.dart';
import '../dashboard/active_alerts.dart';
import '../dashboard/device_status_list.dart';
import '../dashboard/system_efficiency_gauge.dart';

/// Main content area containing all dashboard modules
/// Organized in a mobile-first vertical scrollable layout
/// Uses responsive spacing and TODO comments for future breakpoints
class MainContent extends StatelessWidget {
  const MainContent({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // TODO: Implement responsive breakpoints
        // Mobile: < 768px (current implementation)
        // Tablet: 768px - 1024px (2-column grid)
        // Desktop: > 1024px (3-column grid with sidebar)

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // KPI Grid - Always at the top for quick metrics overview
              const KpiGrid(),
              const SizedBox(height: 24),

              // System Efficiency Gauge - Prominent placement
              const SystemEfficiencyGauge(),
              const SizedBox(height: 24),

              // Charts section
              // TODO: Make this a 2-column grid on tablet+
              const PowerTrendChart(),
              const SizedBox(height: 24),

              const EnergySourcePieChart(),
              const SizedBox(height: 24),

              // Alerts and Status section
              // TODO: Side-by-side layout on tablet+
              const ActiveAlerts(),
              const SizedBox(height: 24),

              const DeviceStatusList(),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}
