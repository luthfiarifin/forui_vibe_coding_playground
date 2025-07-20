import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:fl_chart/fl_chart.dart';

/// Power Trend Chart module displaying energy generation vs consumption over time
/// Uses fl_chart to create an interactive line chart with two data series
/// Shows time-series data with labeled axes and grid
class PowerTrendChart extends StatelessWidget {
  const PowerTrendChart({super.key});

  @override
  Widget build(BuildContext context) {
    return FCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Chart header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Power Trends',
                  style: context.theme.typography.xl.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // Legend
                Row(
                  children: [
                    _buildLegendItem('Generation', const Color(0xFF38BDF8)),
                    const SizedBox(width: 16),
                    _buildLegendItem('Consumption', Colors.orange),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Chart container
            SizedBox(
              height: 300,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    drawHorizontalLine: true,
                    verticalInterval: 2,
                    horizontalInterval: 100,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.white..withValues(alpha: 0.1),
                        strokeWidth: 1,
                      );
                    },
                    getDrawingVerticalLine: (value) {
                      return FlLine(
                        color: Colors.white..withValues(alpha: 0.1),
                        strokeWidth: 1,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: 2,
                        getTitlesWidget: (value, meta) {
                          const hours = [
                            '00:00',
                            '02:00',
                            '04:00',
                            '06:00',
                            '08:00',
                            '10:00',
                            '12:00',
                          ];
                          final index = value.toInt();
                          if (index >= 0 && index < hours.length) {
                            return Text(
                              hours[index],
                              style: context.theme.typography.xs,
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 200,
                        reservedSize: 50,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            '${value.toInt()}MW',
                            style: context.theme.typography.xs,
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(
                      color: Colors.white..withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  minX: 0,
                  maxX: 6,
                  minY: 0,
                  maxY: 1000,
                  lineBarsData: [
                    // Generation line
                    LineChartBarData(
                      spots: const [
                        FlSpot(0, 650), // 00:00
                        FlSpot(1, 580), // 02:00
                        FlSpot(2, 520), // 04:00
                        FlSpot(3, 680), // 06:00
                        FlSpot(4, 820), // 08:00
                        FlSpot(5, 890), // 10:00
                        FlSpot(6, 860), // 12:00
                      ],
                      isCurved: true,
                      color: const Color(0xFF38BDF8), // Accent color from PRD
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(
                            radius: 4,
                            color: const Color(0xFF38BDF8),
                            strokeWidth: 2,
                            strokeColor: Colors.white,
                          );
                        },
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        color: const Color(0xFF38BDF8)..withValues(alpha: 0.1),
                      ),
                    ),
                    // Consumption line
                    LineChartBarData(
                      spots: const [
                        FlSpot(0, 620), // 00:00
                        FlSpot(1, 540), // 02:00
                        FlSpot(2, 480), // 04:00
                        FlSpot(3, 650), // 06:00
                        FlSpot(4, 780), // 08:00
                        FlSpot(5, 850), // 10:00
                        FlSpot(6, 820), // 12:00
                      ],
                      isCurved: true,
                      color: Colors.orange,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(
                            radius: 4,
                            color: Colors.orange,
                            strokeWidth: 2,
                            strokeColor: Colors.white,
                          );
                        },
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.orange..withValues(alpha: 0.1),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Chart summary
            Text(
              'Last 12 hours • Updated 2 minutes ago',
              style: context.theme.typography.xs,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 3,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
