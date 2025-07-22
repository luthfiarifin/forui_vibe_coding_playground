import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import '../../controllers/navigation_controller.dart';
import '../../utils/responsive_utils.dart';

/// Enhanced header component for the Smart City Energy Tracker dashboard
/// Contains the app title, sidebar toggle for tablet/desktop, and responsive features
/// Uses ForUI components for consistent styling with responsive behavior
class Header extends StatelessWidget {
  final NavigationController? navigationController;
  final bool showBreadcrumb;

  const Header({
    super.key,
    this.navigationController,
    this.showBreadcrumb = false,
  });

  @override
  Widget build(BuildContext context) {
    return FHeader(
      title: Row(
        children: [
          // Sidebar toggle button for tablet/desktop
          if (ResponsiveUtils.shouldShowSidebar(context) &&
              navigationController != null)
            _buildSidebarToggle(context),

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
                Text(_getSubtitle(context), style: context.theme.typography.sm),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build sidebar toggle button for tablet/desktop
  Widget _buildSidebarToggle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: ListenableBuilder(
        listenable: navigationController!,
        builder: (context, child) {
          return IconButton(
            icon: Icon(
              navigationController!.sidebarExpanded ? FIcons.x : FIcons.menu,
              color: context.theme.colors.foreground,
            ),
            onPressed: () => navigationController!.toggleSidebar(),
          );
        },
      ),
    );
  }

  /// Get responsive subtitle text
  String _getSubtitle(BuildContext context) {
    if (ResponsiveUtils.isMobile(context)) {
      return 'Grid Dashboard';
    } else if (ResponsiveUtils.isTablet(context)) {
      return 'Real-time Grid Monitoring';
    } else {
      return 'Real-time Grid Monitoring Dashboard';
    }
  }
}
