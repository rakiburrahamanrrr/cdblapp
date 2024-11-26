import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api.dart';
import '../../loading_animation.dart';

class BOIDsPage extends StatelessWidget {
   BOIDsPage();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<List<dynamic>> BoidList;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Map<String, dynamic> boData = ModalRoute.of(context).settings.arguments;
    String dataa = boData['userdata'];

    getData() async {
      List<dynamic> BoidList = await AuthApi().getBoidList(dataa);
      return BoidList;
    }

    return Scaffold(
        backgroundColor: Colors.green.shade50,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'BOIDs',
                style: TextStyle(color: Colors.black),
              ),
              Padding(
                padding: EdgeInsets.all(9.0),
                child: Container(
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.of(context).pushNamed("/add/boid", arguments: {"userdata": dataa});
                    },
                    label: Text(
                      'ADD BOID',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    icon: FaIcon(
                      FontAwesomeIcons.userPlus,
                      color: Colors.black,
                    ),
                    backgroundColor: Colors.green.shade50,
                  ),
                ),
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
                    image: DecorationImage(fit: BoxFit.contain, image: new AssetImage('assets/images/cdbl.png')),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.dashboard),
                  title: const Text(
                    'Home',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed("/dashboard", arguments: {"userdata": dataa});
                  },
                ),
                ListTile(
                  leading: Icon(Icons.account_circle_rounded),
                  title: Text(
                    'My Profile',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed("/boid/list", arguments: {"userdata": dataa});
                  },
                ),
                Divider(
                  thickness: 2,
                ),
                ListTile(
                  leading: Icon(Icons.credit_card),
                  title: Text(
                    'Holdings',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed("/boid/holdings", arguments: {"userdata": dataa});
                  },
                ),
                ListTile(
                  leading: Icon(Icons.task),
                  title: Text(
                    'Statement',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed("/boid/statement", arguments: {"userdata": dataa});
                  },
                ),
                Divider(
                  thickness: 2,
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
                  leading: FaIcon(FontAwesomeIcons.unlockKeyhole),
                  title: Text(
                    'Change Password',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed("/change/password");
                  },
                ),
                ListTile(
                  title: Text(
                    'Logout',
                    style: TextStyle(fontSize: 18),
                  ),
                  leading: Icon(Icons.exit_to_app),
                  onTap: () async {
                    final SharedPreferences prefs = await _prefs;
                    prefs.setBool("isLoggedIn", false);

                    Navigator.pushNamedAndRemoveUntil(context, '/', (Route<dynamic> route) => false);
                  },
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
            child: Container(
          child: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<dynamic> boidList = snapshot.data;
                if (boidList.length == 0) {
                  return Container(
                    child: SafeArea(child: Center(child: Text("Your profile is not updated yet at CDBL"))),
                  );
                } else {
                  return Container(
                    child: SafeArea(
                      child: Column(
                        children: [
                          Container(
                            child: Expanded(
                              child: Container(
                                child: ListView.builder(
                                    itemCount: boidList.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Container(
                                        padding: EdgeInsets.all(5),
                                        height: 80,
                                        child: GestureDetector(
                                          onTap: () {
                                            var boID = boidList[index].boid;
                                            Navigator.of(context).pushNamed("/user/profile", arguments: {"boID": boID});
                                          },
                                          child: Card(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                                            Text(
                                                              boidList[index].boid,
                                                              style: TextStyle(
                                                                  color: Colors.black,
                                                                  fontSize: 18,
                                                                  fontWeight: FontWeight.bold),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              boidList[index].name,
                                                              style: TextStyle(
                                                                color: Colors.black,
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
                                                      FontAwesomeIcons.anglesRight,
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
