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
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = getChartData();
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SfCartesianChart(
                  title: ChartTitle(text: 'June 2022 Earning'),
                  tooltipBehavior: _tooltipBehavior,
                  series: <ChartSeries>[
                    ColumnSeries<GDPData, String>(
                        name: 'Sales',
                        dataSource: _chartData,
                        xValueMapper: (GDPData gdp, _) => gdp.continent,
                        yValueMapper: (GDPData gdp, _) => gdp.gdp,
                        enableTooltip: true)
                  ],
                  primaryXAxis: CategoryAxis(),
                  primaryYAxis: NumericAxis(
                    edgeLabelPlacement: EdgeLabelPlacement.shift,
                    numberFormat: NumberFormat.currency(
                      locale: 'en_In',
                      symbol: "Rs.",
                      decimalDigits: 0,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  List<GDPData> getChartData() {
    final List<GDPData> chartData = [
      GDPData('June 1', 1600),
      GDPData('June 4', 2490),
      GDPData('June 6', 2900),
      GDPData('June 8', 23050),
      GDPData('June 10', 24880),
      GDPData('June 15', 34390),
    ];
    return chartData;
  }
}

class GDPData {
  GDPData(this.continent, this.gdp);
  final String continent;
  final double gdp;
}
