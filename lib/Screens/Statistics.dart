import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  late List<GDPData> _chartData;
  late List<GDPData> _chartDataPie;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartDataPie = getChartDataPie();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SfCircularChart(
              title:
                  ChartTitle(text: 'Monthly Earning in Individual Categories'),
              legend: Legend(
                  isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
              tooltipBehavior: _tooltipBehavior,
              series: <CircularSeries>[
                PieSeries<GDPData, String>(
                  dataSource: _chartDataPie,
                  xValueMapper: (GDPData data, _) => data.continent,
                  yValueMapper: (GDPData data, _) => data.gdp,
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                  enableTooltip: true,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  List<GDPData> getChartDataPie() {
    final List<GDPData> chartData = [
      GDPData('Print', 1600),
      GDPData('Product', 2490),
      GDPData('Repair', 2900),
      GDPData('Binding', 23050),
      GDPData('Others', 24880),
      GDPData('Raw Material', 34390),
    ];
    return chartData;
  }
}

class GDPData {
  GDPData(this.continent, this.gdp);
  final String continent;
  final double gdp;
}
