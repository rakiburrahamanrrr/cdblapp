import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MoreItemsPage extends StatefulWidget {
  const MoreItemsPage({Key key}) : super(key: key);

  @override
  State<MoreItemsPage> createState() => _MoreItemsPageState();
}

class _MoreItemsPageState extends State<MoreItemsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        leading: BackButton(),
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Quick View',
          style: TextStyle(color: Colors.black),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.lightGreen.shade300,
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed("/dps/list");
                  },
                  child: items("List of DPs",FaIcon(
                    FontAwesomeIcons.anglesRight,
                    color: Colors.lightGreen,
                  ))),
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed("/isin/list");
                  },
                  child: items("List of ISINs",FaIcon(
                    FontAwesomeIcons.anglesRight,
                    color: Colors.lightGreen,
                  ))),
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed("/issuer");
                  },
                  child: items("List of Issuers",FaIcon(
                    FontAwesomeIcons.anglesRight,
                    color: Colors.lightGreen,
                  ))),
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed("/holidays");
                  },
                  child: items("List of Holidays",FaIcon(
                    FontAwesomeIcons.anglesRight,
                    color: Colors.lightGreen,
                  ))),
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed("/gallery");
                  },
                  child: items("Galleries",FaIcon(
                    FontAwesomeIcons.anglesRight,
                    color: Colors.lightGreen,
                  ))),
            ],
          ),
        ),
      )),
    );
  }

  //---------------More Item Card Design-------------
  Widget items(text,icon) {
    return Container(
      padding: EdgeInsets.all(5),
      height: 85,
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
                      gradient: LinearGradient(
                        colors: [
                          Colors.white54,
                          Colors.white70
                        ],
                      ),
                      borderRadius:
                      BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        ListTile(
                          title: Text(
                            text,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white54,
                                    Colors.white70
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
                icon: icon,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
