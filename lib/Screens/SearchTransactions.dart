import 'package:xpense_android/Screens/HomeScreen.dart';
import 'package:xpense_android/http/HttpUser.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class SearchTransactions extends StatefulWidget {
  const SearchTransactions({Key? key}) : super(key: key);

  @override
  _SearchTransactionsState createState() => _SearchTransactionsState();
}

class _SearchTransactionsState extends State<SearchTransactions> {
  List transactions = [];
  final controller = TextEditingController();

  HttpConnectUser currentUser = HttpConnectUser();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              height: 50,
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color.fromARGB(211, 255, 124, 2),
                boxShadow: [
                  BoxShadow(
                    color:
                        Theme.of(context).secondaryHeaderColor.withOpacity(0.3),
                    blurRadius: 4,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  icon:
                      Icon(Icons.search, color: Theme.of(context).canvasColor),
                  suffixIcon: controller.text.isNotEmpty
                      ? GestureDetector(
                          child: Icon(Icons.close,
                              color: Theme.of(context).canvasColor),
                          onTap: () {
                            controller.clear();
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                        )
                      : null,
                  hintText: "Search Transactions (E.g. John Doe)",
                  hintStyle: TextStyle(color: Theme.of(context).canvasColor),
                  border: InputBorder.none,
                ),
                style: TextStyle(color: Theme.of(context).canvasColor),
                onChanged: (query) {
                  SearchUser(query);
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  if (controller.text != "") {
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
                                        width:
                                            (MediaQuery.of(context).size.width -
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
                                                    color: Colors.white),
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      "http://10.0.2.2:3000/uploads/${transactions[index].category}_${transactions[index].userId}.png"),
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
                                                    "${transactions[index].itemName} x ${transactions[index].quantity}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Theme.of(context)
                                                            .primaryColorDark,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    "Rs. ${transactions[index].unitPrice}",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Theme.of(context)
                                                            .highlightColor,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    "${transactions[index].clientName}",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Theme.of(context)
                                                            .highlightColor,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    "${Jiffy(transactions[index].createdAt).yMMMMEEEEd}",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Theme.of(context)
                                                            .highlightColor,
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
                                        width:
                                            (MediaQuery.of(context).size.width -
                                                    0) /
                                                2.82,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              "Rs. ${double.parse(transactions[index].quantity) * double.parse(transactions[index].unitPrice)}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                                color: Color.fromARGB(
                                                    255, 33, 139, 36),
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                showDialog<String>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
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
                                                          HttpConnectUser()
                                                              .deleteTransaction(
                                                                  transactions[
                                                                          index]
                                                                      .transactionId);
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        HomeScreen(),
                                                              ));
                                                        },
                                                        child: const Text('OK'),
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
                  } else {
                    return Padding(padding: EdgeInsets.all(0));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  SearchUser(query) async {
    final transactions = await HttpConnectUser().searchUSer(query);

    setState(() {
      this.transactions = transactions;
    });
  }
}
