import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xpense_android/http/HttpUser.dart';
import 'package:xpense_android/model/UserProfile.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xpense_android/response/GetProfileResponse.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key, required this.list}) : super(key: key);

  final List list;

  @override
  State<EditProfile> createState() => _EditProfileState(list);
}

class _EditProfileState extends State<EditProfile> {
  late List list;

  @override
  void initState() {
    super.initState();
    _image = null;
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

  final _formKey = GlobalKey<FormState>();

  HttpConnectUser currentUser = HttpConnectUser();
  ResponseGetUser responseCatcher = ResponseGetUser();

  File? _image;

  String address = "";
  String fname = "";
  String lname = "";
  String mobile = "";
  String pan_vat_no = "";
  String businessName = "";

  _EditProfileState(this.list);
  @override
  Widget build(BuildContext context) {
    print(list);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text(
            "Edit Profile",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
          ),
          // actions: [DarkThemeToggle()],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 35,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      border: Border.all(width: 4, color: Colors.white),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 3,
                          blurRadius: 7,
                          color: Colors.black38,
                        )
                      ],
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: _image == null
                            ? NetworkImage(
                                    "http://192.168.1.64:3000/uploads/${list[6]}")
                                as ImageProvider
                            : FileImage(_image!),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.orange,
                        border: Border.all(width: 3, color: Colors.white),
                      ),
                      child: IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                height: 140,
                                child: Column(children: [
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "Choose Profile Image",
                                    style: GoogleFonts.poppins(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black54),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(20),
                                          ),
                                          padding: EdgeInsets.all(13),
                                          primary:
                                              Color.fromARGB(255, 255, 72, 0),
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
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ),
                                      ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(20),
                                          ),
                                          padding: EdgeInsets.all(13),
                                          primary:
                                              Color.fromARGB(255, 255, 72, 0),
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
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                              );
                            },
                          );
                        },
                        icon: Icon(
                          Icons.edit_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 15),
                      child: TextFormField(
                        onSaved: (value) {
                          setState(
                            () {
                              fname = value!;
                            },
                          );
                        },
                        initialValue: list[0],
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          filled: true,
                          fillColor: Colors.black12,
                          labelText: "First Name",
                          // hintText: "${responseCatcher.data?.fname}",
                          labelStyle: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w400),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.blueAccent,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 15),
                      child: TextFormField(
                        onSaved: (value) {
                          setState(
                            () {
                              lname = value!;
                            },
                          );
                        },
                        initialValue: list[1],
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          filled: true,
                          fillColor: Colors.black12,
                          labelText: "Last Name",
                          labelStyle: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w400),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.blueAccent,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 15),
                      child: TextFormField(
                        onSaved: (value) {
                          setState(
                            () {
                              mobile = value!;
                            },
                          );
                        },
                        initialValue: list[2],
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          filled: true,
                          fillColor: Colors.black12,
                          labelText: "Mobile",
                          labelStyle: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w400),
                          prefixIcon: Icon(
                            Icons.smartphone_rounded,
                            color: Colors.blueAccent,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 15),
                      child: TextFormField(
                        onSaved: (value) {
                          setState(
                            () {
                              address = value!;
                            },
                          );
                        },
                        initialValue: list[3],
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          filled: true,
                          fillColor: Colors.black12,
                          labelText: "Address",
                          labelStyle: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w400),
                          prefixIcon: Icon(
                            Icons.location_on,
                            color: Colors.blueAccent,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 15),
                      child: TextFormField(
                        onSaved: (value) {
                          setState(
                            () {
                              businessName = value!;
                            },
                          );
                        },
                        initialValue: list[4],
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          filled: true,
                          fillColor: Colors.black12,
                          labelText: "Business Name",
                          labelStyle: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w400),
                          prefixIcon: Icon(
                            Icons.business_center,
                            color: Colors.blueAccent,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 15),
                      child: TextFormField(
                        onSaved: (value) {
                          setState(
                            () {
                              pan_vat_no = value!;
                            },
                          );
                        },
                        initialValue: list[5],
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          filled: true,
                          fillColor: Colors.black12,
                          labelText: "PAN/VAT No.",
                          labelStyle: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w400),
                          prefixIcon: Icon(
                            Icons.numbers_outlined,
                            color: Colors.blueAccent,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 20),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          if (mobile.length != 10) {
                            Fluttertoast.showToast(
                                msg: "Mobile number is invalid");
                          } else {
                            print("Save Button Activated");
                            UserProfile u = UserProfile(
                              firstname: fname,
                              lastname: lname,
                              address: address,
                              mobile: mobile,
                              businessName: businessName,
                              pan_vat_no: pan_vat_no,
                            );
                            HttpConnectUser().updateProfile(u, _image);
                            Fluttertoast.showToast(
                              msg: "Pofile Updated",
                              backgroundColor: Colors.greenAccent,
                              fontSize: 16,
                              gravity: ToastGravity.TOP,
                            );
                            Navigator.pop(context);
                          }
                        }
                      },
                      child: Text(
                        "Save",
                        style: GoogleFonts.poppins(
                            fontSize: 17, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueAccent,
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 60),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancel",
                        style: GoogleFonts.poppins(
                            fontSize: 17,
                            color: Theme.of(context).iconTheme.color),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 60),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
