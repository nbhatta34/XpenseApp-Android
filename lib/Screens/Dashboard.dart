import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xpense_android/Screens/AddCategory.dart';
import 'package:xpense_android/Screens/AddClientInformation.dart';
import 'package:xpense_android/Screens/AddEarning.dart';
import 'package:xpense_android/Screens/EditTransaction.dart';
import 'package:xpense_android/Screens/HomeScreen.dart';
import 'package:xpense_android/Screens/SearchTransactions.dart';
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

  DateTime date = DateTime.now();

  int activeDay = 3;

  bool isOpened = false;
  late AnimationController _animationController;
  late Animation<Color?> _buttonColor;
  late Animation<double> _animationIcon;
  late Animation<double> _translateButton;
  Curve _curve = Curves.linear;
  double _fabHeight = 56.0;

  @override
  void initState() {
    // fetchdata();
    visibility = [true, true, true, true, true, true];
    getCardsData();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addListener(() {
            setState(() {});
          });

    _animationIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    _buttonColor = ColorTween(begin: Colors.blue, end: Colors.red).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.00, 1.00, curve: Curves.linear)));

    _translateButton = Tween<double>(begin: _fabHeight, end: -10.0).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.0, 0.4, curve: _curve)));

    super.initState();
  }

  // Customizable Dashboard Cards

  bool hi = false;

  bool loading = true;

  late List<bool> visibility;

  // ---------------------------------------

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget buttonAdd() {
    return Container(
      child: FloatingActionButton(
        heroTag: "addEarning",
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEarning(),
            ),
          );
        },
        tooltip: "Add Transactions",
        child: Icon(Icons.add_chart_rounded),
      ),
    );
  }

  Widget buttonEdit() {
    return Container(
      child: FloatingActionButton(
        heroTag: "addCategory",
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddCategory(),
              ));
        },
        tooltip: "Add Category",
        child: Icon(Icons.category),
      ),
    );
  }

  Widget buttonDelete() {
    return Container(
      child: FloatingActionButton(
        heroTag: "addClientInfo",
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => AddClientInfo())));
        },
        tooltip: "Add Client Information",
        child: Icon(Icons.person_add),
      ),
    );
  }

  Widget buttonToggle() {
    return Container(
        child: FloatingActionButton(
      backgroundColor: _buttonColor.value,
      onPressed: animate,
      tooltip: "Toggle",
      child: AnimatedIcon(
        icon: AnimatedIcons.menu_close,
        progress: _animationIcon,
      ),
    ));
  }

  animate() {
    if (!isOpened)
      _animationController.forward();
    else
      _animationController.reverse();
    isOpened = !isOpened;
  }

  // Fetching data for Statistics Cards from backend
  List<StatisticsCardModel> cardsQuantityData = [];

  void getCardsData() async {
    var response =
        await transaction.viewTransactions("auth/totalQuantityOfCategories/");

    List<StatisticsCardModel> cardsData = [];

    for (var u in response) {
      StatisticsCardModel cards = StatisticsCardModel(
        u["quantity"],
        u["_id"],
      );
      cardsData.add(cards);
    }

    setState(() {
      cardsQuantityData = cardsData;
      // print(cardsQuantityData.length);
      loading = false;
    });
  }

  // -----------------------------------------------------

  // Fetching Transactions Data From Backend

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
            u["_id"],
            u["userId"]);

        transactions.add(trans);
      }

      return transactions;
    } catch (err) {
      print(err);
    }
  }

  // ----------------------------------------------------------
  // Fetching Transactions of Selected Date
  fetchDataSelectedDate() async {
    // print("Selected Date Function");
    try {
      var response = await transaction.viewSelectedDateTransactions(
          "auth/getSelectedDateTransactions/", date);

      List<TransactionOrigin> transactionsSelectedDate = [];

      for (var u in response) {
        TransactionOrigin trans = TransactionOrigin(
            u["itemName"],
            u["quantity"],
            u["unitPrice"],
            u["category"],
            u["clientName"],
            u["createdAt"],
            u["_id"],
            u["userId"]);

        transactionsSelectedDate.add(trans);
      }
      // print("Data: ");
      // print(transactionsSelectedDate);

      return transactionsSelectedDate;
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dashboard",
          style: GoogleFonts.poppins(fontSize: 19, fontWeight: FontWeight.w500),
        ),
        toolbarHeight: 45,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchTransactions(),
                  ),
                );
              },
              icon: Icon(Icons.search))
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Transform(
            transform: Matrix4.translationValues(
              0.0,
              _translateButton.value * 3.0,
              0.0,
            ),
            child: buttonAdd(),
          ),
          Transform(
            transform: Matrix4.translationValues(
              0.0,
              _translateButton.value * 2.0,
              0.0,
            ),
            child: buttonEdit(),
          ),
          Transform(
            transform: Matrix4.translationValues(
              0.0,
              _translateButton.value,
              0.0,
            ),
            child: buttonDelete(),
          ),
          buttonToggle()
        ],
      ),
      body: getBody(),
    );
  }

  Widget statisticsCards(String categoryName, int quantity) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${quantity}",
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600, color: Colors.white, fontSize: 26),
          ),
          Text(
            "${categoryName}",
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500, color: Colors.white, fontSize: 16),
          ),
        ],
      ),
      // width: MediaQuery.of(context).size.width / 2 - 20,
      // height: 60,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 11, 59, 65),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }

  Widget getBody() {
    return Column(
      children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${date.year}/${date.month}/${date.day}",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: IconButton(
                  onPressed: () async {
                    DateTime? newDate = await showDatePicker(
                      helpText: "SELECT A DATE TO DISPLAY TRANSACTIONS",
                      context: context,
                      initialDate: date,
                      firstDate: DateTime(2022),
                      lastDate: DateTime(2100),
                    );

                    // if 'cancel' null value will be returned
                    if (newDate == null) {
                      return;
                    } else {
                      // if 'ok' selected date will be returned

                      setState(() {
                        hi = true;
                        date = newDate;
                      });

                      // fetchDataSelectedDate();
                    }
                  },
                  color: Colors.blue,
                  tooltip: "Select A Date To Display Transactions",
                  icon: Icon(
                    Icons.date_range_outlined,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    hi = false;
                    date = DateTime.now();
                  });
                },
                icon: Icon(
                  Icons.restart_alt_outlined,
                  color: Colors.blue,
                ),
                label: Text(
                  "Clear",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Current Month's Statistics",
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Theme.of(context).canvasColor,
                    fontWeight: FontWeight.w600),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: loading == true
                      ? Center(
                          child: SpinKitWave(
                            color: Theme.of(context).highlightColor,
                          ),
                        )
                      : cardsQuantityData.length == 0
                          ? Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18.0),
                                    child: Text(
                                      "No Category Stats To Show",
                                      style: GoogleFonts.poppins(
                                        fontSize: 23,
                                        color: Theme.of(context).highlightColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18.0),
                                    child: Text(
                                      "Please Add Some Categories.",
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : GridView.builder(
                              shrinkWrap: true,
                              primary: false,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 1.9,
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              itemCount: cardsQuantityData.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Visibility(
                                    visible: visibility[index],
                                    // maintainAnimation: true,
                                    // maintainSize: true,
                                    // maintainState: true,
                                    child: statisticsCards(
                                        "${cardsQuantityData[index].category}",
                                        cardsQuantityData[index].quantity),
                                  ),
                                );
                              },
                            ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ExpansionTile(
                  onExpansionChanged: ((value) => visibility =
                      List<bool>.filled(cardsQuantityData.length, true)),
                  title: Text(
                    "Select Categories To View On Dashboard",
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Theme.of(context).canvasColor,
                        fontWeight: FontWeight.w500),
                  ),
                  children: [
                    cardsQuantityData.length == 0
                        ? Text("")
                        : ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: cardsQuantityData.length,
                            itemBuilder: (context, index) {
                              return CheckboxListTile(
                                activeColor: Colors.blue,
                                title: Text(
                                    "${cardsQuantityData[index].category}"),
                                value: visibility[index],
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                onChanged: (value) {
                                  setState(() {
                                    visibility[index] = !visibility[index];
                                  });
                                },
                              );
                            },
                          ),
                  ],
                ),
              ),

              // Icon(Icons.search)
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
          child: hi
              ? FutureBuilder(
                  future: fetchDataSelectedDate(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    // print(date);
                    if (snapshot.data == null) {
                      return SpinKitWave(
                        color: Theme.of(context).highlightColor,
                      );
                    } else {
                      if (snapshot.data?.length == 0) {
                        return Container(
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: Text(
                                "No Transactions On This Date",
                                style: GoogleFonts.poppins(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).highlightColor,
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        final List<Transactions> transactionData =
                            List.generate(
                          snapshot.data.length,
                          (index) => Transactions(
                            '${snapshot.data?[index].itemName}',
                            '${snapshot.data?[index].quantity}',
                            '${snapshot.data?[index].unitPrice}',
                            '${snapshot.data?[index].category}',
                            '${snapshot.data?[index].clientName}',
                            '${snapshot.data?[index].transactionId}',
                            '${snapshot.data?[index].userId}',
                          ),
                        );
                        return ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: transactionData.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    onLongPress: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EditTransaction(
                                                    index:
                                                        transactionData.length -
                                                            (index + 1),
                                                    transactions:
                                                        transactionData),
                                          ));
                                    },
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
                                                        border: Border.all(
                                                            width: 1,
                                                            color:
                                                                Colors.white),
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                              "http://10.0.2.2:3000/uploads/${snapshot.data?[snapshot.data.length - (index + 1)].category}_${snapshot.data?[snapshot.data.length - (index + 1)].userId}.png"),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 15),
                                                    Container(
                                                      width: (MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              110) *
                                                          0.5,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "${snapshot.data?[snapshot.data.length - (index + 1)].itemName} x ${snapshot.data?[snapshot.data.length - (index + 1)].quantity}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColorDark,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          SizedBox(height: 5),
                                                          Text(
                                                            "Rs. ${snapshot.data?[snapshot.data.length - (index + 1)].unitPrice}",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Theme.of(
                                                                        context)
                                                                    .highlightColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          SizedBox(height: 5),
                                                          Text(
                                                            "${snapshot.data?[snapshot.data.length - (index + 1)].clientName}",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Theme.of(
                                                                        context)
                                                                    .highlightColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          SizedBox(height: 5),
                                                          Text(
                                                            "${Jiffy(snapshot.data?[snapshot.data.length - (index + 1)].createdAt).yMMMMEEEEd}",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Theme.of(
                                                                        context)
                                                                    .highlightColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
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
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 15,
                                                        color: Color.fromARGB(
                                                            255, 33, 139, 36),
                                                      ),
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
                                                    )
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
                )
              : FutureBuilder(
                  future: fetchdata(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return SpinKitWave(
                        color: Theme.of(context).highlightColor,
                      );
                    } else {
                      if (snapshot.data?.length == 0) {
                        return Container(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18.0),
                                  child: Text(
                                    "No Transactions To Show",
                                    style: GoogleFonts.poppins(
                                      fontSize: 23,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).highlightColor,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18.0),
                                  child: Text(
                                    "Please Add Some Transactions To See Them Here.",
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        final List<Transactions> transactionData =
                            List.generate(
                          snapshot.data.length,
                          (index) => Transactions(
                            '${snapshot.data?[index].itemName}',
                            '${snapshot.data?[index].quantity}',
                            '${snapshot.data?[index].unitPrice}',
                            '${snapshot.data?[index].category}',
                            '${snapshot.data?[index].clientName}',
                            '${snapshot.data?[index].transactionId}',
                            '${snapshot.data?[index].userId}',
                          ),
                        );
                        return ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: transactionData.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    onLongPress: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EditTransaction(
                                                    index:
                                                        transactionData.length -
                                                            (index + 1),
                                                    transactions:
                                                        transactionData),
                                          ));
                                    },
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
                                                        border: Border.all(
                                                            width: 1,
                                                            color:
                                                                Colors.white),
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                              "http://10.0.2.2:3000/uploads/${snapshot.data?[snapshot.data.length - (index + 1)].category}_${snapshot.data?[snapshot.data.length - (index + 1)].userId}.png"),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 15),
                                                    Container(
                                                      width: (MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              110) *
                                                          0.5,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "${snapshot.data?[snapshot.data.length - (index + 1)].itemName} x ${snapshot.data?[snapshot.data.length - (index + 1)].quantity}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColorDark,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          SizedBox(height: 5),
                                                          Text(
                                                            "Rs. ${snapshot.data?[snapshot.data.length - (index + 1)].unitPrice}",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Theme.of(
                                                                        context)
                                                                    .highlightColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          SizedBox(height: 5),
                                                          Text(
                                                            "${snapshot.data?[snapshot.data.length - (index + 1)].clientName}",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Theme.of(
                                                                        context)
                                                                    .highlightColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          SizedBox(height: 5),
                                                          Text(
                                                            "${Jiffy(snapshot.data?[snapshot.data.length - (index + 1)].createdAt).yMMMMEEEEd}",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Theme.of(
                                                                        context)
                                                                    .highlightColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
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
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 15,
                                                        color: Color.fromARGB(
                                                            255, 33, 139, 36),
                                                      ),
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
                                                    )
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
  final String userId;

  TransactionOrigin(
    this.itemName,
    this.quantity,
    this.unitPrice,
    this.category,
    this.clientName,
    this.createdAt,
    this.transactionId,
    this.userId,
  );
}

class Transactions {
  final String itemName,
      quantity,
      unitPrice,
      category,
      clientName,
      transactionId,
      userId;

  Transactions(
    this.itemName,
    this.quantity,
    this.unitPrice,
    this.category,
    this.clientName,
    this.transactionId,
    this.userId,
  );
}

// Statistics Cards Model
class StatisticsCardModel {
  final int quantity;
  final String category;

  StatisticsCardModel(
    this.quantity,
    this.category,
  );
}
