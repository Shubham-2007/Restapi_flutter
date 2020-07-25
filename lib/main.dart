import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signup_loginrestapi/owntastadd.dart';
//import 'package:signup_loginrestapi/mainpage.dart';
import 'package:signup_loginrestapi/signup.dart';
import 'package:signup_loginrestapi/transfertask/addtransfertask.dart';
import 'alluser.dart';
import 'login.dart';

String apiget = "http://10.0.2.2:3000/user";
String loginapi = "http://10.0.2.2:3000/own/login";
String apiowntask = "http://10.0.2.2:3000/own/1";

List alluser;
List loginuser;
List allowntask;

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

void main() async {
  alluser = await fetchData(apiget);
  allowntask = await fetchowntaskData(apiowntask);
  loginuser = await loginData(loginapi);

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    //home: Mainpage(),
    home: MyApp(),
  ));
}

class Pcmtoken {
  final String pcmtoken;
  Pcmtoken({
    @required this.pcmtoken,
  });
// String pcmtoken() {
//   String pcm =  await _firebaseMessaging.getToken();
//   return pcm;
// }
}
class Services {
  static const String url = 'http://10.0.2.2:3000/own/1';
 
  static Future<List<User>> getUsers() async {
    try {
      final response = await http.get(url, headers: {"Accept": "application/json "});
      if (response.statusCode == 200) {
        //List<User> list =
        return  parseUsers(response.body);
        //return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
 
  static List<User> parseUsers(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }
} 


Future<List> fetchData(String apiUrl) async {
  http.Response response =
      await http.get(apiUrl, headers: {"Accept": "application/json "});
  return (json.decode(response.body));
}

Future<List> fetchowntaskData(String apiowntask) async {
  http.Response response =
      await http.get(apiowntask, headers: {"Accept": "application/json "});
  return (json.decode(response.body));
}

Future<List> loginData(String apiUrl) async {
  http.Response response =
      await http.get(apiUrl, headers: {"Accept": "application/json "});
  return (json.decode(response.body));
}

class MyApp extends StatefulWidget {
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MyApp> {
  SharedPreferences sharedPreferences;

  void initState() {
    super.initState();
    pushnoti();
    //checkLoginStatus();
  }

  String usertoken;
  void pushnoti() async {
    print('++++++++++++++++++++++++++++++++++++++++++++++++');
    _firebaseMessaging.onTokenRefresh.listen(sendTokenToServer);
    _firebaseMessaging.getToken();
    usertoken = await _firebaseMessaging.getToken();
    //Pcmtoken(fcmtoken);
    print('Token-------------------: ' + usertoken);
    _firebaseMessaging.subscribeToTopic('all');
    // _firebaseMessaging.requestNotificationPermissions(
    //     const IosNotificationSettings(sound: true, badge: true, alert: true));
    // _firebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     print(" onMessage: $message");
    //   },
    //   onLaunch: (Map<String, dynamic> message) async {
    //     print("onLaunch: $message");
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     print("onResume: $message");
    //   },
    // );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    print('******************************************');
  }

  void sendTokenToServer(String fcmToken) {
    // send key to your server to allow server to use
    // this token to send push notifications
  }
  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text("All Users"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                padding: const EdgeInsets.all(12.0),
                color: Colors.red,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => new UserFilterDemo()
                          // Allgetuser(
                          //       users: alluser,
                          //       owntask: allowntask,
                          //     )
                          )
                          );
                },
                child: Text(
                  "all user",
                  style: TextStyle(
                    fontSize: 21.0,
                    color: Colors.white,
                  ),
                ),
              ),
              RaisedButton(
                padding: const EdgeInsets.all(12.0),
                color: Colors.red,
                onPressed: () {
                  //Signup();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => new Signup(
                              value: Pcmtoken(pcmtoken: usertoken))));
                },
                child: Text(
                  "add user",
                  style: TextStyle(
                    fontSize: 21.0,
                    color: Colors.white,
                  ),
                ),
              ),
              // RaisedButton(
              //   padding: const EdgeInsets.all(12.0),
              //   color: Colors.red,
              //   onPressed: () //async

              //       {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => new Allowntask(
              //                   users: alluser,
              //                   owntask: allowntask,
              //                 )));

              //     // sharedPreferences = await SharedPreferences.getInstance();
              //     // if(sharedPreferences.getString("token") == null) {
              //     //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
              //     // }
              //   },
              //   //{
              //   //Signup();
              //   //  Navigator.push(
              //   //      context,
              //   //      MaterialPageRoute(
              //   //          builder: (context) => new
              //   //init();
              //   //  )
              //   //  );
              //   //},
              //   child: Text(
              //     "Login user",
              //     style: TextStyle(
              //       fontSize: 21.0,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
              RaisedButton(
                  child: const Text('owntask'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Owntaskadd()));
                  }),
              RaisedButton(
                  child: const Text('assitask'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Assitask()));
                  })
            ],
          ),
        ));
  }
}
