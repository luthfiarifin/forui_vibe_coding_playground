import 'package:flutter/material.dart';
import '../../utils/responsive_utils.dart';
import '../dashboard/kpi_grid.dart';
import '../dashboard/power_trend_chart.dart';
import '../dashboard/energy_source_pie_chart.dart';
import '../dashboard/active_alerts.dart';
import '../dashboard/device_status_list.dart';
import '../dashboard/system_efficiency_gauge.dart';

/// Responsive main content component that adapts layout based on screen size and sidebar state
/// - Mobile: Single column vertical scroll
/// - Tablet: Two-column grid layout
/// - Desktop: Three-column grid layout (adapts to sidebar state)
class MainContent extends StatelessWidget {
  final bool sidebarCollapsed;

  const MainContent({super.key, this.sidebarCollapsed = true});

  @override
  Widget build(BuildContext context) {
    final padding = ResponsiveUtils.getLayoutPadding(context);

    return SingleChildScrollView(
      padding: padding,
      child: _buildLayout(context),
    );
  }

  /// Build responsive layout based on screen size
  Widget _buildLayout(BuildContext context) {
    if (ResponsiveUtils.isMobile(context)) {
      return _buildMobileLayout(context);
    } else if (ResponsiveUtils.isTablet(context)) {
      return _buildTabletLayout(context);
    } else {
      return _buildDesktopLayout(context);
    }
  }

  /// Mobile layout - single column vertical scroll (V1.0 maintained)
  Widget _buildMobileLayout(BuildContext context) {
    final spacing = ResponsiveUtils.getMainAxisSpacing(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const KpiGrid(),
        SizedBox(height: spacing),
        const PowerTrendChart(),
        SizedBox(height: spacing),
        const EnergySourcePieChart(),
        SizedBox(height: spacing),
        const SystemEfficiencyGauge(),
        SizedBox(height: spacing),
        const ActiveAlerts(),
        SizedBox(height: spacing),
        const DeviceStatusList(),
      ],
    );
  }

  /// Tablet layout - two-column grid with responsive components
  Widget _buildTabletLayout(BuildContext context) {
    final spacing = ResponsiveUtils.getMainAxisSpacing(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // KPI Grid spans full width on tablet
        const KpiGrid(),
        SizedBox(height: spacing),
        const PowerTrendChart(),
        SizedBox(height: spacing),

        // Two-column layout for charts
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  SizedBox(height: spacing),
                  const SystemEfficiencyGauge(),
                  SizedBox(height: spacing),
                  const DeviceStatusList(),
                ],
              ),
            ),
            SizedBox(width: spacing),
            Expanded(
              child: Column(
                children: [
                  const EnergySourcePieChart(),
                  SizedBox(height: spacing),
                  const ActiveAlerts(),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: spacing),
      ],
    );
  }

  /// Desktop layout - adaptive grid based on sidebar state to prevent overflow
  Widget _buildDesktopLayout(BuildContext context) {
    final spacing = ResponsiveUtils.getMainAxisSpacing(context);
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate available width considering sidebar
    final sidebarWidth = sidebarCollapsed ? 64.0 : 280.0;
    final availableWidth = screenWidth - sidebarWidth;

    // Use more compact layout when sidebar is expanded or screen is narrow
    final useCompactLayout = !sidebarCollapsed || availableWidth < 1300;

    if (useCompactLayout) {
      return _buildCompactDesktopLayout(context, spacing);
    } else {
      return _buildFullDesktopLayout(context, spacing);
    }
  }

  /// Compact desktop layout for when sidebar is expanded or narrow screens
  Widget _buildCompactDesktopLayout(BuildContext context, double spacing) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // KPI Grid spans full width
        const KpiGrid(),
        SizedBox(height: spacing),

        // Two-column layout for main content
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left column - Charts + System Efficiency
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  const PowerTrendChart(),
                  SizedBox(height: spacing),
                  const EnergySourcePieChart(),
                  SizedBox(height: spacing),
                  const SystemEfficiencyGauge(),
                ],
              ),
            ),
            SizedBox(width: spacing),

            // Right column - Alerts + Device Status
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  const ActiveAlerts(),
                  SizedBox(height: spacing),
                  const DeviceStatusList(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Full desktop layout for when sidebar is collapsed and wide screens
  Widget _buildFullDesktopLayout(BuildContext context, double spacing) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left column - KPI Grid + System Efficiency
        Expanded(
          flex: 1,
          child: Column(
            children: [
              const KpiGrid(),
              SizedBox(height: spacing),
              const SystemEfficiencyGauge(),
            ],
          ),
        ),
        SizedBox(width: spacing),

        // Center column - Charts
        Expanded(
          flex: 2,
          child: Column(
            children: [
              const PowerTrendChart(),
              SizedBox(height: spacing),
              const EnergySourcePieChart(),
            ],
          ),
        ),
        SizedBox(width: spacing),

        // Right column - Alerts + Device Status
        Expanded(
          flex: 1,
          child: Column(
            children: [
              const ActiveAlerts(),
              SizedBox(height: spacing),
              const DeviceStatusList(),
            ],
          ),
        ),
      ],
    );
  }
}
