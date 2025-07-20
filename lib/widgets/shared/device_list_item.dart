import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

/// Device status types for visual representation
enum DeviceStatus {
  online('Online', Colors.green),
  offline('Offline', Colors.red),
  warning('Warning', Colors.orange),
  maintenance('Maintenance', Colors.blue);

  const DeviceStatus(this.label, this.color);
  final String label;
  final Color color;
}

/// Reusable device list item component
/// Displays device name, type, and status with appropriate indicators
/// Used in the Device Status List module
class DeviceListItem extends StatelessWidget {
  final String deviceName;
  final String deviceType;
  final DeviceStatus status;
  final IconData? deviceIcon;

  const DeviceListItem({
    super.key,
    required this.deviceName,
    required this.deviceType,
    required this.status,
    this.deviceIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B), // Container color from PRD
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white..withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Device icon
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: status.color..withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              deviceIcon ?? Icons.device_hub,
              size: 20,
              color: status.color,
            ),
          ),
          const SizedBox(width: 12),

          // Device info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  deviceName,
                  style: context.theme.typography.sm.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  deviceType,
                  style: context.theme.typography.xs.copyWith(
                    color: Colors.white60,
                  ),
                ),
              ],
            ),
          ),

          // Status indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: status.color..withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: status.color, width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: status.color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  status.label,
                  style: context.theme.typography.xs.copyWith(
                    color: status.color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
