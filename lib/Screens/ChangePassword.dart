import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xpense_android/Screens/ResetPassword.dart';
import 'package:xpense_android/http/HttpUser.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  HttpConnectUser compare = HttpConnectUser();

  TextEditingController password = TextEditingController();

  bool obscureText = true;

  var passwordIcon = Icons.visibility_off;

  @override
  void initState() {
    super.initState();
  }

  comparePass() async {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        foregroundColor: Theme.of(context).highlightColor,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    left: 18,
                    right: 18,
                  ),
                  child: Text(
                    "Want to update your password?",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      fontSize: 22,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Text(
                    "Enter your current password below to proceed to password reset screen.",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Theme.of(context).highlightColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Image.asset("assets/images/change_password.png"),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextFormField(
                    controller: password,
                    // onSaved: (value),

                    obscureText: obscureText,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context).cardColor,
                      // hintText: "Password",
                      labelText: "Current Password",
                      labelStyle: TextStyle(
                        color: Theme.of(context).canvasColor,
                        fontWeight: FontWeight.w500,
                      ),
                      prefixIcon: Icon(
                        Icons.vpn_key,
                        color: Color.fromARGB(255, 124, 124, 124),
                      ),
                      suffixIcon: InkWell(
                        splashColor: Colors.transparent,
                        onTap: _hideUnhidePassword,
                        child: Icon(
                          passwordIcon,
                          color: Color.fromARGB(255, 124, 124, 124),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (password.text.length == 0) {
                          Fluttertoast.showToast(
                            msg: "Please Enter Your Current Password",
                          );
                        } else {
                          var response =
                              await compare.comparePassword(password.text);
                          print(response);
                          if (response == "true") {
                            Fluttertoast.showToast(
                                msg: "Correct Password. Reset Your Password.",
                                gravity: ToastGravity.TOP,
                                backgroundColor: Colors.green);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResetPassword(),
                              ),
                            );
                          } else {
                            Fluttertoast.showToast(
                                msg:
                                    "Incorrect Password. Re-type your password.",
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.red);
                          }
                        }
                      },
                      child: Text(
                        "Reset Password",
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 185, 92, 194),
                        shadowColor: Color.fromARGB(255, 185, 92, 194),
                        elevation: 5,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10),
                        ),
                        textStyle: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  void _hideUnhidePassword() async {
    setState(() {
      obscureText = !obscureText;
      if (obscureText == true) {
        passwordIcon = Icons.visibility_off;
      } else {
        passwordIcon = Icons.visibility;
      }
    });
  }
}
