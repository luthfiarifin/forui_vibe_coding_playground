import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

/// Responsive utilities for ForUI breakpoint integration
/// Follows ForUI's predefined breakpoint system based on Tailwind CSS
class ResponsiveUtils {
  /// ForUI breakpoint values
  static const double sm = 640; // Small devices
  static const double md =
      768; // Medium devices (tablets) - Sidebar introduction point
  static const double lg =
      1024; // Large devices (desktops) - Full sidebar point
  static const double xl = 1280; // Extra large screens
  static const double xl2 = 1536; // Ultra-wide screens

  /// Check if current screen is mobile (< md breakpoint)
  static bool isMobile(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width < context.theme.breakpoints.md;
  }

  /// Check if current screen is tablet (md to lg breakpoint)
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= context.theme.breakpoints.md &&
        width < context.theme.breakpoints.lg;
  }

  /// Check if current screen is desktop (>= lg breakpoint)
  static bool isDesktop(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= context.theme.breakpoints.lg;
  }

  /// Check if sidebar should be shown (tablet and desktop)
  static bool shouldShowSidebar(BuildContext context) {
    return !isMobile(context);
  }

  /// Check if bottom navigation should be shown (mobile only)
  static bool shouldShowBottomNavigation(BuildContext context) {
    return isMobile(context);
  }

  /// Get responsive column count for layouts
  static int getColumnCount(BuildContext context) {
    if (isMobile(context)) return 1;
    if (isTablet(context)) return 2;
    return 3; // Desktop
  }

  /// Get responsive cross-axis count for grids
  static int getCrossAxisCount(BuildContext context) {
    if (isMobile(context)) return 2; // 2 columns for KPI grid on mobile
    if (isTablet(context)) return 4; // 4 columns for KPI grid on tablet
    return 4; // 4 columns for KPI grid on desktop
  }

  /// Get appropriate main axis spacing for responsive layouts
  static double getMainAxisSpacing(BuildContext context) {
    if (isMobile(context)) return 12;
    if (isTablet(context)) return 16;
    return 20; // Desktop
  }

  /// Get appropriate cross axis spacing for responsive layouts
  static double getCrossAxisSpacing(BuildContext context) {
    if (isMobile(context)) return 12;
    if (isTablet(context)) return 16;
    return 20; // Desktop
  }

  /// Get responsive padding for layouts
  static EdgeInsets getLayoutPadding(BuildContext context) {
    if (isMobile(context)) return const EdgeInsets.all(16);
    if (isTablet(context)) return const EdgeInsets.all(20);
    return const EdgeInsets.all(24); // Desktop
  }

  /// Get sidebar width based on breakpoint and expansion state
  static double getSidebarWidth(BuildContext context, bool expanded) {
    if (isMobile(context)) return 0; // No sidebar on mobile
    if (isTablet(context)) {
      return expanded ? 240 : 64; // Collapsible sidebar on tablet
    }
    return expanded ? 280 : 64; // Full sidebar on desktop, with collapse option
  }
}
