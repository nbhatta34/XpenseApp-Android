import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xpense_android/Screens/HomeScreen.dart';
import 'package:xpense_android/http/HttpUser.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  HttpConnectUser change = HttpConnectUser();

  bool obscureText = true;

  var passwordIcon = Icons.visibility_off;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Theme.of(context).highlightColor,
        ),
        body: Center(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      left: 18,
                      right: 18,
                    ),
                    child: Text(
                      "Reset Your Password",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Image.asset("assets/images/reset_password.png"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextFormField(
                      controller: newPassword,
                      onSaved: (value) {
                        newPassword.text = value!;
                      },
                      obscureText: obscureText,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).cardColor,
                        // hintText: "Password",
                        labelText: "New Password",
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
                    child: TextFormField(
                      controller: confirmPassword,
                      onSaved: (value) {
                        confirmPassword.text = value!;
                      },
                      obscureText: obscureText,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).cardColor,
                        // hintText: "Password",
                        labelText: "Confirm Password",
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
                          // print(newPassword.text);
                          if (newPassword.text == "" ||
                              confirmPassword.text == "") {
                            Fluttertoast.showToast(
                                msg: "Please Fill Both Fields.");
                          } else {
                            if (newPassword.text != confirmPassword.text) {
                              Fluttertoast.showToast(
                                  msg:
                                      "Passwords Don't Match. Re-type your password.");
                            } else {
                              if (confirmPassword.text.length < 6) {
                                Fluttertoast.showToast(
                                    msg:
                                        "Password must be atleast 6 characters.");
                              } else {
                                // Fluttertoast.showToast(msg: "Passwords Match.");
                                var changePassword = await change
                                    .changePassword(confirmPassword.text);
                                // print(changePassword);
                                if (changePassword == "true") {
                                  Fluttertoast.showToast(
                                    msg: "Password Changed.",
                                  );
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomeScreen(),
                                    ),
                                  );
                                } else {
                                  Fluttertoast.showToast(
                                    msg:
                                        "You have already used this password. Please enter a new password.",
                                  );
                                }
                              }
                            }
                          }
                        },
                        child: Text(
                          "Update Password",
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 20),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xffFF6D00),
                          shadowColor: Color.fromARGB(255, 236, 103, 42),
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
      ),
    );
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
