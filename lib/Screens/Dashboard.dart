import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xpense_android/Screens/AddEarning.dart';
import 'package:xpense_android/Screens/HomeScreen.dart';
import 'package:xpense_android/http/HttpUser.dart';
import 'package:xpense_android/response/GetTransactionResponse.dart';
import 'package:jiffy/jiffy.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard>
    with SingleTickerProviderStateMixin {
  HttpConnectUser transaction = HttpConnectUser();
  TransactionResponse responseCatcher = TransactionResponse();
  int activeDay = 3;

  bool isOpened = false;
  @override
  void initState() {
    super.initState();
    fetchdata();
  }

  fetchdata() async {
    try {
      var response = await transaction.viewTransactions("auth/addTransaction/");

      List<TransactionOrigin> transactions = [];

      for (var u in response["data"]) {
        TransactionOrigin trans = TransactionOrigin(
            u["itemName"],
            u["quantity"],
            u["unitPrice"],
            u["category"],
            u["clientName"],
            u["createdAt"],
            u["_id"]);

        transactions.add(trans);
      }

      return transactions;
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEarning(),
            ),
          );
        },
        child: Icon(
          Icons.addchart_rounded,
        ),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.01),
                spreadRadius: 10,
                blurRadius: 3,
                // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 0, right: 20, left: 20, bottom: 25),
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    7,
                    (index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: (MediaQuery.of(context).size.width - 40) / 7,
                          child: Column(
                            children: [
                              Text(
                                "Sun",
                                style: TextStyle(fontSize: 10),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: activeDay == index
                                      ? Colors.pinkAccent
                                      : Colors.transparent,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: activeDay == index
                                        ? Colors.pinkAccent
                                        : Colors.black.withOpacity(0.1),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "${index + 1}",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: activeDay == index
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Today's Statistics",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 95, 95, 95)),
              ),
              // Icon(Icons.search)
            ],
          ),
        ),
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "38",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: 26),
                          ),
                          Text(
                            "Products Sold",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 16),
                          ),
                        ],
                      ),
                      width: MediaQuery.of(context).size.width / 2 - 20,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 11, 59, 73),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "180",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: 26),
                          ),
                          Text(
                            "Prints",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 16),
                          ),
                        ],
                      ),
                      width: MediaQuery.of(context).size.width / 2 - 20,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 11, 59, 73),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "3",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: 26),
                          ),
                          Text(
                            "Repairs",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 16),
                          ),
                        ],
                      ),
                      width: MediaQuery.of(context).size.width / 2 - 20,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 11, 59, 73),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2 - 20,
                      height: 80,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 11, 59, 73),
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "8",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: 26),
                          ),
                          Text(
                            "Others",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recently Added",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 95, 95, 95),
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
                        "No Transactions To Show",
                        style: GoogleFonts.poppins(
                            fontSize: 23,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54),
                      ),
                    ),
                  );
                } else {
                  final List<Transactions> transactionData = List.generate(
                    snapshot.data.length,
                    (index) => Transactions(
                      '${snapshot.data?[index].itemName}',
                      '${snapshot.data?[index].quantity}',
                      '${snapshot.data?[index].unitPrice}',
                      '${snapshot.data?[index].category}',
                      '${snapshot.data?[index].clientName}',
                      '${snapshot.data?[index].transactionId}',
                    ),
                  );
                  return ListView.builder(
                    itemCount: transactionData.length,
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
                                                      "${snapshot.data?[snapshot.data.length - (index + 1)].itemName} x ${snapshot.data?[snapshot.data.length - (index + 1)].quantity}",
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
                                                    IconButton(
                                                      onPressed: () {
                                                        showDialog<String>(
                                                          context: context,
                                                          builder: (BuildContext
                                                                  context) =>
                                                              AlertDialog(
                                                            title: const Text(
                                                                'Are you sure you want to delete?'),
                                                            content: const Text(
                                                                'Transaction will be deleted permanently.'),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        context,
                                                                        'Cancel'),
                                                                child: const Text(
                                                                    'Cancel'),
                                                              ),
                                                              TextButton(
                                                                onPressed: () {
                                                                  HttpConnectUser().deleteTransaction(snapshot
                                                                      .data?[snapshot
                                                                              .data
                                                                              .length -
                                                                          (index +
                                                                              1)]
                                                                      .transactionId);
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                HomeScreen(),
                                                                      ));
                                                                  // Navigator.pop(
                                                                  //     context, 'OK');
                                                                  // child:
                                                                },
                                                                child:
                                                                    const Text(
                                                                        'OK'),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                      icon: Icon(
                                                        Icons.delete_outline,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      "${snapshot.data?[snapshot.data.length - (index + 1)].clientName}",
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

class TransactionOrigin {
  final String itemName;
  final String quantity;
  final String unitPrice;
  final String category;
  final String clientName;
  final String createdAt;
  final String transactionId;

  TransactionOrigin(this.itemName, this.quantity, this.unitPrice, this.category,
      this.clientName, this.createdAt, this.transactionId);
}

class Transactions {
  final String itemName,
      quantity,
      unitPrice,
      category,
      clientName,
      transactionId;

  Transactions(this.itemName, this.quantity, this.unitPrice, this.category,
      this.clientName, this.transactionId);
}
