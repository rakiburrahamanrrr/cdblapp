import 'dart:convert';
import 'package:cdbl/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../config/contants.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _user;
  String _pass;
  var defaultText =
      TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold);
  var linkText = TextStyle(
      color: Colors.lightGreen, fontSize: 18, fontWeight: FontWeight.bold);

  var defaultTextt =
      TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold);
  var linkTextt = TextStyle(
      color: Colors.lightGreen, fontSize: 23, fontWeight: FontWeight.bold);

  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool _passwordHide = true;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      body: Responsive(
        mobile: Container(
          child: Column(
            children: [
              Expanded(
                flex: 16,
                child: Container(
                  alignment: Alignment.center,
                  child: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Card(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              clipBehavior: Clip.antiAlias,
                              child: Container(
                                decoration: BoxDecoration(
                                  //borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16.0, left: 30, right: 30),
                                  child: Column(
                                    children: [
                                      Image.asset("assets/images/cdbl.png",
                                          height: 150),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            child: Form(
                                              key: formKey,
                                              child: Column(
                                                children: [
                                                  TextFormField(
                                                    key: Key('username'),
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
                                                      LengthLimitingTextInputFormatter(
                                                          10),
                                                      FilteringTextInputFormatter
                                                          .allow(RegExp(
                                                              '[a-zA-Z0-9]'))
                                                    ],
                                                    decoration: InputDecoration(
                                                        labelText: 'Username',
                                                        hintText: 'example7263',
                                                        prefixIcon:
                                                            Icon(Icons.person),
                                                        floatingLabelBehavior:
                                                            FloatingLabelBehavior
                                                                .auto,
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30))),
                                                    keyboardType: TextInputType
                                                        .emailAddress,
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  TextFormField(
                                                    key: Key("password"),
                                                    controller: pass,
                                                    // ignore: missing_return
                                                    validator: (val) {
                                                      if (val.length == 0)
                                                        return ("Password is required");
                                                    },
                                                    onSaved: (val) {
                                                      _pass = val;
                                                    },
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .allow(RegExp(
                                                              '[a-zA-Z0-9!.@_*%#-?;:><,]'))
                                                    ],
                                                    obscureText: _passwordHide,
                                                    decoration: InputDecoration(
                                                        labelText: 'Password',
                                                        prefixIcon:
                                                            Icon(Icons.lock),
                                                        floatingLabelBehavior:
                                                            FloatingLabelBehavior
                                                                .auto,
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30)),
                                                        suffixIcon: IconButton(
                                                          icon: _passwordHide
                                                              ? Icon(Icons
                                                                  .visibility_rounded)
                                                              : Icon(Icons
                                                                  .visibility_off_rounded),
                                                          onPressed: () {
                                                            setState(() {
                                                              _passwordHide =
                                                                  !_passwordHide;
                                                            });
                                                          },
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 25.0),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.lightGreen,
                                              elevation: 5,
                                              minimumSize:
                                                  Size(double.infinity, 50),
                                              textStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 20),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              )),
                                          onPressed: () {
                                            _user = user.value.text.toString();
                                            _pass = pass.value.text.toString();

                                            if (formKey.currentState
                                                .validate()) {
                                              formKey.currentState.save();

                                              FocusScope.of(context).unfocus();
                                              login();
                                            } else {
                                              showToast('Invalid', Colors.red);
                                            }
                                          },
                                          child: Text('Login'),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              GestureDetector(
                                                onTap: () async {
                                                  Navigator.of(context)
                                                      .pushNamed("/register");
                                                },
                                                child: RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                          text: ' Register',
                                                          style: TextStyle(
                                                            color: Colors
                                                                .lightGreen
                                                                .shade800,
                                                            fontSize: 17.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                child: RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                          text: '|',
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 24.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                          "/guest/dashboard");
                                                },
                                                child: RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                          text:
                                                              'Explore as Guest',
                                                          style: TextStyle(
                                                            color: Colors
                                                                .lightGreen
                                                                .shade800,
                                                            fontSize: 17.0,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: launchBOURL,
                                  child: Card(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    clipBehavior: Clip.antiAlias,
                                    child: Container(
                                      height: size.height * .18,
                                      width: size.width * .422,
                                      decoration: BoxDecoration(),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Center(
                                            child: RichText(
                                                textAlign: TextAlign.center,
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                      style: defaultText,
                                                      text:
                                                          "Online BO Account Opening System \n"),
                                                  TextSpan(
                                                    style: linkText,
                                                    text: "Tap here",
                                                  ),
                                                ]))),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: launchCustomerURL,
                                  child: Card(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    clipBehavior: Clip.antiAlias,
                                    child: Container(
                                      height: size.height * .18,
                                      width: size.width * .422,
                                      decoration: BoxDecoration(),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Center(
                                            child: RichText(
                                                textAlign: TextAlign.center,
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                      style: defaultText,
                                                      text:
                                                          "Customer Complaint Module \n"),
                                                  TextSpan(
                                                    style: linkText,
                                                    text: "Tap here",
                                                  ),
                                                ]))),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // SizedBox(height: size.height * .09,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Center(
                      child: RichText(
                          text: TextSpan(children: [
                    TextSpan(
                        style: TextStyle(color: Colors.black, fontSize: 12),
                        text: "Copyright © CDBL | Developed by CDBL VAS"),
                  ]))),
                ),
              ),
            ],
          ),
        ),
        tablet: Container(
          child: Column(
            children: [
              Expanded(
                flex: 16,
                child: Container(
                  alignment: Alignment.center,
                  child: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Card(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              clipBehavior: Clip.antiAlias,
                              child: Container(
                                decoration: BoxDecoration(
                                  //borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16.0, left: 30, right: 30),
                                  child: Column(
                                    children: [
                                      Image.asset("assets/images/cdbl.png",
                                          height: 150),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            child: Form(
                                              key: formKey,
                                              child: Column(
                                                children: [
                                                  TextFormField(
                                                    key: Key('username'),
                                                    controller: user,
                                                    // ignore: missing_return
                                                    validator: (val) {
                                                      if (val.length == 0)
                                                        return ("Username is required");
                                                    },
                                                    onSaved: (val) {
                                                      _user = val;
                                                    },
                                                    decoration: InputDecoration(
                                                        labelText: 'Username',
                                                        hintText: 'example7263',
                                                        prefixIcon:
                                                            Icon(Icons.person),
                                                        floatingLabelBehavior:
                                                            FloatingLabelBehavior
                                                                .auto,
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30))),
                                                    keyboardType: TextInputType
                                                        .emailAddress,
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  TextFormField(
                                                    key: Key("password"),
                                                    controller: pass,
                                                    // ignore: missing_return
                                                    validator: (val) {
                                                      if (val.length == 0)
                                                        return ("Password is required");
                                                    },
                                                    onSaved: (val) {
                                                      _pass = val;
                                                    },
                                                    obscureText: _passwordHide,
                                                    decoration: InputDecoration(
                                                        labelText: 'Password',
                                                        prefixIcon:
                                                            Icon(Icons.lock),
                                                        floatingLabelBehavior:
                                                            FloatingLabelBehavior
                                                                .auto,
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30)),
                                                        suffixIcon: IconButton(
                                                          icon: _passwordHide
                                                              ? Icon(Icons
                                                                  .visibility_rounded)
                                                              : Icon(Icons
                                                                  .visibility_off_rounded),
                                                          onPressed: () {
                                                            setState(() {
                                                              _passwordHide =
                                                                  !_passwordHide;
                                                            });
                                                          },
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 25.0),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.lightGreen,
                                              elevation: 5,
                                              minimumSize:
                                                  Size(double.infinity, 50),
                                              textStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 20),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              )),
                                          onPressed: () {
                                            _user = user.value.text.toString();
                                            _pass = pass.value.text.toString();

                                            if (formKey.currentState
                                                .validate()) {
                                              formKey.currentState.save();

                                              FocusScope.of(context).unfocus();
                                              login();
                                            } else {
                                              showToast('Invalid', Colors.red);
                                            }
                                          },
                                          child: Text('Login'),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              GestureDetector(
                                                onTap: () async {
                                                  Navigator.of(context)
                                                      .pushNamed("/register");
                                                },
                                                child: RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                          text: ' Register',
                                                          style: TextStyle(
                                                            color: Colors
                                                                .lightGreen
                                                                .shade800,
                                                            fontSize: 20.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                child: RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                          text: '|',
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 24.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                          "/guest/dashboard");
                                                },
                                                child: RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                          text:
                                                              'Explore as Guest',
                                                          style: TextStyle(
                                                            color: Colors
                                                                .lightGreen
                                                                .shade800,
                                                            fontSize: 20.0,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: launchBOURL,
                                  child: Card(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    clipBehavior: Clip.antiAlias,
                                    child: Container(
                                      height: size.height * .2,
                                      width: size.width * .454,
                                      decoration: BoxDecoration(),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Center(
                                            child: RichText(
                                                textAlign: TextAlign.center,
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                      style: defaultTextt,
                                                      text:
                                                          "Online BO Account Opening System \n"),
                                                  TextSpan(
                                                    style: linkTextt,
                                                    text: "Tap here",
                                                  ),
                                                ]))),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: launchCustomerURL,
                                  child: Card(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    clipBehavior: Clip.antiAlias,
                                    child: Container(
                                      height: size.height * .2,
                                      width: size.width * .454,
                                      decoration: BoxDecoration(),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Center(
                                            child: RichText(
                                                textAlign: TextAlign.center,
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                      style: defaultTextt,
                                                      text:
                                                          "Customer Complaint Module \n"),
                                                  TextSpan(
                                                    style: linkTextt,
                                                    text: "Tap here",
                                                  ),
                                                ]))),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // SizedBox(height: size.height * .09,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Center(
                      child: RichText(
                          text: TextSpan(children: [
                    TextSpan(
                        style: TextStyle(color: Colors.black, fontSize: 17),
                        text: "Copyright © CDBL | Developed by CDBL VAS"),
                  ]))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  launchBOURL() async {
    const url = 'https://cdbl.com.bd/bo/#undefined';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  launchCustomerURL() async {
    const url = 'https://www.cdbl.com.bd/complaints.sec.gov.bd/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future login() async {
    var url = "$API_URI/login.php";
    var response = await http.post(Uri.parse(url), body: {
      "username": _user,
      "password": _pass,
    });
    var data = json.decode(response.body);
    var boData = _user;

    if (data == "Successful") {
      showToast('Login Successful', Colors.green);
      Navigator.of(context)
          .pushNamed("/dashboard", arguments: {"userdata": boData});
    } else if (data == "User/password incorrect") {
      showToast('Username and/or Password invalid', Colors.red);
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
