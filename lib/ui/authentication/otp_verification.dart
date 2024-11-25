import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cdbl/models/userdata_model.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import '../../config/contants.dart';

class Verification extends StatefulWidget {
  const Verification({Key key}) : super(key: key);

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  OtpFieldController otpController = OtpFieldController();
  String otpCode = "";
  int _currentIndex = 0;

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        _currentIndex++;
        if (_currentIndex == 3) _currentIndex = 0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> userData =
        ModalRoute.of(context).settings.arguments;
    UserData dataa = userData['userdata'];

    return Scaffold(
        backgroundColor: Colors.white,
        body: Scaffold(
          backgroundColor: Colors.green.shade50,
          body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 250,
                      child: Stack(children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: AnimatedOpacity(
                            opacity: _currentIndex == 0 ? 1 : 0,
                            duration: Duration(
                              seconds: 1,
                            ),
                            curve: Curves.linear,
                            child:Image.network(
                              'https://cdbl.com.bd/img/2.jpg',
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: AnimatedOpacity(
                            opacity: _currentIndex == 1 ? 1 : 0,
                            duration: Duration(seconds: 1),
                            curve: Curves.linear,
                            child:Image.network(
                              'https://cdbl.com.bd/img/1.jpg',
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: AnimatedOpacity(
                            opacity: _currentIndex == 2 ? 1 : 0,
                            duration: Duration(seconds: 1),
                            curve: Curves.linear,
                            child: Image.network(
                              'https://cdbl.com.bd/img/6.jpg',
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: AnimatedOpacity(
                            opacity: _currentIndex == 3 ? 1 : 0,
                            duration: Duration(seconds: 1),
                            curve: Curves.linear,
                            child: Image.network(
                              'https://cdbl.com.bd/img/4.jpg',
                            ),
                          ),
                        )
                      ]),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    FadeInDown(
                        duration: Duration(milliseconds: 500),
                        child: Text(
                          "User Verification",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    FadeInDown(
                      delay: Duration(milliseconds: 500),
                      duration: Duration(milliseconds: 500),
                      child: Text(
                        "Please enter the 4 digit code sent to \n" +
                            "+88" + dataa.phonenum.toString() + "\n Your OTP Valid for 3 minutes",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade500,
                            height: 1.5),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    // Verification Code Input
                    FadeInDown(
                      delay: Duration(milliseconds: 600),
                      duration: Duration(milliseconds: 500),
                      child: OTPTextField(
                        controller: otpController,
                        length: 4,
                        width: MediaQuery.of(context).size.width,
                        textFieldAlignment: MainAxisAlignment.spaceAround,
                        fieldWidth: 45,
                        fieldStyle: FieldStyle.box,
                        outlineBorderRadius: 15,
                        style: TextStyle(fontSize: 17),
                        onCompleted: (pin) {},
                        onChanged: (pin) {
                          otpCode = pin;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FadeInDown(
                      delay: Duration(milliseconds: 800),
                      duration: Duration(milliseconds: 500),
                      child: MaterialButton(
                        elevation: 0,
                        onPressed:
                             ()  {
                                register(dataa);
                              },
                        color: Colors.lightGreen,
                        minWidth: MediaQuery.of(context).size.width * 0.8,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check_circle,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                            Text("Verify", style:TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20),)
                          ],
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ));
  }

  Future register(UserData dataa) async {
    var url = "$API_URI/register.php";
    var response = await http.post(Uri.parse(url), body: {
      "username": dataa.username,
      "password": dataa.password,
      "boid": dataa.boid,
      "email": dataa.email,
      "phonenum": dataa.phonenum,
      "otp": otpCode,
    });
    print(response.body);
    var data = json.decode(response.body);
    if (data == "Data not found in CDS") {
      showToast('Your Profile Data is Not matched With CDS Data', Colors.red);
    } else if (data == "Data already exist") {
      showToast('User already exist', Colors.red);
    } else if (data == "Invalid OTP") {
      showToast('Invalid OTP', Colors.red);
    } else if (data == "Successful") {
      showToast('Registration Successful', Colors.green);
      Navigator.of(context).pushNamed("/");
    } else {
      showToast('Something Went Wrong', Colors.red);
    }
  }

  void showToast(String message, Color colors) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: colors,
        textColor: Colors.black,
        fontSize: 16.0);
  }
}
