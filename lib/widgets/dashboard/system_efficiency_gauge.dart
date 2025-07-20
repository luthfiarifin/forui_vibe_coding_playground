import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

/// System Efficiency Gauge module showing overall grid performance
/// Features a large circular progress indicator with percentage display
/// Prominently placed to show the most critical system metric
class SystemEfficiencyGauge extends StatelessWidget {
  const SystemEfficiencyGauge({super.key});

  @override
  Widget build(BuildContext context) {
    const efficiency = 98.7; // Static data for V1

    return FCard(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Section header
            Text(
              'Grid Efficiency',
              style: context.theme.typography.xl.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),

            // Circular gauge
            Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Background circle
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: CircularProgressIndicator(
                        value: 1.0,
                        strokeWidth: 12,
                        backgroundColor: Colors.white..withValues(alpha: 0.1),
                        valueColor: AlwaysStoppedAnimation(
                          Colors.white..withValues(alpha: 0.1),
                        ),
                      ),
                    ),

                    // Progress circle
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: CircularProgressIndicator(
                        value: efficiency / 100,
                        strokeWidth: 12,
                        backgroundColor: Colors.transparent,
                        valueColor: AlwaysStoppedAnimation(
                          efficiency >= 95
                              ? Colors.green
                              : efficiency >= 80
                              ? Colors.orange
                              : Colors.red,
                        ),
                      ),
                    ),

                    // Center content
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${efficiency.toStringAsFixed(1)}%',
                          style: context.theme.typography.xl4.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Efficiency',
                          style: context.theme.typography.sm.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Status indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatusIndicator(
                  context,
                  'Optimal',
                  Colors.green,
                  efficiency >= 95,
                ),
                _buildStatusIndicator(
                  context,
                  'Good',
                  Colors.orange,
                  efficiency >= 80 && efficiency < 95,
                ),
                _buildStatusIndicator(
                  context,
                  'Critical',
                  Colors.red,
                  efficiency < 80,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(
    BuildContext context,
    String label,
    Color color,
    bool isActive,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? color : Colors.white.withValues(alpha: 0.3),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: context.theme.typography.xs.copyWith(
            color: isActive ? color : null,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
