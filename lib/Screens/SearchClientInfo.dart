import 'package:xpense_android/Screens/AddClientInformation.dart';
import 'package:xpense_android/http/HttpUser.dart';
import 'package:flutter/material.dart';

class SearchClientInfo extends StatefulWidget {
  const SearchClientInfo({Key? key}) : super(key: key);

  @override
  _SearchClientInfoState createState() => _SearchClientInfoState();
}

class _SearchClientInfoState extends State<SearchClientInfo> {
  List client = [];
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
                  hintText: "Search Client (By Name, Mobile, Address, Email)",
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
                itemCount: client.length,
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
                                              // width:
                                              //     (MediaQuery.of(context)
                                              //                 .size
                                              //                 .width -
                                              //             110) *
                                              //         0.75,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${client[index].clientName}",
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
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.phone_android,
                                                        size: 13,
                                                      ),
                                                      Text(
                                                        "  ${client[index].mobile}",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Theme.of(
                                                                    context)
                                                                .highlightColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 5),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.email,
                                                        size: 13,
                                                      ),
                                                      Text(
                                                        "  ${client[index].email}",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Theme.of(
                                                                    context)
                                                                .highlightColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 5),
                                                  Row(
                                                    children: [
                                                      Icon(Icons.location_on,
                                                          size: 13),
                                                      Text(
                                                        "  ${client[index].address}",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Theme.of(
                                                                    context)
                                                                .highlightColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ],
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
                                                        'Client information will be deleted permanently.'),
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
                                                              .deleteClientInformation(
                                                                  client[index]
                                                                      .clientId);
                                                          Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        AddClientInfo(),
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
    final client = await HttpConnectUser().searchClientInfo(query);

    setState(() {
      this.client = client;
    });
  }
}
