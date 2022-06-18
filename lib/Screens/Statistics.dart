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

  late TooltipBehavior _tooltipBehaviorBar;

  List<TransactionOrigin> barData = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _tooltipBehaviorBar = TooltipBehavior(enable: true);
    getData();
  }

// Fetching data from backend for bar chart
  void getData() async {
    var response = await transaction.viewTransactions("auth/totalEarning/");

    List<TransactionOrigin> transactions = [];

    for (var u in response) {
      TransactionOrigin trans = TransactionOrigin(
        u["grand_total"],
        u["_id"],
      );
      transactions.add(trans);
    }

    setState(() {
      barData = transactions;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "June 2022 Earning in Rs.",
              style: GoogleFonts.poppins(
                  fontSize: 23, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SfCartesianChart(
              tooltipBehavior: _tooltipBehaviorBar,
              series: <ChartSeries>[
                ColumnSeries<TransactionOrigin, String>(
                    name: 'Sales',
                    color: Colors.blue,
                    dataSource: barData,
                    xValueMapper: (TransactionOrigin gdp, _) =>
                        gdp.date.toString(),
                    yValueMapper: (TransactionOrigin gdp, _) => gdp.grandTotal,
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Bar Chart Model
class TransactionOrigin {
  final int grandTotal;
  final int date;

  TransactionOrigin(
    this.grandTotal,
    this.date,
  );
}
