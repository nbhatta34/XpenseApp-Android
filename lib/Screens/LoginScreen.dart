import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xpense_android/Screens/ForgotPassword.dart';
import 'package:xpense_android/http/HttpUser.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  bool obscureText = true;

  bool isChecked = false;

  var passwordIcon = Icons.visibility_off;

  final _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";

  Future<bool> loginPost(String email, String password) {
    var res = HttpConnectUser().loginPosts(email, password);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Color.fromARGB(255, 255, 109, 99);
      }
      return Color(0xff3099EC);
    }

    final emailField = Material(
      shadowColor: Color.fromARGB(255, 190, 190, 190),
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      child: TextFormField(
        onSaved: (value) {
          email = value!;
        },
        validator: (value) {
          if (value!.isEmpty) {
            Fluttertoast.showToast(msg: "Please enter your email.");
          }

          // Reg Exp for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            Fluttertoast.showToast(msg: "Please enter a valid email.");
          }
          return null;
        },
        key: Key("email"),
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
    );

    final passwordField = Material(
      shadowColor: Color.fromARGB(255, 190, 190, 190),
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      child: TextFormField(
        onSaved: (value) {
          password = value!;
        },
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required for login");
          }
          if (!regex.hasMatch(value)) {
            return ("Please enter a valid password (min 6 chars)");
          }
        },
        key: Key("password"),
        controller: passwordController,
        obscureText: obscureText,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color.fromARGB(66, 255, 255, 255),
          // hintText: "Password",
          labelText: "Password",
          labelStyle: TextStyle(
            color: Color(0xff3099EC),
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: Icon(
            Icons.vpn_key,
            color: Color(0xff3099EC),
          ),
          suffixIcon: InkWell(
            splashColor: Colors.transparent,
            onTap: _hideUnhidePassword,
            child: Icon(
              passwordIcon,
              color: Color(0xff3099EC),
            ),
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
    );

    final loginButton = SizedBox(
      width: double.infinity, // <-- match_parent
      height: 50, // <-- match-parent
      child: ElevatedButton(
        key: Key("login"),
        onPressed: () async {
          _formKey.currentState!.save();
          var res = await loginPost(email, password);
          if (res) {
            Fluttertoast.showToast(
                msg: "Login Successful",
                backgroundColor: Colors.greenAccent,
                gravity: ToastGravity.TOP);
          } else {
            Fluttertoast.showToast(
                msg: "Invalid Creadentials",
                backgroundColor: Colors.redAccent,
                gravity: ToastGravity.TOP);
          }
        },
        child: Text(
          "LOGIN",
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 26),
        ),
        style: ElevatedButton.styleFrom(
          primary: Color(0xff3099EC),
          shadowColor: Color(0xff3099EC),
          elevation: 5,
          // padding: EdgeInsets.symmetric(horizontal: 130, vertical: 14),
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30),
          ),
          textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    );

    final googleButton = SizedBox(
      width: double.infinity, // <-- match_parent
      height: 50, // <-- match-parent
      child: TextButton.icon(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
            Color.fromARGB(255, 16, 55, 85),
          ),
        ),
        onPressed: () {},
        icon: Image.asset(
          'assets/images/g.png',
          width: 30,
        ),
        label: Text(
          'Sign in with Google',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 21,
          ),
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
                    width: 180,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 28.0, right: 28, top: 0),
                    child: emailField,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 28.0, right: 28, top: 18),
                    child: passwordField,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 27),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Remember Me",
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff3099EC),
                          ),
                        ),
                        Checkbox(
                          value: isChecked,
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          onChanged: (value) {
                            isChecked = !isChecked;
                            setState(
                              () {
                                isChecked = value!;
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 28.0, right: 28, top: 28),
                    child: loginButton,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPassword(),
                            ),
                          );
                        },
                        child: Text(
                          "Forgot Password?",
                          style: GoogleFonts.poppins(
                              color: Color.fromARGB(255, 26, 0, 73),
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Text(
                          "Don't Have an Account ? ",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Color(0xff3099EC),
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  )
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
