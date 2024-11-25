import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cdbl/models/userdata_model.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../config/contants.dart';

class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String _user;
  String _pass;
  String _email;
  String _boid;
  String _phonenum;

  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController boid = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phonenum = TextEditingController();
  bool _passwordHide = true;
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  final RoundedLoadingButtonController verifyController =
      RoundedLoadingButtonController();

  void loadingState(RoundedLoadingButtonController controller) async {
    _user = user.value.text.toString();
    _pass = pass.value.text.toString();
    _email = email.value.text.toString();
    _boid = boid.value.text.toString();
    _phonenum = phonenum.value.text.toString();

    if (formKey.currentState.validate()) {
      FocusScope.of(context).unfocus();
      var userData = UserData(
        username: _user,
        password: _pass,
        boid: _boid,
        email: _email,
        phonenum: _phonenum,
      );
      Timer(Duration(seconds: 9), () {
        otpSend(userData);
      });
    } else {
      Navigator.of(context).pushNamed("/register");
      showToast('Invalid', Colors.red);
    }
    // });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Column(
                children: <Widget>[
                  Image.asset("assets/images/cdbl.png", height: 100),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Container(
                            width: size.width,
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                TextFormField(
                                  controller: user,
                                  // ignore: missing_return
                                  validator: (val) {
                                    if (val.length == 0)
                                      return ("Username is required");
                                  },

                                  onSaved: (val) {
                                    _user = val;
                                  },
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(10),
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[a-zA-Z0-9]'))
                                  ],
                                  decoration: InputDecoration(
                                    labelText: "Username",
                                    suffixIcon: Icon(
                                      Icons.perm_identity,
                                      color: Colors.lightGreen.shade500,
                                    ),
                                    border: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                TextFormField(
                                  obscureText: _passwordHide,
                                  controller: pass,
                                  // ignore: missing_return
                                  validator: (val) {
                                    if (val.length == 0) {
                                      return ("Password is required");
                                    } else if (val.length < 8)
                                      return "Password must be at least 8 digits long";
                                  },
                                  onSaved: (val) {
                                    _pass = val;
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[a-zA-Z0-9!.@-_*%#?;:><,]'))
                                  ],
                                  decoration: InputDecoration(
                                    labelText: "Password",
                                    suffixIcon: IconButton(
                                      color: Colors.lightGreen.shade500,
                                      icon: _passwordHide
                                          ? Icon(Icons.visibility_rounded)
                                          : Icon(Icons.visibility_off_rounded),
                                      onPressed: () {
                                        setState(() {
                                          _passwordHide = !_passwordHide;
                                        });
                                      },
                                    ),
                                    border: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * .01,
                                ),
                                TextFormField(
                                  controller: boid,
                                  // ignore: missing_return
                                  validator: (val) {
                                    if (val.length == 0) {
                                      return ("User BOID is required");
                                    } else if (val.length <= 15)
                                      return "BO ID must be 16 digits long";
                                  },
                                  onSaved: (val) {
                                    setState(() {
                                      _boid = val;
                                    });
                                  },
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(16),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: "16 Digit BOID",
                                    suffixIcon: Icon(
                                      Icons.format_list_numbered_outlined,
                                      color: Colors.lightGreen.shade500,
                                    ),
                                    border: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * .01,
                                ),
                                TextFormField(
                                  controller: phonenum,
                                  // ignore: missing_return
                                  validator: (val) {
                                    if (val.length == 0)
                                      return ("Mobile is required");
                                  },
                                  onSaved: (val) {
                                    _phonenum = val;
                                  },
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(11),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    labelText:
                                        "Mobile which registered in BO ID",
                                    suffixIcon: Icon(
                                      Icons.phone,
                                      color: Colors.lightGreen.shade500,
                                    ),
                                    border: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * .01,
                                ),
                                TextFormField(
                                  controller: email,
                                  // ignore: missing_return
                                  validator: (email) => EmailValidator.validate(
                                          email)
                                      ? null
                                      : "Invalid email format, Please check again.",
                                  onSaved: (val) {
                                    _email = val;
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[a-zA-Z0-9@.]'))
                                  ],
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    labelText:
                                        "Email which registered in BO ID",
                                    suffixIcon: Icon(
                                      Icons.email,
                                      color: Colors.lightGreen.shade500,
                                    ),
                                    border: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * .01,
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: size.height * .045,
                              ),
                              // TextButton(onPressed: (){}, child: Text("Tap to Reset Button")),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 25.0),
                                child: RoundedLoadingButton(
                                  color: Colors.lightGreen,
                                  successIcon: Icons.check_circle,
                                  failedIcon: Icons.error_outline_rounded,
                                  elevation: 5,
                                  successColor: Colors.lightGreen,
                                  errorColor: Colors.red,
                                  child: Text(
                                    "Register",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 20),
                                  ),
                                  controller: verifyController,
                                  onPressed: () =>
                                      loadingState(verifyController),
                                ),
                              ),
                              SizedBox(
                                height: size.height * .005,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () async {
                                      Navigator.of(context).pushNamed("/");
                                    },
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          const TextSpan(
                                              text: 'Already have an Account?',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Alice-Regular',
                                              )),
                                          TextSpan(
                                              text: ' Log in',
                                              style: TextStyle(
                                                color:
                                                    Colors.lightGreen.shade800,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * .03,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future otpSend(UserData userData) async {
    var url = "$API_URI/otp.php";
    var response = await http.post(Uri.parse(url), body: {
      "email": _email,
      "phonenum": _phonenum,
      "boid": _boid,
    });
    var data = json.decode(response.body);
    if (data == "Data not found in CDS") {
      showToast('Your Profile Data is Not matched With CDS Data', Colors.red);
      Navigator.of(context).pushNamed("/register");
    } else if (data == "Data already exist") {
      showToast('User already exist', Colors.red);
      Navigator.of(context).pushNamed("/register");
    } else if (data == "OTP SENT") {
      showToast('OTP Sent', Colors.green);
      Navigator.of(context)
          .pushNamed("/verification", arguments: {"userdata": userData});
    }
  }

  void showToast(String message, Color colors) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 4,
        backgroundColor: colors,
        textColor: Colors.black,
        fontSize: 16.0);
  }
}
