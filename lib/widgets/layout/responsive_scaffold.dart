import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import '../../controllers/navigation_controller.dart';
import '../../utils/responsive_utils.dart';
import '../../constants/navigation_constants.dart';
import 'header.dart';
import 'sidebar.dart';
import 'main_content.dart';
import 'bottom_navigation.dart';

/// Main responsive scaffold that provides adaptive layout structure
/// - Mobile: Header + Main Content + Bottom Navigation
/// - Tablet: Header + Sidebar (collapsible) + Main Content
/// - Desktop: Header + Sidebar (persistent) + Main Content
class ResponsiveScaffold extends StatefulWidget {
  const ResponsiveScaffold({super.key});

  @override
  State<ResponsiveScaffold> createState() => _ResponsiveScaffoldState();
}

class _ResponsiveScaffoldState extends State<ResponsiveScaffold> {
  late final NavigationController _navigationController;

  @override
  void initState() {
    super.initState();
    _navigationController = NavigationController();
  }

  @override
  void dispose() {
    _navigationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _navigationController,
      builder: (context, child) {
        // Mobile layout with bottom navigation
        if (ResponsiveUtils.isMobile(context)) {
          return _buildMobileLayout(context);
        }

        // Tablet and Desktop layout with sidebar
        return _buildTabletDesktopLayout(context);
      },
    );
  }

  /// Build mobile layout with bottom navigation
  Widget _buildMobileLayout(BuildContext context) {
    return FScaffold(
      childPad: false,
      child: Column(
        children: [
          Header(navigationController: _navigationController),
          Expanded(
            child: MainContent(
              sidebarCollapsed: !_navigationController.sidebarExpanded,
            ),
          ),
          BottomNavigation(
            currentIndex: _navigationController.currentIndex,
            onTap: (index) => _handleBottomNavigationTap(index, context),
          ),
        ],
      ),
    );
  }

  /// Build tablet and desktop layout with sidebar
  Widget _buildTabletDesktopLayout(BuildContext context) {
    return FScaffold(
      sidebar: Sidebar(
        controller: _navigationController,
        onNavigate: () => _handleSidebarNavigation(context),
      ),
      child: Column(
        children: [
          Header(
            navigationController: _navigationController,
            showBreadcrumb: ResponsiveUtils.isDesktop(context),
          ),
          Expanded(child: _buildMainContentWithBreadcrumb(context)),
        ],
      ),
    );
  }

  /// Build main content with optional breadcrumb for desktop
  Widget _buildMainContentWithBreadcrumb(BuildContext context) {
    if (ResponsiveUtils.isDesktop(context)) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            // Breadcrumb navigation for desktop
            FBreadcrumb(
              children: NavigationConstants.breadcrumbItems
                  .map(
                    (item) => item.isCurrent
                        ? FBreadcrumbItem(
                            current: true,
                            child: Text(item.label),
                          )
                        : FBreadcrumbItem(
                            onPress: () => _handleBreadcrumbPress(item),
                            child: Text(item.label),
                          ),
                  )
                  .toList(),
            ),
            Expanded(
              child: MainContent(
                sidebarCollapsed: !_navigationController.sidebarExpanded,
              ),
            ),
          ],
        ),
      );
    }

    return MainContent(
      sidebarCollapsed: !_navigationController.sidebarExpanded,
    );
  }

  /// Handle bottom navigation tap for mobile
  void _handleBottomNavigationTap(int index, BuildContext context) {
    if (index == _navigationController.currentIndex) {
      return; // Same tab, do nothing
    }

    final item = NavigationConstants.bottomNavigationItems[index];

    if (item.isImplemented) {
      _navigationController.navigateToSection(index);
    } else {
      _showNavigationFeedback(context, item.label);
    }
  }

  /// Handle sidebar navigation for tablet/desktop
  void _handleSidebarNavigation(BuildContext context) {
    // Additional logic for sidebar navigation if needed
    // Auto-collapse behavior is handled in ResponsiveSidebar
  }

  /// Handle breadcrumb navigation for desktop
  void _handleBreadcrumbPress(BreadcrumbItem item) {
    if (item.id == 'root') {
      // Navigate to home/dashboard
      _navigationController.navigateToSection(0);
    }
  }

  /// Show toast feedback for unimplemented navigation sections
  void _showNavigationFeedback(BuildContext context, String sectionName) {
    showFToast(
      context: context,
      alignment: FToastAlignment.bottomLeft,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.construction_outlined),
      title: Text('$sectionName Section'),
      description: const Text('Coming soon - Feature under development'),
    );
  }
}
