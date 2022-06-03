import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xpense_android/Screens/EditProfile.dart';
import 'package:xpense_android/Screens/LoginScreen.dart';
import 'package:xpense_android/http/HttpUser.dart';
import 'package:xpense_android/response/GetProfileResponse.dart';
import 'package:jiffy/jiffy.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
    // TODO: implement initState
    super.initState();
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
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {},
                      child: Text(
                        "ADD DOCUMENTS",
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff3099EC),
                        shadowColor: Color(0xff3099EC),
                        elevation: 5,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30),
                        ),
                        textStyle: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
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
}
