import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

/// Alert severity levels for different types of system notifications
enum AlertSeverity {
  critical('Critical', Icons.error),
  warning('Warning', Icons.warning_amber),
  info('Info', Icons.info);

  const AlertSeverity(this.label, this.icon);
  final String label;
  final IconData icon;
}

/// Alert data model for system notifications
class SystemAlert {
  final String title;
  final String message;
  final AlertSeverity severity;
  final DateTime timestamp;

  const SystemAlert({
    required this.title,
    required this.message,
    required this.severity,
    required this.timestamp,
  });
}

/// Active Alerts module displaying critical system notifications
/// Uses ForUI FAlert components with color-coded severity levels
/// Shows real-time alerts that require operator attention
class ActiveAlerts extends StatelessWidget {
  const ActiveAlerts({super.key});

  // Static alert data for V1
  static final List<SystemAlert> alerts = [
    SystemAlert(
      title: 'High Load Warning',
      message:
          'Grid sector 7 approaching capacity limits. Consider load balancing.',
      severity: AlertSeverity.critical,
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
    SystemAlert(
      title: 'Solar Panel Maintenance',
      message: 'Panel array C-14 scheduled for maintenance in 2 hours.',
      severity: AlertSeverity.warning,
      timestamp: DateTime.now().subtract(const Duration(minutes: 23)),
    ),
    SystemAlert(
      title: 'Efficiency Optimization',
      message:
          'Wind turbine output increased by 12% due to favorable conditions.',
      severity: AlertSeverity.info,
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Active Alerts',
              style: context.theme.typography.xl.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            // Alert count badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red..withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red, width: 1),
              ),
              child: Text(
                '${alerts.length}',
                style: context.theme.typography.xs.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Alerts list
        ...alerts.map(
          (alert) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildAlertCard(context, alert),
          ),
        ),

        // TODO: Add "View All Alerts" button for tablet/desktop
        // when there are more alerts than displayed
      ],
    );
  }

  Widget _buildAlertCard(BuildContext context, SystemAlert alert) {
    return FCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Alert icon
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _getAlertColor(alert.severity)..withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(alert.severity.icon, size: 20),
            ),
            const SizedBox(width: 12),

            // Alert content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and severity
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          alert.title,
                          style: context.theme.typography.sm.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: _getAlertColor(alert.severity)
                            ..withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          alert.severity.label,
                          style: context.theme.typography.xs.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Message
                  Text(alert.message, style: context.theme.typography.xs),
                  const SizedBox(height: 8),

                  // Timestamp
                  Text(
                    _formatTimestamp(alert.timestamp),
                    style: context.theme.typography.xs,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getAlertColor(AlertSeverity severity) {
    switch (severity) {
      case AlertSeverity.critical:
        return Colors.red;
      case AlertSeverity.warning:
        return Colors.orange;
      case AlertSeverity.info:
        return const Color(0xFF38BDF8);
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}
