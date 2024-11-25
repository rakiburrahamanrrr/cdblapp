import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Eservices extends StatefulWidget {
  const Eservices({Key key}) : super(key: key);

  @override
  State<Eservices> createState() => _EservicesState();
}

class _EservicesState extends State<Eservices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        leading: BackButton(),
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'E-Services',
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
                  onTap: launchBOURL,
                  child: items(
                      "Online BO",
                      FaIcon(
                        FontAwesomeIcons.anglesRight,
                        color: Colors.lightGreen,
                      ))),
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed("/online/balance");
                  },
                  child: items(
                      "Online Balance Inquiry",
                      FaIcon(
                        FontAwesomeIcons.anglesRight,
                        color: Colors.lightGreen,
                      ))),
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed("/sms");
                  },
                  child: items(
                      "SMS Alert",
                      FaIcon(
                        FontAwesomeIcons.anglesRight,
                        color: Colors.lightGreen,
                      ))),
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed("/email");
                  },
                  child: items(
                      "Email Notification",
                      FaIcon(
                        FontAwesomeIcons.anglesRight,
                        color: Colors.lightGreen,
                      ))),
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                  onTap: launchCustomerURL,
                  child: items(
                      "Customer Complaint",
                      FaIcon(
                        FontAwesomeIcons.anglesRight,
                        color: Colors.lightGreen,
                      ))),
            ],
          ),
        ),
      )),
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

  //---------------More Item Card Design-------------
  Widget items(text, icon) {
    return Container(
      padding: EdgeInsets.all(5),
      height: 85,
      child: Card(
        shadowColor: Colors.green,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.white54, Colors.white70],
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                  colors: [Colors.white54, Colors.white70],
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
