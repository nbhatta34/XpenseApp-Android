import 'package:flutter/material.dart';
import 'package:xpense_android/Screens/LoginScreen.dart';
import 'package:xpense_android/http/HttpUser.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Otp extends StatefulWidget {
  const Otp({Key? key, required this.email}) : super(key: key);

  final String email;

  @override
  _OtpState createState() => _OtpState(email);
}

class _OtpState extends State<Otp> {
  TextEditingController one = new TextEditingController();
  TextEditingController two = new TextEditingController();
  TextEditingController three = new TextEditingController();
  TextEditingController four = new TextEditingController();

  HttpConnectUser verifyOTP = HttpConnectUser();

  _OtpState(this.email);

  late String email;

  @override
  void initState() {
    fetchUserIdWithEmail();
    super.initState();
  }

  late String userId;

  fetchUserIdWithEmail() async {
    var userIdResponse = await verifyOTP.getUserId("auth/getUserId/", email);
    print(userIdResponse[0]["_id"]);
    var userIdFetched = userIdResponse[0]["_id"];
    setState(() {
      userId = userIdFetched;
    });
    return userId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Color(0xfff7f6fb),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back,
                    size: 32,
                    color: Theme.of(context).canvasColor,
                  ),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/images/illustration-3.png',
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                'Email Verification',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Enter Your OTP Code Number Sent To Your Email",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).highlightColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 28,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _textFieldOTP(first: true, last: false, digit: one),
                        _textFieldOTP(first: false, last: false, digit: two),
                        _textFieldOTP(first: false, last: false, digit: three),
                        _textFieldOTP(first: false, last: true, digit: four),
                      ],
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          var verify = await verifyOTP.verifyOTPEmail(
                            "auth/verifyOTP/",
                            userId,
                            "${one.text}${two.text}${three.text}${four.text}",
                          );

                          if (verify == "VERIFIED") {
                            Fluttertoast.showToast(
                              msg: "Your email has been verified",
                              backgroundColor: Colors.green,
                              fontSize: 16,
                              gravity: ToastGravity.TOP,
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          } else {
                            Fluttertoast.showToast(
                              msg: "Invalid OTP",
                              backgroundColor: Colors.red,
                              fontSize: 16,
                              gravity: ToastGravity.TOP,
                            );
                          }
                        },
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.purple),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text(
                            'Verify',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                "Didn't receive a code?",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).highlightColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 18,
              ),
              InkWell(
                onTap: () async {
                  print(userId + "||" + email);
                  var resend = await verifyOTP.resendOTP(
                    "auth/resendOTP/",
                    userId,
                    email,
                  );
                },
                child: Text(
                  "Send A New Code",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textFieldOTP({bool? first, last, TextEditingController? digit}) {
    return Container(
      height: MediaQuery.of(context).size.height / 15,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          controller: digit,
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 2, color: Theme.of(context).highlightColor),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.purple),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}
