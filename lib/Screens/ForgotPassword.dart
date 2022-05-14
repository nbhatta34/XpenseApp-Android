import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  String email = "";
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
              ),
              Text(
                "Forgot Password",
                style: GoogleFonts.poppins(
                    fontSize: 30, fontWeight: FontWeight.w600),
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Material(
                    shadowColor: Color.fromARGB(255, 190, 190, 190),
                    elevation: 5,
                    borderRadius: BorderRadius.circular(30),
                    child: TextFormField(
                      onSaved: (value) {
                        email = value!;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Please enter your email.");
                        } else {
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            Fluttertoast.showToast(
                                msg: "Please enter a valid email.");
                          }
                        }

                        // Reg Exp for email validation
                      },
                      // key: Key("email"),
                      controller: emailController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(66, 255, 255, 255),
                        // hintText: "Email",
                        labelText: "Email",
                        labelStyle: TextStyle(
                          color: Color(0xff3099EC),
                          fontWeight: FontWeight.w500,
                        ),
                        prefixIcon: Icon(
                          Icons.mail,
                          color: Color(0xff3099EC),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // print(emailController.text);
                  // print("object");
                  // if (_formKey.currentState!.validate()) {
                  //   forgotPassword(emailController.text);
                  // }
                },
                child: Text(
                  "Send Password Reset Link",
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 19),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff3099EC),
                  shadowColor: Color(0xff3099EC),
                  elevation: 5,
                  // padding: EdgeInsets.symmetric(horizontal: 130, vertical: 14),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // void forgotPassword(String email) async {
  //   print("Forgot Password Function");
  //   if (emailController.text == "") {
  //     Fluttertoast.showToast(msg: "Please enter your email.");
  //   } else {
  //     if (_formKey.currentState!.validate()) {
  //       Fluttertoast.showToast(
  //           msg: "The email format is valid.  ${emailController.text}");
  //       _auth.sendPasswordResetEmail(email: email);
  //       Fluttertoast.showToast(
  //           msg:
  //               "A password reset link has been sent to ${emailController.text}.");
  //     }
  //   }
  // }
}
