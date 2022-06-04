import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xpense_android/Screens/HomeScreen.dart';
import 'package:xpense_android/http/HttpUser.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:xpense_android/model/TransactionModel.dart';
import 'package:xpense_android/response/ClientNameResponse.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AddEarning extends StatefulWidget {
  const AddEarning({Key? key}) : super(key: key);

  @override
  State<AddEarning> createState() => _AddEarningState();
}

class _AddEarningState extends State<AddEarning> {
  TextEditingController itemController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController clientController = TextEditingController();

  final TextEditingController _typeAheadController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    fetchdataClient();
    super.initState();
  }

  List categories = [
    "Print",
    "Binding",
    "Repair",
    "Product",
    "Others",
  ];

  String itemName = "";
  String quantity = "";
  String unitPrice = "";
  String clientName = "";

  Future<bool> addEarnings(Transaction t) {
    var res = HttpConnectUser().addTransaction(t);
    return res;
  }

  String category = "Select Category";

  late double total = 0;
  late double sub_total;

  HttpConnectUser clients = HttpConnectUser();
  ClientResponse responseCatcher = ClientResponse();

  fetchdataClient() async {
    try {
      var response =
          await clients.viewClientInformation("auth/addClientInformation/");

      List clientList = [];

      for (var u in response["data"]) {
        clientList.add(u["clientName"]);
      }
      setState(() {
        clientNameList = clientList;
      });

      return clientList;
    } catch (err) {
      print(err);
    }
  }

  List clientNameList = [];

  @override
  Widget build(BuildContext context) {
    final addButton = SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            if (category == "Select Category") {
              Fluttertoast.showToast(msg: "Please Select A Category");
            } else {
              print(itemName + quantity + unitPrice + category + clientName);
              Transaction t = Transaction(
                itemName: itemName,
                quantity: quantity,
                unitPrice: unitPrice,
                category: category,
                clientName: clientName,
              );
              bool isCreated = await addEarnings(t);
              if (isCreated) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
                Fluttertoast.showToast(
                  msg: "Earning Added",
                  backgroundColor: Colors.greenAccent,
                  fontSize: 16,
                  gravity: ToastGravity.TOP,
                );
              } else {
                Fluttertoast.showToast(
                  msg: "Failed To Add Earning",
                  backgroundColor: Colors.redAccent,
                  fontSize: 16,
                  gravity: ToastGravity.TOP,
                );
              }
            }
          }
        },
        child: Text(
          "ADD TRANSACTION",
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 20),
        ),
        style: ElevatedButton.styleFrom(
          primary: Color(0xff3099EC),
          shadowColor: Color(0xff3099EC),
          elevation: 5,
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30),
          ),
          textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Earning"),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 28),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      itemName = value!;
                    },
                    controller: itemController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      filled: true,
                      fillColor: Theme.of(context).cardColor,
                      labelText: "Item Name",
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xff3099EC),
                      ),
                      prefixIcon: Icon(
                        Icons.edit,
                        color: Color(0xff3099EC),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(111, 161, 161, 161)),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(111, 161, 161, 161)),
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
                      quantity = value!;
                    },
                    controller: quantityController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      filled: true,
                      fillColor: Theme.of(context).cardColor,
                      labelText: "Quantity",
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xff3099EC)),
                      prefixIcon: Icon(
                        Icons.production_quantity_limits,
                        color: Color(0xff3099EC),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(111, 161, 161, 161)),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(111, 161, 161, 161)),
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
                    textInputAction: TextInputAction.done,
                    onSaved: (value) {
                      unitPrice = value!;
                    },
                    onChanged: (value) {
                      try {
                        double quantity = double.parse(quantityController.text);
                        double price = double.parse(priceController.text);
                        double sub_total = quantity * price;
                        print(quantity * price);

                        setState(
                          () {
                            total = sub_total;
                          },
                        );
                      } catch (e) {
                        print(e);
                      }
                    },
                    controller: priceController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      filled: true,
                      fillColor: Theme.of(context).cardColor,
                      labelText: "Unit Price",
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xff3099EC)),
                      prefixIcon: Icon(
                        Icons.attach_money,
                        color: Color(0xff3099EC),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(111, 161, 161, 161)),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(111, 161, 161, 161)),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 28),
                  child: SizedBox(
                    width: double.infinity,
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        filled: true,
                        fillColor: Theme.of(context).cardColor,
                        labelText: "Category",
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xff3099EC)),
                        prefixIcon: Icon(
                          Icons.category,
                          color: Color(0xff3099EC),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(111, 161, 161, 161)),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(111, 161, 161, 161)),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      value: category,
                      items: categories
                          .map(
                            (e) => DropdownMenuItem<String>(
                              value: e,
                              child: Text(e),
                            ),
                          )
                          .toList(),
                      onChanged: (item) => setState(
                        () {
                          category = item!;
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 28),
                  child: TypeAheadFormField(
                    suggestionsCallback: (String pattern) =>
                        clientNameList.where((element) => element
                            .toLowerCase()
                            .contains(pattern.toLowerCase())),
                    itemBuilder: (context, item) {
                      return ListTile(
                        title: Text("${item}"),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      this._typeAheadController.text = suggestion as String;
                    },
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: this._typeAheadController,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        filled: true,
                        fillColor: Theme.of(context).cardColor,
                        labelText: "Client Name",
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xff3099EC),
                        ),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color(0xff3099EC),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(111, 161, 161, 161)),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(111, 161, 161, 161)),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    onSaved: (value) {
                      clientName = value!;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 28),
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 11, 59, 73),
                        borderRadius: BorderRadius.circular(30)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            "Total Rs:  ${total.toString()}",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.poppins(
                              fontSize: 27,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 28.0, horizontal: 28),
                  child: addButton,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ClientFetcher {
  final String? clientName;

  ClientFetcher({
    this.clientName,
  });
}

class CategoryFetcher {
  final String? categoryName;

  CategoryFetcher({
    this.categoryName,
  });
}
