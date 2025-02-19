import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SpiritualRadarChart extends StatelessWidget {
  final Map<String, double> scores;
  final String title;
  final List<Color> gradientColors;

  const SpiritualRadarChart({
    super.key,
    required this.scores,
    required this.title,
    this.gradientColors = const [Colors.blue, Colors.purple],
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            AspectRatio(
              aspectRatio: 1.3,
              child: RadarChart(
                RadarChartData(
                  radarTouchData: RadarTouchData(enabled: true),
                  dataSets: [
                    RadarDataSet(
                      fillColor: gradientColors.first.withOpacity(0.2),
                      borderColor: gradientColors.last,
                      entryRadius: 2,
                      dataEntries: _createDataEntries(),
                    ),
                  ],
                  radarBackgroundColor: Colors.transparent,
                  borderData: FlBorderData(show: false),
                  radarBorderData: const BorderSide(color: Colors.transparent),
                  titlePositionPercentageOffset: 0.2,
                  titleTextStyle: const TextStyle(fontSize: 14),
                  getTitle: (index, angle) => RadarChartTitle(
                    text: _getTitles(index),
                    angle: angle,
                  ),
                  tickCount: 5,
                  ticksTextStyle: const TextStyle(color: Colors.black, fontSize: 10),
                  gridBorderData: BorderSide(color: Colors.grey.withOpacity(0.3)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<RadarEntry> _createDataEntries() {
    return scores.values.map((score) => RadarEntry(value: score)).toList();
  }

  String _getTitles(int index) {
    final titles = scores.keys.toList();
    return index >= 0 && index < titles.length ? titles[index] : '';
  }
}