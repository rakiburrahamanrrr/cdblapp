import 'package:cdbl/models/isin_name.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../api.dart';
import '../../loading_animation.dart';

// ignore: must_be_immutable
class IsinStatementScreen extends StatelessWidget {
  List<dynamic> Isin;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Map<String, dynamic> boID = ModalRoute.of(context).settings.arguments;
    String dataa = boID['boID'];

    getData() async {
      List isin = await AuthApi().getIsinStatementData(dataa);
      return isin;
    }

    return Scaffold(
        backgroundColor: Colors.green.shade50,
        appBar: AppBar(
          leading: BackButton(),
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'Statement for Last 2 Months',
            style: TextStyle(
              color: Colors.black,
            ),
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
                  List isin = snapshot.data;
                  if (isin.length == 0) {
                    return Container(
                      child: SafeArea(
                          child: Center(
                              child: Text(
                                  "You have no ISIN Statement at this moment"))),
                    );
                  } else {
                    return SafeArea(
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                                padding: EdgeInsets.all(9.0),
                                child: Container(
                                  child: FloatingActionButton.extended(
                                    onPressed: () async {
                                      var data = dataa;
                                      Navigator.of(context).pushNamed(
                                          "/statement/viewer",
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
                          ),
                          Expanded(
                            flex: 12,
                            child: Container(
                              child: ListView.builder(
                                  itemCount: isin.length,
                                  itemBuilder: (BuildContext context, index) {
                                    return Container(
                                      padding: EdgeInsets.all(5),
                                      height: 85,
                                      child: GestureDetector(
                                        onTap: () {
                                          var isinname = isin[index].isinName;

                                          var isinName = IsinName(
                                            isinname: isinname,
                                            dataa: dataa,
                                          );
                                          Navigator.of(context).pushNamed(
                                            "/statement",
                                            arguments: {"isinName": isinName},
                                          );
                                        },
                                        child: Card(
                                          shadowColor: Colors.green,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                          colors: [
                                                            Colors.white54,
                                                            Colors.white70
                                                          ],
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          ListTile(
                                                            title: Text(
                                                              isin[index]
                                                                  .isinName,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  gradient:
                                                                      LinearGradient(
                                                                    colors: [
                                                                      Colors
                                                                          .white54,
                                                                      Colors
                                                                          .white70
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
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
                        ],
                      ),
                    );
                  }
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return loadingAnimation();
              },
            ),
          ),
        ));
  }
}
