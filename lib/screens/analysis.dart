import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:oirov13/Constants/colors.dart';
import 'package:toggle_switch/toggle_switch.dart';


class Analysis extends StatefulWidget {
  const Analysis({Key? key}) : super(key: key);
  
  @override
  State<Analysis> createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> with SingleTickerProviderStateMixin {
  int _selectedScreenIndex = 0;
  
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..forward();
    
    _animation = Tween<double>(begin: 0.0, end: 0.75).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      TaskAnalysisScreen(animation: _animation),
      BarChartExample(),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Analysis',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: mainColor1,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(52),
            child: ToggleSwitch(
              customWidths: const [180, 180],
              cornerRadius: 20.0,
              activeBgColors: [[mainColor1], [mainColor1]],
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.white,
              totalSwitches: 2,
              labels: const ['Task Analysis', 'Monthly Analysis'],
              initialLabelIndex: _selectedScreenIndex,
              onToggle: (index) {
                setState(() {
                  _selectedScreenIndex = index!;
                });
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: _screens[_selectedScreenIndex],
            ),
          ),
        ],
      ),
    );
  }
}

class TaskAnalysisScreen extends StatelessWidget {
  final Animation<double> animation;

  const TaskAnalysisScreen({Key? key, required this.animation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    (animation.value * 100).toStringAsFixed(0);

    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Task 1',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 100),
            AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                return Container(
                  height: 300,
                  width: 200,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 0,
                      centerSpaceRadius: 50,
                      sections: [
                        PieChartSectionData(
                          value: animation.value * 100,
                          color: Colors.greenAccent,
                          showTitle: true,
                          title: '${(animation.value * 100).toStringAsFixed(0)}%',
                          titleStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        PieChartSectionData(
                          value: (1 - animation.value) * 100,
                          color: Colors.redAccent,
                          showTitle: true,
                          title: '${((1 - animation.value) * 100).toStringAsFixed(0)}%',
                          titleStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BarChartExample extends StatelessWidget {
  final List<DataModel> _list = [
    DataModel(key: "Oct", value: "25"),
    DataModel(key: "Nov", value: "10"),
    DataModel(key: "Dec", value: "26"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildLegendItem(Colors.greenAccent, 'Active'),
                const SizedBox(width: 10),
                _buildLegendItem(Colors.redAccent, 'InActive'),
              ],
            ),
          ),
          Container(
            height: 400,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: BarChart(
              BarChartData(
                maxY: 50,
                alignment: BarChartAlignment.spaceEvenly,
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    tooltipRoundedRadius: 8,
                    tooltipPadding: const EdgeInsets.all(8),
                    tooltipMargin: 8,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      String weekDay = _list[group.x.toInt()].key!;
                      return BarTooltipItem(
                        '$weekDay\n',
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                              text: rod.toY.toString(),
                              style: TextStyle(
                                color: rod.gradient?.colors.first ?? rod.color,
                                fontWeight: FontWeight.w500,
                              ))
                        ],
                      );
                    },
                  ),
                ),
                barGroups: _chartGroups(),
                borderData: FlBorderData(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    ),
                    left: BorderSide(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                ),
                gridData: const FlGridData(
                  drawHorizontalLine: false,
                  drawVerticalLine: false,
                ),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          _list[value.toInt()].key!,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 5,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  List<BarChartGroupData> _chartGroups() {
    return List.generate(_list.length, (index) {
      final active = double.parse(_list[index].value!);
      final inActive = 30 - active;
      return BarChartGroupData(x: index, barRods: [
        BarChartRodData(
          toY: active,
          width: 18,
          gradient: const LinearGradient(
            colors: [Colors.greenAccent, Colors.blueAccent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        BarChartRodData(
          toY: inActive,
          width: 18,
          gradient: const LinearGradient(
            colors: [Colors.redAccent, Colors.orangeAccent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
      ]);
    });
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ],
    );
  }
}

class DataModel {
  final String? key;
  final String? value;

  DataModel({this.key, this.value});
}
