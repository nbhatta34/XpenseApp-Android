// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xpense_android/Screens/HomeScreen.dart';
import 'package:xpense_android/http/HttpUser.dart';
import 'package:xpense_android/model/ClientModel.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddClientInfo extends StatefulWidget {
  const AddClientInfo({Key? key}) : super(key: key);

  @override
  State<AddClientInfo> createState() => _AddClientInfoState();
}

class _AddClientInfoState extends State<AddClientInfo> {
  final _formKey = GlobalKey<FormState>();

  String clientName = "";
  String mobile = "";
  String address = "";
  String email = "";

  Future<bool> addClientInfo(Clients client) {
    var res = HttpConnectUser().addClientInformation(client);
    return res;
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
          ],
        ),
      ),
    ));
  }
}
