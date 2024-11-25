import 'package:flutter/cupertino.dart';
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

class BoidVerification extends StatefulWidget {
  const BoidVerification({Key key}) : super(key: key);

  @override
  State<BoidVerification> createState() => _BoidVerificationState();
}

class _BoidVerificationState extends State<BoidVerification> {

  OtpFieldController otpController = OtpFieldController();
  String otpCode = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final Map<String, dynamic> userData =
        ModalRoute.of(context).settings.arguments;
    UserData data = userData['userdata'];
    print(data);

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
                      color: Colors.transparent,
                      height: size.height * .250,
                      child: Stack(children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child:Image.asset("assets/images/cdbl.png", height: size.height * .150),
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    FadeInDown(
                        duration: Duration(milliseconds: 500),
                        child: Text(
                          "BOID Verification",
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
                            "+88" + data.phonenum.toString() +
                            "\n Your OTP Valid for 3 minutes",
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
                              boAdd(data);
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

  Future boAdd(UserData data) async {
    var url = "$API_URI/add_boid.php";
    var response = await http.post(Uri.parse(url), body: {
      "boid": data.boid,
      "username": data.username,
      "phonenum": data.phonenum,
      "otp": otpCode,
    });

    var boData = data.username;
    var data1 = json.decode(response.body);
    if (data1 == "Data not found in CDS") {
      showToast('Your Profile Data is Not matched With CDS Data', Colors.red);
    } else if (data1 == "Data already exist") {
      showToast('User already exist', Colors.red);
    } else if (data1 == "Invalid OTP") {
      showToast('Invalid OTP', Colors.red);
    } else if (data1 == "Successful") {
      showToast('BOID Add Successfully', Colors.green);
      Navigator.of(context)
          .pushNamed("/dashboard", arguments: {"userdata": boData});
    } else {
      showToast('Something Went Wrong', Colors.red);
    }
  }

  void showToast(String message, Color colors) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: colors,
        textColor: Colors.black,
        fontSize: 16.0);
  }
}
