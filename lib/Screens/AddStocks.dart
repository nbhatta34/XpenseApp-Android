import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:xpense_android/Screens/HomeScreen.dart';
import 'package:xpense_android/Screens/Stocks.dart';
import 'package:xpense_android/http/HttpUser.dart';
import 'package:xpense_android/model/StockModel.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AddStock extends StatefulWidget {
  const AddStock({Key? key}) : super(key: key);
  @override
  State<AddStock> createState() => _AddStockState();
}

class _AddStockState extends State<AddStock> {
  TextEditingController stockController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController supplierController = TextEditingController();
  final TextEditingController _typeAheadController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String stockName = "";
  String quantity = "";
  String unitPrice = "";
  String supplierName = "";

  Future<bool> addBuyings(Stock s) {
    var res = HttpConnectUser().addStock(s);
    return res;
  }

  HttpConnectUser suppliers = HttpConnectUser();

  fetchdataSupplier() async {
    try {
      var response = await suppliers
          .viewSupplierInformation("auth/addSupplierInformation/");

      List supplierList = [];

      for (var u in response["data"]) {
        supplierList.add(u["supplierName"]);
      }
      setState(() {
        supplierNameList = supplierList;
      });

      return supplierList;
       } catch (err) {

      print(err);

  }
    }
  fetchdata() async {
    try {
      var response =
          await suppliers.viewStockCategory("auth/addStockCategory/");

      List categoryList = [];

      for (var u in response["data"]) {
        categoryList.add(u["categoryName"]);
      }
      setState(() {
        categoryNameList = categoryList;
        categoryNameList.add("Select Category");
      });

      return categoryList;
    } catch (err) {
      print(err);
    }
  }

  String category = "Select Category";
  late double total = 0;
  late double sub_total;

  List categoryNameList = [];
  List supplierNameList = [];

  @override
  Widget build(BuildContext context) {
    final addButton = SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            print(stockName + quantity + unitPrice + category + supplierName);
            Stock s = Stock(
              stockName: stockName,
              quantity: quantity,
              unitPrice: unitPrice,
              category: category,
              supplierName: supplierName,
            );
            bool isCreated = await addBuyings(s);
            if (isCreated) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
              Fluttertoast.showToast(
                msg: "Stock Added",
                backgroundColor: Colors.greenAccent,
                fontSize: 16,
                gravity: ToastGravity.TOP,
              );
            } else {
              Fluttertoast.showToast(
                msg: "Failed To Add Stock",
                backgroundColor: Colors.redAccent,
                fontSize: 16,
                gravity: ToastGravity.TOP,
              );
            }
          }
        },
        child: Text(
          "ADD STOCK",
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
          title: Text("Add Stocks"),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
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
                      stockName = value!;
                    },
                    controller: stockController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      filled: true,
                      fillColor: Theme.of(context).cardColor,
                      labelText: "Stock Name",
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
                      items: categoryNameList
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
                        supplierNameList.where((element) => element
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
                        labelText: "Supplier Name",
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
                      supplierName = value!;
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
