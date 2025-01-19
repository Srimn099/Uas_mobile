import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartPage extends StatefulWidget {
  const PieChartPage({super.key});

  @override
  _PieChartPageState createState() => _PieChartPageState();
}

class _PieChartPageState extends State<PieChartPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, int> schoolLevelCount = {};
  int totalUsers = 0;

  @override
  void initState() {
    super.initState();
    _fetchSchoolLevelData();
  }

  Future<void> _fetchSchoolLevelData() async {
    try {
      final snapshot = await _firestore.collection('users').get();
      Map<String, int> tempSchoolLevelCount = {};
      totalUsers = snapshot.docs.length;

      for (var doc in snapshot.docs) {
        String schoolLevel = doc['schoolLevel'] ?? 'Unknown';
        if (tempSchoolLevelCount.containsKey(schoolLevel)) {
          tempSchoolLevelCount[schoolLevel] =
              tempSchoolLevelCount[schoolLevel]! + 1;
        } else {
          tempSchoolLevelCount[schoolLevel] = 1;
        }
      }

      setState(() {
        schoolLevelCount = tempSchoolLevelCount;
      });
    } catch (e) {
      print('Error fetching school level data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grafik User'),
        backgroundColor: Colors.teal[600],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.teal[200]!, Colors.teal[400]!],
          ),
        ),
        child: schoolLevelCount.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    // Title Text: Data Visualisasi User Berdasarkan Jenjang Sekolah
                    const Text(
                      'Data Visualisasi User Berdasarkan Jenjang Sekolah',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    // Pie Chart
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: PieChart(
                        PieChartData(
                          sectionsSpace: 4,
                          centerSpaceRadius: 40,
                          borderData: FlBorderData(show: false),
                          sections: _buildChartSections(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Total Users
                    Text(
                      'Total Users: $totalUsers',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Legend section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLegendRow(
                            'SD', Colors.blue, schoolLevelCount['SD'] ?? 0),
                        _buildLegendRow(
                            'SMP', Colors.green, schoolLevelCount['SMP'] ?? 0),
                        _buildLegendRow(
                            'SMA', Colors.orange, schoolLevelCount['SMA'] ?? 0),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  List<PieChartSectionData> _buildChartSections() {
    return schoolLevelCount.entries.map((entry) {
      final schoolLevel = entry.key;
      final count = entry.value;
      final color = _getColorForSchoolLevel(schoolLevel);
      final percentage = ((count / totalUsers) * 100).toStringAsFixed(1);

      return PieChartSectionData(
        color: color,
        value: count.toDouble(),
        radius: 60,
        title: '$percentage%',
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        badgePositionPercentageOffset: 1.2,
      );
    }).toList();
  }

  Color _getColorForSchoolLevel(String schoolLevel) {
    switch (schoolLevel) {
      case 'SD':
        return Colors.blue;
      case 'SMP':
        return Colors.green;
      case 'SMA':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Widget _buildLegendRow(String label, Color color, int count) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0), // Added padding on the left
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            color: color,
          ),
          const SizedBox(width: 8),
          Text(
            '$label - $count Users',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors
                  .black, // Make sure the text is visible on the background
            ),
          ),
        ],
      ),
    );
  }
}
