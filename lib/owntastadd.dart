import 'dart:convert';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
//import 'package:signup_loginrestapi/mainpage.dart';
//import 'package:signup_loginrestapi/mainpage.dart';
//import 'main.dart';

class Post {
  final String fullname;
  final String email;
  final String phone;
  final String password;

  Post({
    @required this.fullname,
    @required this.email,
    @required this.phone,
    @required this.password,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      fullname: json['taskhead'] as String,
      email: json['taskdesc'] as String,
      phone: json['date'] as String,
      password: json['competed'] as String,
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["taskhead"] = fullname;
    map["taskdesc"] = email;
    map["date"] = phone;
    map["competed"] = password;

    return map;
  }
}

Future<Post> createPost(String url, {Map<String, String> headers, body}) async {
  return http
      .post(url, headers: headers, body: body)
      .then((http.Response response) {
    final int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    return Post.fromJson(json.decode(response.body));
  });
}

class BasicDateTimeField extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd HH:mm");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Basic date & time field (${format.pattern})'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );
            return DateTimeField.combine(date, time);
          } else {
            return currentValue;
          }
        },
      ),
    ]);
  }
}

class Owntaskadd extends StatefulWidget {
  final Future<Post> post;

  Owntaskadd({Key key, this.post}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Owntaskadd> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;

  @override
  void initState() {
    super.initState();
    initializing();
  }

  void initializing() async {
    androidInitializationSettings = AndroidInitializationSettings('app_icon');
    // iosInitializationSettings = IOSInitializationSettings(
    //     onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = InitializationSettings(
        androidInitializationSettings, iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  void _showNotifications(String head , date) async {
    await notification( head , date);
  }

  // void _showNotificationsAfterSecond() async {
  //   await notificationAfterSec();
  // }

  Future<void> notification(String head , date) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            'Channel ID', 'Channel title', 'channel body' ,
            priority: Priority.High,
            importance: Importance.Max,
            ticker: 'test');

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails =
        NotificationDetails(androidNotificationDetails, iosNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        0, head, date, notificationDetails);
  }

  Future<void> notificationAfterSec() async {
    var timeDelayed = DateTime.now().add(Duration(seconds: 5));
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            'second channel ID', 'second Channel title', 'second channel body',
            priority: Priority.High,
            importance: Importance.Max,
            ticker: 'test');

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails =
        NotificationDetails(androidNotificationDetails, iosNotificationDetails);
    await flutterLocalNotificationsPlugin.schedule(1, 'Hello there',
        'please subscribe my channel aaaaaa', timeDelayed, notificationDetails);
  }

  Future onSelectNotification(String payLoad) {
    if (payLoad != null) {
      print(payLoad);
    }

    // we can set navigator to navigate another screen
  }

  // Future onDidReceiveLocalNotification(
  //     int id, String title, String body, String payload) async {
  //   return CupertinoAlertDialog(
  //     title: Text(title),
  //     content: Text(body),
  //     actions: <Widget>[
  //       CupertinoDialogAction(
  //           isDefaultAction: true,
  //           onPressed: () {
  //             print("object");
  //             Mainpage();
  //           },
  //           child: Text("Okay")),
  //     ],
  //   );
  // }

  static const id = 1;

  String createurl = 'http://10.0.2.2:3000/own/$id';

  TextEditingController fullnamecontroller = new TextEditingController();

  TextEditingController emailcontroller = new TextEditingController();

  TextEditingController phonecontroller = new TextEditingController();

  TextEditingController passwordcontroller = new TextEditingController();

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: "Add user",
        theme: ThemeData(
          primaryColor: Colors.deepOrange,
        ),
        home: Scaffold(
            body: Container(
          margin: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: fullnamecontroller,
                decoration: InputDecoration(
                    hintText: "Fullname", labelText: 'Post Title'),
              ),
              TextField(
                controller: emailcontroller,
                decoration:
                    InputDecoration(hintText: "email", labelText: 'Post Title'),
              ),
              TextField(
                controller: phonecontroller,
                decoration:
                    InputDecoration(hintText: "data", labelText: 'Data'),
              ),
              TextField(
                controller: passwordcontroller,
                decoration: InputDecoration(
                    hintText: "password", labelText: 'Post Title'),
              ),
              RaisedButton(
                onPressed: () {
                  _showNotifications(fullnamecontroller.text,phonecontroller.text);
                  Post newPost = new Post(
                      fullname: fullnamecontroller.text,
                      email: emailcontroller.text,
                      phone: phonecontroller.text,
                      password: passwordcontroller.text);
                  //print(newPost.fullname);
                  //_showNotifications;
                  createPost(createurl,
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8'
                      },
                      body: jsonEncode(newPost.toMap()));

                  Navigator.pop(context);
                  // print(p);
                },
                child: const Text("Owntask"),
              ),
              RaisedButton(
                onPressed: (){//_showNotifications();
                },
                child: const Text("notification"),
              )
            ],
          ),
        )),
      );
}
// Future<Post> getPosts() async {
//   final String postsURL = "https://10.0.2.2:3000/user/signup";
//   Map<String, String> headers = {"Content-type": "application/json"};
//   Response res = await get(postsURL, headers: headers , body: json);

//   if (res.statusCode == 200) {
//     List<dynamic> body = jsonDecode(res.body);
//     List<Post> posts = body
//         .map(
//           (dynamic item) => Post.fromJson(item),
//         )
//         .toList();
//     return posts;
//   } else {
//     throw "Can't get posts.";
//   }
// }
