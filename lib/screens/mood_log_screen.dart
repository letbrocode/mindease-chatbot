import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MoodLogScreen extends StatelessWidget {
  final List<String> moodEntries; // Pass the mood entries from HomeScreen

  const MoodLogScreen({super.key, required this.moodEntries});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mood Log')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Graph Section
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.all(16), // Padding around the container
                decoration: BoxDecoration(
                  color: Colors.grey[900], // Dark background for the graph
                  borderRadius: BorderRadius.circular(12),
                ),
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: true),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40, // Padding on the left for emojis
                          getTitlesWidget: (value, meta) {
                            // Use emojis for moods and reduce their size
                            switch (value.toInt()) {
                              case 1:
                                return const Text('😠',
                                    style:
                                        TextStyle(fontSize: 18)); // Angry emoji
                              case 2:
                                return const Text('😢',
                                    style:
                                        TextStyle(fontSize: 18)); // Sad emoji
                              case 3:
                                return const Text('😐',
                                    style: TextStyle(
                                        fontSize: 18)); // Neutral emoji
                              case 4:
                                return const Text('😊',
                                    style: TextStyle(
                                        fontSize: 18)); // Content emoji
                              case 5:
                                return const Text('😁',
                                    style:
                                        TextStyle(fontSize: 18)); // Happy emoji
                              default:
                                return const SizedBox(); // Hide any undefined values
                            }
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40, // Padding for bottom titles
                          getTitlesWidget: (value, meta) {
                            return Text(
                              (value + 1)
                                  .toInt()
                                  .toString(), // Display x-axis entries
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.white),
                            );
                          },
                        ),
                      ),
                      topTitles: AxisTitles(
                          sideTitles:
                              SideTitles(showTitles: false)), // Hide top titles
                      rightTitles: AxisTitles(
                          sideTitles: SideTitles(
                              showTitles: false)), // Hide right titles
                    ),
                    borderData: FlBorderData(
                        show: true, border: Border.all(color: Colors.white)),
                    lineBarsData: [
                      LineChartBarData(
                        spots: _getMoodData(), // Method to get graph data
                        isCurved: true,
                        color: Colors.blue, // Change the line color as needed
                        barWidth: 4,
                        belowBarData: BarAreaData(show: false),
                        dotData: FlDotData(show: true), // Show dots on the line
                      ),
                    ],
                    minY: 1, // Set minimum y-axis value
                    maxY: 5, // Set maximum y-axis value
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Mood Entries',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: moodEntries.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(moodEntries[index]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<FlSpot> _getMoodData() {
    // Example: Convert mood entries to graph data
    Map<String, double> moodMap = {
      'Happy': 5,
      'Content': 4,
      'Neutral': 3,
      'Sad': 2,
      'Angry': 1,
    };

    List<FlSpot> spots = [];
    for (int i = 0; i < moodEntries.length; i++) {
      double moodValue =
          moodMap[moodEntries[i]] ?? 0; // Default to 0 if not found
      spots.add(FlSpot(i.toDouble(), moodValue));
    }

    return spots;
  }
}
