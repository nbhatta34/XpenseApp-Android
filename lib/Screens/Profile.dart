import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xpense_android/Screens/AddDocuments.dart';
import 'package:xpense_android/Screens/EditProfile.dart';
import 'package:xpense_android/Screens/HomeScreen.dart';
import 'package:xpense_android/http/HttpUser.dart';
import 'package:xpense_android/response/GetProfileResponse.dart';
import 'package:jiffy/jiffy.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Widget cards(String heading, String subHeading) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color.fromARGB(66, 148, 148, 148),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                heading,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                subHeading,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  HttpConnectUser currentUser = HttpConnectUser();
  ResponseGetUser responseCatcher = ResponseGetUser();

  @override
  void initState() {
    super.initState();
    fetchUserDocuments();
    fetchdata();
  }

  Future<bool> fetchdata() async {
    try {
      var response = await currentUser.getCurrentUser("auth/register/");
      var _jsonDecode = response["data"];
      print(_jsonDecode);

      setState(() {
        responseCatcher = ResponseGetUser.fromJson(response);
      });
    } catch (err) {
      print(err);
    }
    return Future.value(true);
  }

  fetchUserDocuments() async {
    var documentResponse = await currentUser.fetchDocuments();
    return documentResponse;
  }

  @override
  Widget build(BuildContext context) {
    if (responseCatcher.data?.picture == null) {
      // print(data);
      return SpinKitWave(
        color: Colors.black54,
      );
    } else {
      return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    splashColor: Colors.transparent,
                    onPressed: () async {
                      setState(() {});
                      final List listEditProfile = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfile(
                            list: [
                              "${responseCatcher.data?.fname}",
                              "${responseCatcher.data?.lname}",
                              "${responseCatcher.data?.mobile}",
                              "${responseCatcher.data?.address}",
                              "${responseCatcher.data?.businessName}",
                              "${responseCatcher.data?.pan_vat_no}",
                              "${responseCatcher.data?.picture}",
                            ],
                          ),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.edit,
                      size: 30,
                    ),
                  ),
                ),
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
                      image: NetworkImage(
                          "http://10.0.2.2:3000/uploads/${responseCatcher.data?.picture}"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Center(
                    child: Text(
                      "${responseCatcher.data?.fname} ${responseCatcher.data?.lname}",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "${responseCatcher.data?.email}",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 30,
                ),
                cards("EMAIL", "${responseCatcher.data?.email}"),
                cards("BUSINESS NAME", "${responseCatcher.data?.businessName}"),
                cards("PAN/VAT No.", "${responseCatcher.data?.pan_vat_no}"),
                cards("PHONE", "${responseCatcher.data?.mobile}"),
                cards("ADDRESS", "${responseCatcher.data?.address}"),
                cards("JOIN DATE",
                    "${Jiffy(responseCatcher.data?.createdAt).yMMMMEEEEd}"),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 14,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Your Documents",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),

                FutureBuilder(
                  future: fetchUserDocuments(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    // print(date);
                    if (snapshot.data == null) {
                      return SpinKitWave(
                        color: Theme.of(context).highlightColor,
                      );
                    } else {
                      if (snapshot.data?.length == 0) {
                        return Container(
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: Text(
                                "No Documents Added",
                                style: GoogleFonts.poppins(
                                    fontSize: 23,
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).highlightColor),
                              ),
                            ),
                          ),
                        );
                      } else {
                        // print(snapshot.data.length);
                        return GridView.builder(
                          shrinkWrap: true,
                          primary: false,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 3,
                                  height: MediaQuery.of(context).size.width / 3,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.white),
                                    // shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        "http://192.168.1.66:3000/uploads/photo_${snapshot.data?[snapshot.data.length - (index + 1)]['userId']}_${snapshot.data?[snapshot.data.length - (index + 1)]['picture']}",
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                FittedBox(
                                  child: Text(
                                    "${snapshot.data?[index]["picture"].split("_").last.split(".").first.split("r").last}",
                                    maxLines: 1,
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                Wrap(
                                  spacing: 30,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        _save(
                                            "http://192.168.1.65:3000/uploads/photo_${snapshot.data?[snapshot.data.length - (index + 1)]['userId']}_${snapshot.data?[snapshot.data.length - (index + 1)]['picture']}");
                                      },
                                      child: Icon(
                                        Icons.download_rounded,
                                        color: Colors.green,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            title: const Text(
                                                'Are you sure you want to delete?'),
                                            content: const Text(
                                                'Document will be deleted permanently.'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'Cancel'),
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  print(snapshot.data?[
                                                      snapshot.data.length -
                                                          (index + 1)]["_id"]);
                                                  HttpConnectUser()
                                                      .deleteDocument(
                                                    snapshot.data?[
                                                        snapshot.data.length -
                                                            (index + 1)]["_id"],
                                                  );
                                                  Navigator.pop(context, 'OK');
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          HomeScreen(),
                                                    ),
                                                  );
                                                },
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      child: Icon(
                                        Icons.delete_forever_rounded,
                                        color: Colors.orange,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            );
                          },
                          itemCount: snapshot.data.length,
                        );
                      }
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 18.0,
                    right: 18,
                    left: 18,
                    top: 10,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddDocuments(),
                            ));
                      },
                      child: Text(
                        "ADD DOCUMENTS",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff3099EC),
                        shadowColor: Color(0xff3099EC),
                        elevation: 5,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10),
                        ),
                        textStyle: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                // cards(heading, subHeading),
              ],
            ),
          ),
        ),
      );
    }
  }

  _save(String url) async {
    var status = await Permission.storage.request();
    var response = await Dio().get(
      url,
      options: Options(responseType: ResponseType.bytes),
    );
    final result = await ImageGallerySaver.saveImage(
      Uint8List.fromList(response.data),
      quality: 100,
      name: url.split("_").last,
    );
    if (result["isSuccess"] == true) {
      Fluttertoast.showToast(
        msg: "Image saved to gallery.",
      );
    } else {
      Fluttertoast.showToast(
        msg: "Failed to download.",
        textColor: Colors.red,
      );
    }
    print(result["isSuccess"]);
  }
}
