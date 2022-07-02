import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xpense_android/Screens/OTPVerify.dart';
import 'package:xpense_android/http/HttpUser.dart';
import 'package:xpense_android/model/UserModel.dart';



class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _sendingOTP = false;

  String email = "";
  String fname = "";
  String lname = "";
  String password = "";
  String confPassword = "";

  TextEditingController _emailController = new TextEditingController();

  Future<bool> registerUser(User u) {
    var res = HttpConnectUser().registerPost(u);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    

    final signupButton = SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          // sendOtp();
          if (_emailController.text.length != 0) {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              setState(() {
                _sendingOTP = true;
              });
              // print(fname + lname + email + password);
              User u = User(
                  firstname: fname,
                  lastname: lname,
                  email: email,
                  password: password);
              bool isCreated = await registerUser(u);

              if (isCreated) {
                setState(() {
                  _sendingOTP = false;
                });
                
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Otp(email: _emailController.text),
                    ));
                Fluttertoast.showToast(
                  msg:
                      "Register Successful. OTP Verification Email Sent To ${_emailController.text}",
                  backgroundColor: Colors.orange,
                  fontSize: 16,
                  gravity: ToastGravity.TOP,
                );
              } else {
                setState(() {
                  _sendingOTP = false;
                });
                Fluttertoast.showToast(
                  msg: "Failed to create user",
                  backgroundColor: Colors.red,
                  fontSize: 16,
                  gravity: ToastGravity.TOP,
                );
              }
            }
          }
      
        },
        key: Key("register"),
        child: Text(
          "SIGN UP",
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 26),
        ),
        style: ElevatedButton.styleFrom(
          primary: Color(0xff3099EC),
          shadowColor: Color(0xff3099EC),
          elevation: 5,
          // padding: EdgeInsets.symmetric(horizontal: 115, vertical: 8),
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30),
          ),
          textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Container(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image(
                    image: AssetImage("assets/images/xpense1.png"),
                    width: 170,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 28.0, right: 28, top: 0),
                    child: TextFormField(
                      onSaved: (value) {
                        email = value!;
                        print(email);
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        filled: true,
                        fillColor: Theme.of(context).cardColor,
                        labelText: "Email",
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xff3099EC)),
                        prefixIcon: Icon(
                          Icons.mail,
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
                        const EdgeInsets.only(left: 28.0, right: 28, top: 18),
                    child: TextFormField(
                      onSaved: (value) {
                        fname = value!;
                        print(fname);
                      },
                      key: Key("fname"),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        filled: true,
                        fillColor: Theme.of(context).cardColor,
                        labelText: "First Name",
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xff3099EC)),
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
                        const EdgeInsets.only(left: 28.0, right: 28, top: 18),
                    child: TextFormField(
                      onSaved: (value) {
                        lname = value!;
                        print(lname);
                      },
                      key: Key("lname"),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        filled: true,
                        fillColor: Theme.of(context).cardColor,
                        labelText: "Last Name",
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xff3099EC)),
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
                        const EdgeInsets.only(left: 28.0, right: 28, top: 18),
                    child: TextFormField(
                      onSaved: (value) {
                        password = value!;
                        print(password);
                      },
                      key: Key("password"),
                      obscureText: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        filled: true,
                        fillColor: Theme.of(context).cardColor,
                        labelText: "Password",
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xff3099EC)),
                        prefixIcon: Icon(
                          Icons.vpn_key_sharp,
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
                        const EdgeInsets.only(left: 28.0, right: 28, top: 18),
                    child: TextFormField(
                      onSaved: (value) {
                        confPassword = value!;
                        print(confPassword);
                      },
                      key: Key("confpassword"),
                      obscureText: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        filled: true,
                        fillColor: Theme.of(context).cardColor,
                        labelText: "Confirm Password",
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xff3099EC)),
                        prefixIcon: Icon(
                          Icons.vpn_key_sharp,
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
                    padding: const EdgeInsets.only(
                        left: 28.0, right: 28, top: 28, bottom: 20),
                    child: signupButton,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
