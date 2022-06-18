import 'package:flutter/material.dart';
import 'package:xpense_android/http/HttpUser.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  HttpConnectUser transaction = HttpConnectUser();

  late TooltipBehavior _tooltipBehavior;

  List<PieChartModel> pieChartData = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _tooltipBehavior = TooltipBehavior(enable: true);

    getDataPie();
  }

  // Fetching data for pie chart from backend
  void getDataPie() async {
    var response =
        await transaction.viewTransactions("auth/totalEarningInCategories/");

    List<PieChartModel> pieData = [];

    for (var u in response) {
      PieChartModel trans = PieChartModel(
        u["grand_total"],
        u["_id"],
      );
      pieData.add(trans);
    }

    setState(() {
      pieChartData = pieData;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Income From All Categories in Rs.",
                style: GoogleFonts.poppins(
                    fontSize: 23, fontWeight: FontWeight.w500),
              ),
            ),
            SfCircularChart(
              legend: Legend(
                isVisible: true,
                overflowMode: LegendItemOverflowMode.wrap,
              ),
              tooltipBehavior: _tooltipBehavior,
              series: <CircularSeries>[
                PieSeries<PieChartModel, String>(
                  dataSource: pieChartData,
                  xValueMapper: (PieChartModel data, _) => data.category,
                  yValueMapper: (PieChartModel data, _) => data.grandTotal,
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
}

// Pie Chart Model
class PieChartModel {
  final int grandTotal;
  final String category;

  PieChartModel(
    this.grandTotal,
    this.category,
  );
}
