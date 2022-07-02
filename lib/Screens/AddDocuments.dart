import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xpense_android/Screens/HomeScreen.dart';
import 'package:xpense_android/http/HttpUser.dart';

class AddDocuments extends StatefulWidget {
  const AddDocuments({Key? key}) : super(key: key);

  @override
  State<AddDocuments> createState() => _AddDocumentsState();
}

class _AddDocumentsState extends State<AddDocuments> {
  List<File> _images = [];
  late File imageFile;
  final picker = ImagePicker();

  HttpConnectUser images = HttpConnectUser();

  chooseImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _images.add(
          File(pickedFile.path),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Theme.of(context).highlightColor,
          title: Text(
            "Add Documents",
            style: GoogleFonts.poppins(
              fontSize: 23,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SizedBox(
          width: 200,
          child: FloatingActionButton(
            onPressed: () {
              if (_images.length != 0) {
                Fluttertoast.showToast(
                  msg: "Uploaded ${_images.length} Image Successfully",
                );
                images.addDocuments(_images);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              } else {
                Fluttertoast.showToast(
                  msg: "Please select atleast 1 image",
                );
              }
            },
            child: Text(
              "Upload Images",
              style: GoogleFonts.poppins(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return GridView.builder(
                  itemCount: _images.length + 1,
                  itemBuilder: (context, index) {
                    // print(_images.length);
                    if (_images.length == index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: GestureDetector(
                          onTap: () {
                            chooseImage();
                          },
                          child: Container(
                            child: DottedBorder(
                              color: Colors.grey,
                              strokeWidth: 2,
                              radius: Radius.circular(8),
                              dashPattern: [1, 2],
                              child: ClipRect(
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  child: Icon(Icons.add),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                              image: DecorationImage(
                                image: FileImage(_images[index]),
                                fit: BoxFit.cover,
                              )),
                        ),
                      );
                    }
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: constraints.maxWidth > 300 ? 3 : 2,
                    childAspectRatio: 0.8,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
