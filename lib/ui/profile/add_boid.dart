import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cdbl/models/userdata_model.dart';
import '../../config/contants.dart';

class AddBoid extends StatefulWidget {
  const AddBoid({Key key}) : super(key: key);

  @override
  State<AddBoid> createState() => _AddBoidState();
}

class _AddBoidState extends State<AddBoid> {
  String _email;
  String _boid;
  String _phonenum;
  String _data;

  TextEditingController boid = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phonenum = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Map<String, dynamic> boData =
        ModalRoute.of(context).settings.arguments;
    String dataa = boData['userdata'];

    print(dataa);

    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        leading: BackButton(),
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'ADD BOID',
          style: TextStyle(color: Colors.black),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.lightGreen.shade300,
          ),
        ),
      ),
      body: Container(
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
                                height: size.height * .20),
                            SizedBox(
                              height: size.height * .02,
                            ),
                            Column(
                              children: [
                                Container(
                                  child: Form(
                                    key: formKey,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          controller: boid,
                                          // ignore: missing_return
                                          validator: (val) {
                                            if (val.length == 0) {
                                              return ("User BO ID is required");
                                            } else if (val.length <= 15)
                                              return "BO ID must be 16 digits long";
                                          },
                                          onSaved: (val) {
                                            setState(() {
                                              _boid = val;
                                            });
                                          },
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(
                                                16),
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            labelText: "16 Digit BO ID",
                                            suffixIcon: Icon(
                                              Icons
                                                  .format_list_numbered_outlined,
                                              color: Colors.lightGreen.shade500,
                                            ),
                                            border: const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
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
                                            LengthLimitingTextInputFormatter(
                                                11),
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                          keyboardType: TextInputType.phone,
                                          decoration: InputDecoration(
                                            labelText: "11 Digit Mobile",
                                            suffixIcon: Icon(
                                              Icons.phone,
                                              color: Colors.lightGreen.shade500,
                                            ),
                                            border: const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
                                          ),
                                        ),
                                        SizedBox(
                                          height: size.height * .01,
                                        ),
                                        TextFormField(
                                          controller: email,
                                          // ignore: missing_return
                                          validator: (email) => EmailValidator
                                                  .validate(email)
                                              ? null
                                              : "Invalid email format, Please check again.",
                                          onSaved: (val) {
                                            _email = val;
                                          },
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp('[a-zA-Z0-9@.]'))
                                          ],
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                            labelText: "Valid Email",
                                            suffixIcon: Icon(
                                              Icons.email,
                                              color: Colors.lightGreen.shade500,
                                            ),
                                            border: const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
                                          ),
                                        ),
                                        SizedBox(
                                          height: size.height * .01,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 25.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.lightGreen,
                                        elevation: 5,
                                        minimumSize: Size(double.infinity, 50),
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 20),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        )),
                                    onPressed: () {
                                      _email = email.value.text.toString();
                                      _boid = boid.value.text.toString();
                                      _phonenum =
                                          phonenum.value.text.toString();
                                      _data = dataa.toString();

                                      if (formKey.currentState.validate()) {
                                        FocusScope.of(context).unfocus();
                                        var userData = UserData(
                                          boid: _boid,
                                          email: _email,
                                          phonenum: _phonenum,
                                          username: _data,
                                        );
                                        Timer(Duration(seconds: 9), () {
                                          otpSend(userData);
                                        });
                                      } else {
                                        //  Navigator.of(context).pushNamed("/boid/list", arguments: {"userdata": dataa});
                                        showToast('Invalid', Colors.red);
                                      }
                                      // });
                                    },
                                    child: Text('Submit'),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * .005,
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
                  // SizedBox(height: size.height * .09,),
                ],
              ),
            ),
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
      "username": _data,
    });
    var data1 = json.decode(response.body);
    if (data1 == "Data not found in CDS") {
      showToast('Your Profile Data is Not matched With CDS Data', Colors.red);
    }
    if (data1 == "Data already exist") {
      showToast('User already exist', Colors.red);
    }
    if (data1 == "OTP SENT") {
      showToast('OTP Sent', Colors.green);
      Navigator.of(context)
          .pushNamed("/boid/verification", arguments: {"userdata": userData});
    }
  }

  void showToast(String message, Color colors) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: colors,
        textColor: Colors.black,
        fontSize: 16.0);
  }
}
