import 'package:flutter/material.dart';
import '../../api.dart';


 class UserProfileScreen extends StatelessWidget {
   const UserProfileScreen();
 
    @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Map<String, dynamic> boID = ModalRoute.of(context).settings.arguments;
    String data = boID['boID'];

    getData() async {
      Map<String, dynamic> UserProfile = await AuthApi().getUserData(data);
      return UserProfile;
    }

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'BO Profile',
          style: TextStyle(color: Colors.black),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.lightGreen.shade300,
          ),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Map UserProfile = snapshot.data;
              if (UserProfile.length == 0) {
                return Container(
                  child: SafeArea(
                      child: Center(
                          child:
                              Text("You Profile is not yet updated in CDS"))),
                );
              } else {
                return Container(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(left: 16, top: 30, right: 16),
                      child: GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                contentPadding: EdgeInsets.only(bottom: 5),
                                labelText: "Name",
                                hintText: "${UserProfile['name']}",
                                labelStyle: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                enabled: false,
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            TextField(
                                decoration: InputDecoration(
                              prefixIcon:
                                  Icon(Icons.format_list_numbered_rounded),
                              contentPadding: EdgeInsets.only(bottom: 3),
                              labelText: "BO ID",
                              hintText: "${UserProfile['boid']}"
                                  "   "
                                  "-"
                                  "  "
                                  "${UserProfile['status']}",
                              labelStyle: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              enabled: false,
                            )),
                            SizedBox(
                              height: 25,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                contentPadding: EdgeInsets.only(bottom: 3),
                                labelText: "Email",
                                hintText: "${UserProfile['email']}",
                                labelStyle: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                enabled: false,
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.phone),
                                contentPadding: EdgeInsets.only(bottom: 3),
                                labelText: "Mobile Number",
                                hintText: "${UserProfile['phonenum']}",
                                labelStyle: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                enabled: false,
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            TextField(
                              maxLines: 3,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.location_on),
                                contentPadding: EdgeInsets.only(bottom: 3),
                                labelText: "Address",
                                hintText: "${UserProfile['address']}",
                                labelStyle: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                enabled: false,
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            TextField(
                              maxLines: 3,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.location_city),
                                contentPadding: EdgeInsets.only(bottom: 3),
                                labelText: "Bank",
                                hintText: "${UserProfile['bank']}",
                                labelStyle: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                enabled: false,
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            TextField(
                              maxLines: 1,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                contentPadding: EdgeInsets.only(bottom: 3),
                                labelText: "BO Type",
                                hintText: "${UserProfile['botype']}",
                                labelStyle: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                enabled: false,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(80, 20, 0, 100),
                                  child: Container(
                                    child: FloatingActionButton.extended(
                                      onPressed: () {
                                        var data = UserProfile['boid'];
                                        Navigator.of(context).pushNamed(
                                            "/modify/history",
                                            arguments: {"userdata": data});
                                      },
                                      label: Text(
                                        'Modify History',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      icon: Icon(
                                        Icons.double_arrow_rounded,
                                        color: Colors.black,
                                      ),
                                      backgroundColor:
                                          Colors.lightGreen.shade300,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

 }
