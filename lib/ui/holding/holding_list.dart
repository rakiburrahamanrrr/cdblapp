import 'dart:convert';
import 'package:cdbl/config/contants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api.dart';
import '../../loading_animation.dart';
import 'package:http/http.dart' as http;

class BalanceEnquiryScreen extends StatelessWidget {
  BalanceEnquiryScreen({Key key}) : super(key: key);
  
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<List<dynamic>> BalanceEnquiry;
  Future<Map> Value;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Map<String, dynamic> boID = ModalRoute.of(context).settings.arguments;
    String dataa = boID['boID'];

    getData() async {
      List<dynamic> BalanceEnquiry = await AuthApi().getBalanceData(dataa);
      return BalanceEnquiry;
    }

    getValueData() async {
      Map<String, dynamic> Value = await AuthApi().getValue(dataa);
      return Value;
    }

    return Scaffold(
        backgroundColor: Colors.green.shade50,
        appBar: AppBar(
          leading: BackButton(),
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'Holdings',
            style: TextStyle(color: Colors.black),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: Colors.lightGreen.shade300,
            ),
          ),
        ),
        body: SafeArea(
            child: Container(
          child: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<dynamic> balanceEnquiry = snapshot.data;
                if (balanceEnquiry.length == 0) {
                  return Container(
                    child: SafeArea(
                        child: Center(
                            child: Text("You have no balance at this moment"))),
                  );
                } else {
                  return Container(
                    child: SafeArea(
                      child: Column(
                        children: [
                          Container(
                            child: Expanded(
                              flex: 2,
                              child: Center(
                                child: FutureBuilder(
                                  future: getValueData(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      Map Value = snapshot.data;
                                      return Container(
                                        child: Card(
                                          color: Colors.green.shade100,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          clipBehavior: Clip.antiAlias,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  height: size.height * .14,
                                                  width: size.width * .322,
                                                  decoration: BoxDecoration(),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          height: size.height *
                                                              .028,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  "Portfolio Value Tk.",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                  "${Value['value']}",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        17,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Column(
                                                              children: [
                                                                Text(
                                                                  "Value as on Date",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                  "${Value['cdate']}",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        17,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text("${snapshot.error}");
                                    }
                                    return CircularProgressIndicator();
                                  },
                                ),
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.all(9.0),
                              child: Container(
                                child: FloatingActionButton.extended(
                                  onPressed: () async {
                                    var data = dataa;
                                    Navigator.of(context).pushNamed(
                                        "/holding/viewer",
                                        arguments: {"userdata": data});
                                  },
                                  label: Text(
                                    'View',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  icon: FaIcon(
                                    FontAwesomeIcons.print,
                                    color: Colors.black,
                                  ),
                                  backgroundColor: Colors.green.shade50,
                                ),
                              )),
                          Container(
                            child: Expanded(
                              flex: 9,
                              child: Container(
                                child: ListView.builder(
                                    itemCount: balanceEnquiry.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        padding: EdgeInsets.all(5),
                                        height: 80,
                                        child: GestureDetector(
                                          onTap: () {
                                            var balanceData =
                                                snapshot.data[index];
                                            Navigator.of(context).pushNamed(
                                                "/balance/details",
                                                arguments: {
                                                  "balanceData": balanceData
                                                });
                                          },
                                          child: Card(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                            colors: [
                                                              Colors.white54,
                                                              Colors.white70
                                                            ],
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              balanceEnquiry[
                                                                      index]
                                                                  .isinShortName,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              "Holdings : " +
                                                                  balanceEnquiry[
                                                                          index]
                                                                      .dpAdTotalBalance,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  child: IconButton(
                                                    icon: FaIcon(
                                                      FontAwesomeIcons
                                                          .anglesRight,
                                                      color: Colors.lightGreen,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return loadingAnimation();
            },
          ),
        )));
  }
}
