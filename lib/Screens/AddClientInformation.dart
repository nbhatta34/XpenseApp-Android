import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xpense_android/Screens/HomeScreen.dart';
import 'package:xpense_android/http/HttpUser.dart';
import 'package:xpense_android/model/ClientModel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AddClientInfo extends StatefulWidget {
  const AddClientInfo({Key? key}) : super(key: key);

  @override
  State<AddClientInfo> createState() => _AddClientInfoState();
}

class _AddClientInfoState extends State<AddClientInfo> {
  HttpConnectUser clients = HttpConnectUser();

  final _formKey = GlobalKey<FormState>();

  String clientName = "";
  String mobile = "";
  String address = "";
  String email = "";

  Future<bool> addClientInfo(Clients client) {
    var res = HttpConnectUser().addClientInformation(client);
    return res;
  }

  fetchdataClient() async {
    try {
      var response =
          await clients.viewClientInformation("auth/addClientInformation/");

      print(response);

      List<ClientInfoFetcher> clientNameList = [];

      for (var u in response["data"]) {
        ClientInfoFetcher client = ClientInfoFetcher(
          u["clientName"],
          u["mobile"],
          u["email"],
          u["address"],
          u["_id"],
        );

        clientNameList.add(client);
      }

      return clientNameList;
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: Text("Add Client Information")),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 28),
              child: TextFormField(
                // keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  clientName = value!;
                },
                // controller: quantityController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  labelText: "Client Name",
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.w500, color: Color(0xff3099EC)),
                  prefixIcon: Icon(
                    Icons.person,
                    color: Color(0xff3099EC),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(111, 161, 161, 161)),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(111, 161, 161, 161)),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 28),
              child: TextFormField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  mobile = value!;
                },
                // controller: quantityController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  labelText: "Phone Number",
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.w500, color: Color(0xff3099EC)),
                  prefixIcon: Icon(
                    Icons.smartphone_outlined,
                    color: Color(0xff3099EC),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(111, 161, 161, 161)),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(111, 161, 161, 161)),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 28),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  email = value!;
                },
                // controller: quantityController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  labelText: "Email",
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.w500, color: Color(0xff3099EC)),
                  prefixIcon: Icon(
                    Icons.email,
                    color: Color(0xff3099EC),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(111, 161, 161, 161)),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(111, 161, 161, 161)),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 28),
              child: TextFormField(
                keyboardType: TextInputType.streetAddress,
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  address = value!;
                },
                // controller: quantityController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  labelText: "Address",
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.w500, color: Color(0xff3099EC)),
                  prefixIcon: Icon(
                    Icons.location_on_sharp,
                    color: Color(0xff3099EC),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(111, 161, 161, 161)),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(111, 161, 161, 161)),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 28.0, vertical: 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      if (mobile.length != 10) {
                        Fluttertoast.showToast(
                            msg: "Mobile Number is Invalid.");
                      } else {
                        print(clientName + mobile + address + email);
                        Clients client = Clients(
                          clientName: clientName,
                          mobile: mobile,
                          address: address,
                          email: email,
                        );
                        bool isCreated = await addClientInfo(client);
                        if (isCreated) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                          Fluttertoast.showToast(
                            msg: "Client Information Added",
                            backgroundColor: Colors.greenAccent,
                            fontSize: 16,
                            gravity: ToastGravity.TOP,
                          );
                        } else {
                          Fluttertoast.showToast(
                            msg: "Failed To Add Client Information",
                            backgroundColor: Colors.redAccent,
                            fontSize: 16,
                            gravity: ToastGravity.TOP,
                          );
                        }
                      }
                    }
                  },
                  child: Text(
                    "ADD CLIENT",
                    style:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff3099EC),
                    shadowColor: Color(0xff3099EC),
                    elevation: 5,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30),
                    ),
                    textStyle:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: fetchdataClient(),
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
                            "No Client Information To Show",
                            style: GoogleFonts.poppins(
                                fontSize: 23,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54),
                          ),
                        ),
                      );
                    } else {
                      final List<ClientInfoFetcher> clientData = List.generate(
                        snapshot.data.length,
                        (index) => ClientInfoFetcher(
                          '${snapshot.data?[index].clientName}',
                          '${snapshot.data?[index].mobile}',
                          '${snapshot.data?[index].email}',
                          '${snapshot.data?[index].address}',
                          '${snapshot.data?[index].clientId}',
                        ),
                      );
                      return ListView.builder(
                        itemCount: clientData.length,
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
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "${snapshot.data?[snapshot.data.length - (index + 1)].clientName}",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.9),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        SizedBox(height: 5),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .phone_android,
                                                              size: 13,
                                                            ),
                                                            Text(
                                                              "  ${snapshot.data?[snapshot.data.length - (index + 1)].mobile}",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.6),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                              overflow:
                                                                  TextOverflow
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
                                                              "  ${snapshot.data?[snapshot.data.length - (index + 1)].email}",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.6),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 5),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                                Icons
                                                                    .location_on,
                                                                size: 13),
                                                            Text(
                                                              "  ${snapshot.data?[snapshot.data.length - (index + 1)].address}",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.6),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                              overflow:
                                                                  TextOverflow
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
        ),
      ),
    ));
  }
}

class ClientInfoFetcher {
  final String? clientName;
  final String? mobile;
  final String? email;
  final String? address;
  final String? clientId;

  ClientInfoFetcher(
    this.clientName,
    this.mobile,
    this.email,
    this.address,
    this.clientId,
  );
}
