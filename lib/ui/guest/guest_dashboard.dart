import 'package:cdbl/responsive.dart';
import 'package:cdbl/ui/guest/dashboard_items/slideable_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../loading_animation.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dashboard_items/slideable_tablet.dart';

class GuestDashboard extends StatefulWidget {
  const GuestDashboard({Key key}) : super(key: key);

  @override
  State<GuestDashboard> createState() => _GuestDashboardState();
}

class _GuestDashboardState extends State<GuestDashboard> {
  bool _isLoading = false;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var defaultText =
      TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold);
  var linkText = TextStyle(
      color: Colors.lightGreen, fontSize: 15, fontWeight: FontWeight.bold);

  var defaultText1 =
      TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold);
  var linkText1 = TextStyle(
      color: Colors.lightGreen, fontSize: 22, fontWeight: FontWeight.bold);

  launchCDBLURL() async {
    const url = 'https://cdbl.com.bd/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Map<String, dynamic> boData =
        ModalRoute.of(context).settings.arguments;

    return Responsive(
      mobile: Scaffold(
        backgroundColor: Colors.green.shade50,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Home',
                style: TextStyle(color: Colors.black),
              ),
              Text(
                'User :  ' + 'Guest',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: Colors.lightGreen.shade300,
            ),
          ),
        ),
        drawer: Drawer(
          child: Container(
            color: Colors.white,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                new DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    image: DecorationImage(
                        fit: BoxFit.contain,
                        image: new AssetImage('assets/images/cdbl.png')),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.dashboard),
                  title: const Text('Home'),
                  onTap: () {
                    Navigator.of(context).pushNamed("/guest/dashboard");
                  },
                ),
                ListTile(
                  leading: FaIcon(
                    FontAwesomeIcons.circleInfo,
                  ),
                  title: Text('About Us'),
                  onTap: () {
                    Navigator.of(context).pushNamed("/aboutus");
                  },
                ),
                Divider(
                  thickness: 2,
                ),
                ListTile(
                  leading: FaIcon(
                    FontAwesomeIcons.fileLines,
                  ),
                  title: Text('E-Services'),
                  onTap: () {
                    Navigator.of(context).pushNamed("/eservices");
                  },
                ),
                ListTile(
                  leading: FaIcon(
                    FontAwesomeIcons.clipboardList,
                  ),
                  title: Text('Highlights'),
                  onTap: () {
                    Navigator.of(context).pushNamed("/highlights");
                  },
                ),
                Divider(
                  thickness: 2,
                ),
                ListTile(
                  leading: Icon(Icons.contact_phone),
                  title: Text('Contact Us'),
                  onTap: () {
                    Navigator.of(context).pushNamed("/contact");
                  },
                ),
                ListTile(
                  title: Text('Log In'),
                  leading: Icon(Icons.exit_to_app),
                  onTap: () async {
                    final SharedPreferences prefs = await _prefs;
                    prefs.setBool("isLoggedIn", false);

                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (Route<dynamic> route) => false);
                  },
                ),
              ],
            ),
          ),
        ),
        body: _isLoading
            ? loadingAnimation()
            : SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      flex: 16,
                      child: AnimatedContainer(
                        duration: Duration(seconds: 1),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.all(0),
                            child: StaggeredGrid.count(
                              crossAxisCount: 1,
                              children: [
                                //-------------Dashboard Items-----------------
                                Container(
                                  height: 160,
                                  width: 200,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Stack(
                                                  children: <Widget>[
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: GestureDetector(
                                                          onTap: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pushNamed(
                                                              "/aboutus",
                                                            );
                                                          },
                                                          child: items(
                                                              "About Us",
                                                              FaIcon(
                                                                  FontAwesomeIcons
                                                                      .circleInfo,
                                                                  color: Colors
                                                                      .lightGreen
                                                                      .shade300))),
                                                    ),
                                                  ],
                                                ),
                                                Stack(
                                                  children: <Widget>[
                                                    Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .pushNamed(
                                                                  "/eservices");
                                                        },
                                                        child: items(
                                                            "E-Services",
                                                            FaIcon(
                                                                FontAwesomeIcons
                                                                    .fileLines,
                                                                color: Colors
                                                                    .lightGreen
                                                                    .shade300)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Stack(
                                                  children: <Widget>[
                                                    Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .pushNamed(
                                                                  "/highlights");
                                                        },
                                                        child: items(
                                                            "Highlights",
                                                            FaIcon(
                                                                FontAwesomeIcons
                                                                    .clipboardList,
                                                                color: Colors
                                                                    .lightGreen
                                                                    .shade300)),
                                                      ),
                                                    ),
                                                  ],
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
                                  height: 160,
                                  width: 200,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Stack(
                                                  children: <Widget>[
                                                    Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .pushNamed(
                                                                  "/news");
                                                        },
                                                        child: items(
                                                            "News",
                                                            FaIcon(
                                                                FontAwesomeIcons
                                                                    .newspaper,
                                                                color: Colors
                                                                    .lightGreen
                                                                    .shade300)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Stack(
                                                  children: <Widget>[
                                                    Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .pushNamed(
                                                                  "/faq");
                                                        },
                                                        child: items(
                                                            "FAQs",
                                                            FaIcon(
                                                                FontAwesomeIcons
                                                                    .search,
                                                                color: Colors
                                                                    .lightGreen
                                                                    .shade300)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Stack(
                                                  children: <Widget>[
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: GestureDetector(
                                                          onTap: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pushNamed(
                                                                    "/more/options");
                                                          },
                                                          child: items(
                                                              "More",
                                                              FaIcon(
                                                                  FontAwesomeIcons
                                                                      .anglesRight,
                                                                  color: Colors
                                                                      .lightGreen
                                                                      .shade300))),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SlideableGuest(),
                                Container(
                                  height: 160,
                                  width: 200,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .pushNamed(
                                                                  "/instructions");
                                                        },
                                                        child: items(
                                                            "Notices",
                                                            FaIcon(
                                                                FontAwesomeIcons
                                                                    .fileLines,
                                                                color: Colors
                                                                    .lightGreen
                                                                    .shade300))),
                                                  ),
                                                ),
                                                Stack(
                                                  children: <Widget>[
                                                    Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .pushNamed(
                                                                  "/downloads");
                                                        },
                                                        child: items(
                                                            "Downloads",
                                                            FaIcon(
                                                                FontAwesomeIcons
                                                                    .cloudArrowDown,
                                                                color: Colors
                                                                    .lightGreen
                                                                    .shade300)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Stack(
                                                  children: <Widget>[
                                                    Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .pushNamed(
                                                                  "/queries");
                                                        },
                                                        child: items(
                                                            "Queries",
                                                            FaIcon(
                                                                FontAwesomeIcons
                                                                    .circleQuestion,
                                                                color: Colors
                                                                    .lightGreen
                                                                    .shade300)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                          onTap: launchCDBLURL,
                          child: Center(
                              child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(children: [
                                    TextSpan(
                                        style: defaultText,
                                        text:
                                            "For more information please visit \n"),
                                    TextSpan(
                                      style: linkText,
                                      text: "www.cdbl.com.bd",
                                    ),
                                  ]))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
      tablet: Scaffold(
        backgroundColor: Colors.green.shade50,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Home',
                style: TextStyle(color: Colors.black, fontSize: 26),
              ),
              Text(
                'User :  ' + 'Guest',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ],
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: Colors.lightGreen.shade300,
            ),
          ),
        ),
        drawer: Drawer(
          child: Container(
            color: Colors.white,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                new DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    image: DecorationImage(
                        fit: BoxFit.contain,
                        image: new AssetImage('assets/images/cdbl.png')),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.dashboard),
                  title: const Text(
                    'Home',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed("/guest/dashboard");
                  },
                ),
                ListTile(
                  leading: FaIcon(
                    FontAwesomeIcons.circleInfo,
                  ),
                  title: Text(
                    'About Us',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed("/aboutus");
                  },
                ),
                Divider(
                  thickness: 2,
                ),
                ListTile(
                  leading: FaIcon(
                    FontAwesomeIcons.fileLines,
                  ),
                  title: Text(
                    'E-Services',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed("/eservices");
                  },
                ),
                ListTile(
                  leading: FaIcon(
                    FontAwesomeIcons.clipboardList,
                  ),
                  title: Text(
                    'Highlights',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed("/highlights");
                  },
                ),
                Divider(
                  thickness: 2,
                ),
                ListTile(
                  leading: Icon(Icons.contact_phone),
                  title: Text(
                    'Contact Us',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed("/contact");
                  },
                ),
                ListTile(
                  title: Text(
                    'Log In',
                    style: TextStyle(fontSize: 18),
                  ),
                  leading: Icon(Icons.exit_to_app),
                  onTap: () async {
                    final SharedPreferences prefs = await _prefs;
                    prefs.setBool("isLoggedIn", false);

                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (Route<dynamic> route) => false);
                  },
                ),
              ],
            ),
          ),
        ),
        body: _isLoading
            ? loadingAnimation()
            : SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      flex: 16,
                      child: AnimatedContainer(
                        duration: Duration(seconds: 1),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.all(0),
                            child: StaggeredGrid.count(
                              crossAxisCount: 1,
                              children: [
                                //-------------Dashboard Items-----------------
                                Container(
                                  height: 200,
                                  width: 250,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Stack(
                                                  children: <Widget>[
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: GestureDetector(
                                                          onTap: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pushNamed(
                                                              "/aboutus",
                                                            );
                                                          },
                                                          child: itemsTablet(
                                                              "About Us",
                                                              FaIcon(
                                                                  FontAwesomeIcons
                                                                      .circleInfo,
                                                                  color: Colors
                                                                      .lightGreen
                                                                      .shade300))),
                                                    ),
                                                  ],
                                                ),
                                                Stack(
                                                  children: <Widget>[
                                                    Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .pushNamed(
                                                                  "/eservices");
                                                        },
                                                        child: itemsTablet(
                                                            "E-Services",
                                                            FaIcon(
                                                                FontAwesomeIcons
                                                                    .fileLines,
                                                                color: Colors
                                                                    .lightGreen
                                                                    .shade300)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Stack(
                                                  children: <Widget>[
                                                    Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .pushNamed(
                                                                  "/highlights");
                                                        },
                                                        child: itemsTablet(
                                                            "Highlights",
                                                            FaIcon(
                                                                FontAwesomeIcons
                                                                    .clipboardList,
                                                                color: Colors
                                                                    .lightGreen
                                                                    .shade300)),
                                                      ),
                                                    ),
                                                  ],
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
                                  height: 200,
                                  width: 250,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Stack(
                                                  children: <Widget>[
                                                    Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .pushNamed(
                                                                  "/news");
                                                        },
                                                        child: itemsTablet(
                                                            "News",
                                                            FaIcon(
                                                                FontAwesomeIcons
                                                                    .newspaper,
                                                                color: Colors
                                                                    .lightGreen
                                                                    .shade300)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Stack(
                                                  children: <Widget>[
                                                    Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .pushNamed(
                                                                  "/faq");
                                                        },
                                                        child: itemsTablet(
                                                            "FAQs",
                                                            FaIcon(
                                                                FontAwesomeIcons
                                                                    .search,
                                                                color: Colors
                                                                    .lightGreen
                                                                    .shade300)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Stack(
                                                  children: <Widget>[
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: GestureDetector(
                                                          onTap: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pushNamed(
                                                                    "/more/options");
                                                          },
                                                          child: itemsTablet(
                                                              "More",
                                                              FaIcon(
                                                                  FontAwesomeIcons
                                                                      .anglesRight,
                                                                  color: Colors
                                                                      .lightGreen
                                                                      .shade300))),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SlideableGuestTablet(),
                                Container(
                                  height: 200,
                                  width: 250,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .pushNamed(
                                                                  "/instructions");
                                                        },
                                                        child: itemsTablet(
                                                            "Notices",
                                                            FaIcon(
                                                                FontAwesomeIcons
                                                                    .fileLines,
                                                                color: Colors
                                                                    .lightGreen
                                                                    .shade300))),
                                                  ),
                                                ),
                                                Stack(
                                                  children: <Widget>[
                                                    Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .pushNamed(
                                                                  "/downloads");
                                                        },
                                                        child: itemsTablet(
                                                            "Downloads",
                                                            FaIcon(
                                                                FontAwesomeIcons
                                                                    .cloudArrowDown,
                                                                color: Colors
                                                                    .lightGreen
                                                                    .shade300)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Stack(
                                                  children: <Widget>[
                                                    Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .pushNamed(
                                                                  "/queries");
                                                        },
                                                        child: itemsTablet(
                                                            "Queries",
                                                            FaIcon(
                                                                FontAwesomeIcons
                                                                    .circleQuestion,
                                                                color: Colors
                                                                    .lightGreen
                                                                    .shade300)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                          onTap: launchCDBLURL,
                          child: Center(
                              child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(children: [
                                    TextSpan(
                                        style: defaultText1,
                                        text:
                                            "For more information please visit \n"),
                                    TextSpan(
                                      style: linkText1,
                                      text: "www.cdbl.com.bd",
                                    ),
                                  ]))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  //---------------Dashboard Item Design-------------
  Widget items(text, icon) {
    Size size = MediaQuery.of(context).size;
    return Card(
      margin: EdgeInsets.all(13),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.antiAlias,
      elevation: 5,
      child: Column(
        children: [
          Container(
            height: 130,
            width: size.width * .26,
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: ClipOval(
                    child: IconButton(icon: icon, iconSize: 40),
                  ),
                  radius: 40.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    text,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  //---------------Dashboard Item Design For Tablet-------------
  Widget itemsTablet(text, icon) {
    Size size = MediaQuery.of(context).size;
    return Card(
      margin: EdgeInsets.all(13),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.antiAlias,
      elevation: 5,
      child: Column(
        children: [
          Container(
            height: 150,
            width: 150,
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: ClipOval(
                    child: IconButton(icon: icon, iconSize: 60),
                  ),
                  radius: 40.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    text,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
