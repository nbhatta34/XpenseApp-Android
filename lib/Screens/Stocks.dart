import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xpense_android/Screens/AddStocks.dart';
import 'package:xpense_android/Screens/HomeScreen.dart';
import 'package:xpense_android/http/HttpUser.dart';
import 'package:jiffy/jiffy.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Stocks extends StatefulWidget {
  const Stocks({Key? key}) : super(key: key);

  @override
  State<Stocks> createState() => _StocksState();
}

class _StocksState extends State<Stocks> {
  HttpConnectUser transaction = HttpConnectUser();

  @override
  void initState() {
    super.initState();
    fetchdata();
  }

  fetchdata() async {
    try {
      var response = await transaction.viewStocks("auth/addStock/");

      List<StocksOrigin> stocks = [];

      for (var u in response["data"]) {
        StocksOrigin trans = StocksOrigin(
            u["stockName"],
            u["quantity"],
            u["unitPrice"],
            u["category"],
            u["supplierName"],
            u["createdAt"],
            u["_id"]);

        stocks.add(trans);
      }

      return stocks;
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddStock(),
              ),
            );
          },
          child: Icon(
            Icons.addchart_rounded,
          ),
        ),
        body: getBody(),
      ),
    );
  }

  Widget getBody() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "Recently Added Stocks",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 95, 95, 95),
                  ),
                ),
              ),
              // Icon(Icons.search)
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder(
            future: fetchdata(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return SpinKitWave(
                  color: Colors.black54,
                );
              } else {
                if (snapshot.data?.length == 0) {
                  return Container(
                    child: Center(
                      child: Text(
                        "No Stocks To Show",
                        style: GoogleFonts.poppins(
                            fontSize: 23,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54),
                      ),
                    ),
                  );
                } else {
                  final List<StockModel> stockData = List.generate(
                    snapshot.data.length,
                    (index) => StockModel(
                      '${snapshot.data?[index].stockName}',
                      '${snapshot.data?[index].quantity}',
                      '${snapshot.data?[index].unitPrice}',
                      '${snapshot.data?[index].category}',
                      '${snapshot.data?[index].supplierName}',
                      '${snapshot.data?[index].stockId}',
                    ),
                  );
                  return ListView.builder(
                    itemCount: stockData.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 10),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  60) *
                                              0.65,
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 50,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                ),
                                                child: Center(
                                                  child: Image.asset(
                                                    "assets/images/${snapshot.data?[snapshot.data.length - (index + 1)].category.toLowerCase()}.png",
                                                    width: 50,
                                                    height: 50,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 15),
                                              Container(
                                                width: (MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                        110) *
                                                    0.5,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${snapshot.data?[snapshot.data.length - (index + 1)].stockName} x ${snapshot.data?[snapshot.data.length - (index + 1)].quantity}",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      "Rs. ${snapshot.data?[snapshot.data.length - (index + 1)].unitPrice}",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black
                                                              .withOpacity(0.5),
                                                          fontWeight:
                                                              FontWeight.w400),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      "${snapshot.data?[snapshot.data.length - (index + 1)].supplierName}",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black
                                                              .withOpacity(0.5),
                                                          fontWeight:
                                                              FontWeight.w400),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      "${Jiffy(snapshot.data?[snapshot.data.length - (index + 1)].createdAt).yMMMMEEEEd}",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black
                                                              .withOpacity(0.5),
                                                          fontWeight:
                                                              FontWeight.w400),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  0) /
                                              2.82,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                "Rs. ${double.parse(snapshot.data?[snapshot.data.length - (index + 1)].quantity) * double.parse(snapshot.data?[snapshot.data.length - (index + 1)].unitPrice)}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15,
                                                  color: Color.fromARGB(
                                                      255, 33, 139, 36),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }
              }
            },
          ),
        )
      ],
    );
  }
}

class StocksOrigin {
  final String stockName;
  final String quantity;
  final String unitPrice;
  final String category;
  final String supplierName;
  final String createdAt;
  final String stockId;

  StocksOrigin(this.stockName, this.quantity, this.unitPrice, this.category,
      this.supplierName, this.createdAt, this.stockId);
}

class StockModel {
  final String stockName, quantity, unitPrice, category, supplierName, stockId;

  StockModel(this.stockName, this.quantity, this.unitPrice, this.category,
      this.supplierName, this.stockId);
}
