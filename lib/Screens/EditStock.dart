import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:xpense/Screens/Dashboard.dart';
import 'package:xpense_android/Screens/HomeScreen.dart';
import 'package:xpense_android/Screens/Stocks.dart';
import 'package:xpense_android/http/HttpUser.dart';
import 'package:xpense_android/model/StockModel.dart';
// import 'package:xpense/model/TransactionModel.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditStock extends StatefulWidget {
  const EditStock(
      {Key? key,
      required int this.index,
      required List<StockModel> this.stocks})
      : super(key: key);

  final List<StockModel> stocks;
  final int index;
  @override
  State<EditStock> createState() => _EditStockState(stocks, index);
}

class _EditStockState extends State<EditStock> {
  TextEditingController stockNameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController supplierController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  late List<StockModel> stocks;

  var index;
  _EditStockState(this.stocks, this.index);

  String stockName = "";
  String quantity = "";
  String unitPrice = "";
  // String category = "";
  String supplierName = "";

  String category = "Print";

  late double total = 0;
  late double sub_total;

  List<String> categories = [
    "Print",
    "Repair",
    "Binding",
    "Product",
    "Other",
  ];

  @override
  Widget build(BuildContext context) {
    final addButton = SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            // print(fname + lname + bio + address);
            // print("Save Button Activated");
            Stock u = Stock(
                stockName: stockName,
                quantity: quantity,
                unitPrice: unitPrice,
                category: category,
                supplierName: supplierName);
            HttpConnectUser().updateStock(u, stocks[index].stockId);

            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ));
          }
        },
        child: Text(
          "SAVE STOCK",
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
          title: Text("Edit Stock"),
          backgroundColor: Colors.orange,
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
                    initialValue: "${stocks[index].stockName}",
                    // controller: itemController,

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
                    initialValue: "${stocks[index].quantity}",
                    // controller: quantityController,
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
                        // print(quantity * price);

                        setState(
                          () {
                            total = sub_total;
                          },
                        );
                      } catch (e) {
                        print(e);
                      }
                    },
                    initialValue: "${stocks[index].unitPrice}",
                    // controller: priceController,
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
                      value: "${stocks[index].category}",
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
                      onSaved: (value) {
                        category = value!;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 28),
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    onSaved: (value) {
                      supplierName = value!;
                    },
                    // controller: clientController,
                    initialValue: "${stocks[index].supplierName}",
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
