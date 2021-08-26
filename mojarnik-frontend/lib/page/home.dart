import 'package:flutter/material.dart';
import 'package:mojarnik/main.dart';
import 'package:mojarnik/tes.dart';
import 'package:mojarnik/widgets.dart';
import 'package:ndialog/ndialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'menuDrawer/about3.dart';
import 'menuDrawer/bookmarks4.dart';
import 'menuDrawer/home1.dart';
import 'menuDrawer/settings2.dart';

class HomePage extends StatefulWidget {
  // final int prodi;
  // final String semester;
  // final String kelas;
  const HomePage({
    Key key,
    //  this.prodi, this.semester, this.kelas
  }) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _gender = ["Perempuan", "Laki-laki"];
  SharedPreferences sharedPreferences;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  int page = 0;
  bool settingMode = false;
  bool edit = false;
  String helpContent = """ 
  Tes
  Tes
  Tes
  """;

  List mapResponse;
  // getUser() async {
  //   var jsonData = null;
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   http.Response response;
  //   try {
  //     if (response.statusCode == 200) {
  //       jsonData = response.body;
  //       String jsonDataString = jsonData.toString();
  //       final jsonDataa = jsonDecode(jsonDataString);
  //       sharedPreferences.setString("user_name",
  //           jsonDataa["first_name"] + " " + jsonDataa["last_name"]);
  //       // sharedPreferences.setString("gender", _gender[jsonDataa["gender"]]);
  //       // sharedPreferences.setString("noHp", jsonDataa["no_hp"]);
  //       setState(() {});
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  //   return null;
  // }

  initPreference() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {});
  }

  logOut() {
    return NAlertDialog(
      title: Text("Are you sure ?"),
      content: Text("Do you want to log out from your account ?"),
      actions: [
        TextButton(
          onPressed: () {
            sharedPreferences.clear();
            sharedPreferences.commit();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginPage()),
                (Route<dynamic> route) => false);
          },
          child: Text(
            "Yes",
            style: TextStyle(color: Color(0xff0ABDB6)),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "No",
            style: TextStyle(color: Color(0xff0ABDB6)),
          ),
        ),
      ],
    ).show(context);
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new NAlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  getImage() {
    // if (sharedPreferences.getString("foto") == null) {
    //   return AssetImage("asset/markZuck.png");
    // } else {
    //   try {
    //     return NetworkImage(
    //       sharedPreferences.getString("foto"),
    //     );
    //   } catch (e) {
    //     return AssetImage("asset/markZuck.png");
    //   }
    // }
    // try {
    //   return Container(
    //     height: 80,
    //     width: 80,
    //     decoration: BoxDecoration(
    //       border: Border.all(),
    //       shape: BoxShape.circle,
    //       image: DecorationImage(
    //         fit: BoxFit.cover,
    //         // image: sharedPreferences.getString("foto") == null
    //         //     ? AssetImage("asset/markZuck.png")
    //         //     // NetworkImage("https://www.publicdomainpictures.net/pictures/320000/velka/background-image.png")
    //         //     : NetworkImage(
    //         //         sharedPreferences.getString("foto"),
    //         //       ),
    //         image: NetworkImage(
    //           sharedPreferences.getString("foto"),
    //         ),
    //       ),
    //     ),
    //   );
    // } catch (e) {
      return Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          border: Border.all(),
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("asset/markZuck.png"),
          ),
        ),
      );
    // }
  }

  @override
  void initState() {
    super.initState();
    initPreference();
    // getUser();
  }

  Widget build(BuildContext context) {
    setState(() {});
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: Text(
              "MOJARNIK",
              style: TextStyle(
                  letterSpacing: 2,
                  fontSize: 30,
                  fontFamily: "StormFaze",
                  color: Color(0xff0ABDB6)),
            ),
          ),
          leading: TextButton(
            onPressed: () {
              scaffoldKey.currentState.openDrawer();
            },
            child: Icon(
              Icons.menu,
              color: Color(0xff0ABDB6),
              size: 30,
            ),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          actions: [
            settingMode
                ? TextButton(
                    onPressed: () {
                      setState(() {
                        if (edit == true) {
                          edit = false;
                        } else if (edit == false) {
                          edit = true;
                        }
                      });
                    },
                    child: Icon(Icons.edit, color: Color(0xff0ABDB6)),
                  )
                : TextButton(
                    onPressed: () {
                      return NAlertDialog(
                        title: Text(
                          "Help",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff0ABDB6)),
                        ),
                        content: Container(
                          child:
                              Text(helpContent, textAlign: TextAlign.justify),
                        ),
                        dismissable: false,
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "I understand",
                              style: TextStyle(color: Color(0xff0ABDB6)),
                            ),
                          ),
                          // TextButton(
                          //   onPressed: () {
                          //     Navigator.of(context).push(
                          //       MaterialPageRoute(
                          //         builder: (BuildContext context) => HalamanTes(),
                          //       ),
                          //     );
                          //   },
                          //   child: Text(
                          //     "Tes",
                          //     style: TextStyle(color: Color(0xff0ABDB6)),
                          //   ),
                          // ),
                        ],
                      ).show(context);
                    },
                    // child: Image(image: AssetImage("asset/help.png"),)
                    child: Image(
                      height: 30,
                      width: 30,
                      image: AssetImage(
                        "asset/help.png",
                      ),
                    ),
                  ),
          ],
        ),
        key: scaffoldKey,
        drawer: Align(
          alignment: Alignment.topLeft,
          child: Container(
            color: Colors.white,
            width: 230,
            height: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  color: Colors.white,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Image(
                          height: 30,
                          width: 30,
                          image: AssetImage("asset/polnep.png"),
                        ),
                      ),
                      Text(
                        "MOJARNIK",
                        style: TextStyle(
                            letterSpacing: 2,
                            fontSize: 25,
                            fontFamily: "StormFaze",
                            color: Color(0xff0ABDB6)),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.black.withOpacity(0.5),
                ),
                getImage(),
                SizedBox(
                  height: 10,
                ),
                // FutureBuilder<List<User>>(
                //   future: getUser(),
                //   builder: (context, snapshot) {
                //     if (snapshot.hasData) {
                //       var usser = List.from(snapshot.data);
                //       return Container(
                //         height: 500,
                //         width: MediaQuery.of(context).size.width,
                //         child: Column(
                //           children: [
                //             Text(
                //               usser[0].firstName + " " + usser[0].lastName,
                //             ),
                //             SizedBox(
                //               height: 5,
                //             ),
                //             Text(
                //               "3201816114",
                //               style: TextStyle(
                //                   fontSize: 17,
                //                   color: Color(0xff818181),
                //                   fontWeight: FontWeight.w400),
                //             ),
                //             Divider(
                //               color: Colors.black.withOpacity(0.5),
                //             ),
                //           ],
                //           // children: usser
                //           //     .map((e) => Text(
                //           //           e.firstName + " " + e.lastName,
                //           //         ))
                //           //     .toList()),
                //         ),
                //       );
                //     }

                //     return Container();
                //   },
                // ),
                Text(
                  sharedPreferences.getString("user_name") != null
                      ? sharedPreferences
                          .getString("user_name")
                          .capitalizeFirstofEach
                      : "Name",
                  style: TextStyle(
                      fontSize: 17,
                      color: Color(0xff818181),
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "3201816114",
                  style: TextStyle(
                      fontSize: 17,
                      color: Color(0xff818181),
                      fontWeight: FontWeight.w400),
                ),
                Divider(
                  color: Colors.black.withOpacity(0.5),
                ),
                DrawerMenu(
                  title: "Home",
                  onPressed: () {
                    setState(() {
                      page = 0;
                      settingMode = false;
                    });
                    Navigator.pop(context);
                  },
                ),
                DrawerMenu(
                  title: "Bookmarks",
                  onPressed: () {
                    setState(() {
                      page = 1;
                      settingMode = false;
                    });
                    Navigator.pop(context);
                  },
                ),
                DrawerMenu(
                  title: "Settings",
                  onPressed: () {
                    setState(() {
                      page = 2;
                      settingMode = true;
                    });
                    Navigator.pop(context);
                  },
                ),
                DrawerMenu(
                  title: "About",
                  onPressed: () {
                    setState(() {
                      page = 3;
                      settingMode = false;
                    });
                    Navigator.pop(context);
                  },
                ),
                Expanded(child: Container()),
                TextButton(
                  onPressed: () {
                    logOut();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.power_settings_new, color: Colors.red),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        "Log Out",
                        style: TextStyle(color: Colors.red, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: [
          FirstPage(
              // kelas: widget.kelas,
              // prodi: widget.prodi,
              // semester: widget.semester,
              ),
          FourthPage(),
          SecondPage(
            isEdit: edit,
          ),
          ThirdPage(),
        ][page],
      ),
    );
    // );
  }
}
