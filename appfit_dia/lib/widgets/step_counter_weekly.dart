import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';

class WeeklyStepChart extends StatefulWidget {
  const WeeklyStepChart({super.key});

  @override
  State<WeeklyStepChart> createState() => _WeeklyStepChartState();
}

class _WeeklyStepChartState extends State<WeeklyStepChart> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? get userId => FirebaseAuth.instance.currentUser?.uid;

  Map<String, int> stepsByDay = {};
  bool isLoading = true;

  final List<String> weekDays = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];

  @override
  void initState() {
    super.initState();
    _loadWeeklySteps();
  }

  Future<void> _loadWeeklySteps() async {
    if (userId == null) return;

    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd');

    List<String> last7Days = List.generate(7, (index) {
      final date = now.subtract(Duration(days: 6 - index));
      return formatter.format(date);
    });

    Map<String, int> loadedSteps = {};
    for (var day in last7Days) {
      final docId = '$userId-$day';
      final doc = await _firestore.collection('pasos_por_dia').doc(docId).get();
      loadedSteps[day] = doc.exists ? (doc['pasos'] ?? 0) as int : 0;
    }

    setState(() {
      stepsByDay = loadedSteps;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const Center(child: CircularProgressIndicator());

    final days = stepsByDay.keys.toList();
    final steps = stepsByDay.values.toList();

    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Pasos Últimos 7 Días',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 220,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: (steps.reduce((a, b) => a > b ? a : b) * 1.2).toDouble(),
                  barTouchData: const BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          int index = value.toInt();
                          if (index < 0 || index >= days.length) return const SizedBox.shrink();

                          // Convertir fecha a día abreviado
                          final date = DateTime.parse(days[index]);
                          final weekdayName = weekDays[date.weekday - 1];
                          return SideTitleWidget(
                            space: 8,
                            meta: meta,
                            child: Text(weekdayName, style: const TextStyle(fontSize: 12)),
                          );
                        },
                      ),
                    ),
                  ),
                  barGroups: List.generate(days.length, (index) {
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: steps[index].toDouble(),
                          color: Colors.blueAccent,
                          width: 18,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ],
                    );
                  }),
                  gridData: const FlGridData(show: true),
                  borderData: FlBorderData(show: false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
