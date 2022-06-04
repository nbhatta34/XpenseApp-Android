import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xpense_android/Screens/HomeScreen.dart';
import 'package:xpense_android/http/HttpUser.dart';
import 'package:xpense_android/model/CategoryModel.dart';
import 'package:image_picker/image_picker.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  @override
  void initState() {
    _image = null;
    super.initState();
  }

  File? _image;
  final _formKey = GlobalKey<FormState>();

  String categoryName = "";
  // File? thumbnail;

  Future<bool> addCategory(Category category) {
    var res = HttpConnectUser().addCategory(category, _image);
    return res;
  }

  //method to open image from gallery
  _imageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image!.path);
    });
  }

  //method to open image from camera
  _imageFromCamera() async {
    print("hello");
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: Text("Add Category")),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 28),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  categoryName = value!;
                },
                // controller: quantityController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  labelText: "Category Name",
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.w500, color: Color(0xff3099EC)),
                  prefixIcon: Icon(
                    Icons.category,
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
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.white),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 2,
                    blurRadius: 3,
                    color: Colors.black38,
                  )
                ],
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: _image == null
                      ? NetworkImage("http://10.0.2.2:3000/uploads/xpense1.png")
                          as ImageProvider
                      : FileImage(_image!),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 28),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.all(10),
                    primary: Colors.orangeAccent,
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          height: 140,
                          child: Column(children: [
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Choose Thumbnail Image",
                              style: GoogleFonts.poppins(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(20),
                                    ),
                                    padding: EdgeInsets.all(13),
                                    primary: Color.fromARGB(255, 255, 72, 0),
                                  ),
                                  onPressed: () {
                                    _imageFromCamera();
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.camera,
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    "Camera",
                                    style: GoogleFonts.poppins(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                ),
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(20),
                                    ),
                                    padding: EdgeInsets.all(13),
                                    primary: Color.fromARGB(255, 255, 72, 0),
                                  ),
                                  onPressed: () {
                                    _imageFromGallery();
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.image,
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    "Gallery",
                                    style: GoogleFonts.poppins(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        );
                      },
                    );
                    // _imageFromGallery();
                    // Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.image,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Uplaod Thumnbnail",
                    style:
                        GoogleFonts.poppins(fontSize: 20, color: Colors.white),
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

                      Category category = Category(
                        categoryName: categoryName,
                        // thumbnail: thumbnail,
                      );
                      bool isCreated = await addCategory(category);
                      if (isCreated) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                        );
                        Fluttertoast.showToast(
                          msg: "Category Added",
                          backgroundColor: Colors.greenAccent,
                          fontSize: 16,
                          gravity: ToastGravity.TOP,
                        );
                      } else {
                        Fluttertoast.showToast(
                          msg: "Failed To Add Category",
                          backgroundColor: Colors.redAccent,
                          fontSize: 16,
                          gravity: ToastGravity.TOP,
                        );
                      }
                      // }
                    }
                  },
                  child: Text(
                    "ADD CATEGORY",
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