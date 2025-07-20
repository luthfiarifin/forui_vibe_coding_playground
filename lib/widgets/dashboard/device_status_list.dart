import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import '../shared/device_list_item.dart';

/// Device information model for the status list
class DeviceInfo {
  final String name;
  final String type;
  final DeviceStatus status;
  final IconData icon;
  final String? additionalInfo;

  const DeviceInfo({
    required this.name,
    required this.type,
    required this.status,
    required this.icon,
    this.additionalInfo,
  });
}

/// Device Status List module showing operational status of infrastructure
/// Displays key smart city devices with real-time status indicators
/// Uses shared DeviceListItem component for consistent presentation
class DeviceStatusList extends StatelessWidget {
  const DeviceStatusList({super.key});

  // Static device data for V1
  static const List<DeviceInfo> devices = [
    DeviceInfo(
      name: 'Central Power Grid',
      type: 'Primary Distribution',
      status: DeviceStatus.online,
      icon: Icons.electrical_services,
      additionalInfo: '847.2 MW Active',
    ),
    DeviceInfo(
      name: 'Solar Farm Alpha',
      type: 'Renewable Source',
      status: DeviceStatus.online,
      icon: Icons.wb_sunny,
      additionalInfo: '298.4 MW Generated',
    ),
    DeviceInfo(
      name: 'Wind Turbine Array B',
      type: 'Renewable Source',
      status: DeviceStatus.warning,
      icon: Icons.air,
      additionalInfo: 'Maintenance Required',
    ),
    DeviceInfo(
      name: 'Battery Storage Unit 1',
      type: 'Energy Storage',
      status: DeviceStatus.online,
      icon: Icons.battery_full,
      additionalInfo: '85% Capacity',
    ),
    DeviceInfo(
      name: 'Smart Meter Network',
      type: 'Monitoring System',
      status: DeviceStatus.online,
      icon: Icons.sensors,
      additionalInfo: '12,847 Connected',
    ),
    DeviceInfo(
      name: 'Backup Generator 3',
      type: 'Emergency Power',
      status: DeviceStatus.offline,
      icon: Icons.power,
      additionalInfo: 'Scheduled Maintenance',
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
              'Device Status',
              style: context.theme.typography.xl.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            // Status summary
            Row(
              children: [
                _buildStatusSummary(
                  context,
                  'Online',
                  _getOnlineCount(),
                  Colors.green,
                ),
                const SizedBox(width: 12),
                _buildStatusSummary(
                  context,
                  'Issues',
                  _getIssueCount(),
                  Colors.orange,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Device list
        FCard(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ...devices.asMap().entries.map((entry) {
                  final index = entry.key;
                  final device = entry.value;

                  return Column(
                    children: [
                      _buildDeviceItem(context, device),
                      const SizedBox(height: 8),
                      if (index < devices.length - 1) ...[
                        const Divider(color: Colors.white12, height: 16),
                        const SizedBox(height: 8),
                      ],
                    ],
                  );
                }),
              ],
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Footer info
        Text(
          'Last updated: 30 seconds ago • ${devices.length} devices monitored',
          style: context.theme.typography.xs.copyWith(color: Colors.white60),
        ),
      ],
    );
  }

  Widget _buildStatusSummary(
    BuildContext context,
    String label,
    int count,
    Color color,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(
          '$count $label',
          style: context.theme.typography.xs.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildDeviceItem(BuildContext context, DeviceInfo device) {
    return Row(
      children: [
        // Device icon
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: device.status.color..withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(device.icon, size: 20),
        ),
        const SizedBox(width: 12),

        // Device info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      device.name,
                      style: context.theme.typography.sm.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // Status indicator
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: device.status.color, width: 1),
                    ),
                    child: Text(
                      device.status.label,
                      style: context.theme.typography.xs.copyWith(
                        color: device.status.color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(device.type, style: context.theme.typography.xs),
              if (device.additionalInfo != null) ...[
                const SizedBox(height: 2),
                Text(
                  device.additionalInfo!,
                  style: context.theme.typography.xs,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  int _getOnlineCount() {
    return devices
        .where((device) => device.status == DeviceStatus.online)
        .length;
  }

  int _getIssueCount() {
    return devices
        .where(
          (device) =>
              device.status == DeviceStatus.warning ||
              device.status == DeviceStatus.offline,
        )
        .length;
  }
}
