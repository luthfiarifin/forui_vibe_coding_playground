import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import '../../controllers/navigation_controller.dart';
import '../../constants/navigation_constants.dart';
import '../../utils/responsive_utils.dart';

/// Responsive sidebar navigation component using ForUI FSidebar
/// Adapts behavior based on screen size:
/// - Hidden on mobile (< 768px)
/// - Collapsible on tablet (768px - 1024px) with animation
/// - Expandable/persistent on desktop (>= 1024px) with animation
class Sidebar extends StatefulWidget {
  final NavigationController controller;
  final VoidCallback? onNavigate;

  const Sidebar({super.key, required this.controller, this.onNavigate});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _widthAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _widthAnimation =
        Tween<double>(
          begin: 64.0, // Collapsed width
          end: 280.0, // Expanded width
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );

    // Set initial state based on controller
    if (widget.controller.sidebarExpanded) {
      _animationController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Hide sidebar on mobile devices
    if (ResponsiveUtils.isMobile(context)) {
      return const SizedBox.shrink();
    }

    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, child) {
        // Animate sidebar based on expansion state
        if (widget.controller.sidebarExpanded) {
          _animationController.forward();
        } else {
          _animationController.reverse();
        }

        return AnimatedBuilder(
          animation: _widthAnimation,
          builder: (context, child) {
            final isCollapsed =
                _widthAnimation.value <= 100; // Threshold for collapsed state

            return SizedBox(
              width: _widthAnimation.value + 8, // Add padding
              child: FSidebar(
                header: _buildSidebarHeader(context, isCollapsed),
                footer: _buildSidebarFooter(context, isCollapsed),
                children: NavigationConstants.navigationItems
                    .map(
                      (item) =>
                          _buildNavigationGroup(context, item, isCollapsed),
                    )
                    .toList(),
              ),
            );
          },
        );
      },
    );
  }

  /// Build sidebar header with app branding
  Widget _buildSidebarHeader(BuildContext context, bool isCollapsed) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isCollapsed ? 8 : 16,
        vertical: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(isCollapsed ? 8 : 16),
            child: isCollapsed
                ? Icon(
                    Icons.energy_savings_leaf,
                    color: context.theme.colors.primary,
                    size: 24,
                  )
                : Row(
                    children: [
                      Icon(
                        Icons.energy_savings_leaf,
                        color: context.theme.colors.primary,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Energy Tracker',
                          style: context.theme.typography.lg.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.theme.colors.foreground,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
          ),
          if (!isCollapsed) const FDivider(),
        ],
      ),
    );
  }

  /// Build sidebar footer with user profile
  Widget _buildSidebarFooter(BuildContext context, bool isCollapsed) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isCollapsed ? 8 : 16,
        vertical: 8,
      ),
      child: FCard.raw(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 12,
            horizontal: isCollapsed ? 8 : 16,
          ),
          child: isCollapsed
              ? Center(
                  child: FAvatar.raw(
                    child: Icon(
                      FIcons.userRound,
                      size: 18,
                      color: context.theme.colors.mutedForeground,
                    ),
                  ),
                )
              : Row(
                  spacing: 10,
                  children: [
                    FAvatar.raw(
                      child: Icon(
                        FIcons.userRound,
                        size: 18,
                        color: context.theme.colors.mutedForeground,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 2,
                        children: [
                          Text(
                            'Grid Operator',
                            style: context.theme.typography.sm.copyWith(
                              fontWeight: FontWeight.bold,
                              color: context.theme.colors.foreground,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'operator@energy.city',
                            style: context.theme.typography.xs.copyWith(
                              color: context.theme.colors.mutedForeground,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  /// Build navigation group for sidebar
  Widget _buildNavigationGroup(
    BuildContext context,
    NavigationItem item,
    bool isCollapsed,
  ) {
    // For top-level items without children, create a simple group
    if (!item.hasChildren) {
      return FSidebarGroup(
        label: isCollapsed ? null : Text(item.label),
        children: [
          FSidebarItem(
            icon: Icon(item.icon),
            label: isCollapsed ? null : Text(item.label),
            selected: _isItemSelected(item),
            onPress: () => _handleItemPress(context, item),
          ),
        ],
      );
    }

    // For items with children, create an expandable group
    return FSidebarGroup(
      label: isCollapsed ? null : Text(item.label),
      children: [
        FSidebarItem(
          icon: Icon(item.icon),
          label: isCollapsed ? null : Text(item.label),
          selected: _isItemSelected(item),
          initiallyExpanded:
              item.id == 'analytics' &&
              !isCollapsed, // Only expand when not collapsed
          onPress: () => _handleItemPress(context, item),
          children: isCollapsed
              ? [] // Hide children when collapsed
              : item.children
                    .map(
                      (child) => FSidebarItem(
                        label: Text(child.label),
                        selected: _isItemSelected(child),
                        onPress: () => _handleItemPress(context, child),
                      ),
                    )
                    .toList(),
        ),
      ],
    );
  }

  /// Check if navigation item is currently selected
  bool _isItemSelected(NavigationItem item) {
    // Only Dashboard is implemented in V1.1
    return item.id == 'dashboard' && widget.controller.currentIndex == 0;
  }

  /// Handle navigation item press
  void _handleItemPress(BuildContext context, NavigationItem item) {
    if (item.isImplemented) {
      // Navigate to implemented sections
      final index = NavigationConstants.navigationItems.indexWhere(
        (navItem) => navItem.id == item.id,
      );
      if (index != -1) {
        widget.controller.navigateToSection(index);
        widget.onNavigate?.call();

        // Auto-collapse sidebar on tablet after navigation
        if (ResponsiveUtils.isTablet(context)) {
          widget.controller.autoCollapseSidebar();
        }
      }
    } else {
      // Show coming soon feedback for unimplemented sections
      _showNavigationFeedback(context, item.label);
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
