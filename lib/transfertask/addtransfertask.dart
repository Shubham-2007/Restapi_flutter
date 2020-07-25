import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:signup_loginrestapi/push%20notification/messageing.dart';
import 'contacts_list_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

int number;

@immutable
class Message {
  final String title;
  final String body;
  final String usertoken;

  const Message({
    @required this.title,
    @required this.body,
    @required this.usertoken,
  });
}

class Taskpost {
  final String head;
  final String desc;
  final String date;
  final String assinumber;
  final String assiid;

  Taskpost({
    @required this.head,
    @required this.desc,
    @required this.date,
    @required this.assinumber,
    @required this.assiid,
  });

  factory Taskpost.fromJson(Map<String, dynamic> json) {
    return Taskpost(
      head: json['transferhead'] as String,
      desc: json['transferdesc'] as String,
      date: json['transferdate'] as String,
      assinumber: json['transfernumber'] as String,
      assiid: json['transferid'] as String,
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map['transferhead'] = head;
    map['transferdesc'] = desc;
    map['transferdate'] = date;
    map['transfernumber'] = assinumber;
    map['transferid'] = assiid;

    return map;
  }
}

Future<Taskpost> creatassipost(String assiurl,
    {Map<String, String> headers, body}) async {
  return http
      .post(assiurl, headers: headers, body: body)
      .then((http.Response response) {
    final int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    return Taskpost.fromJson(json.decode(response.body));
  });
}

class Assitask extends StatefulWidget {
  final Future<Taskpost> post;
  final Todo value;

  Assitask({Key key, this.post, this.value}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Assitask> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final TextEditingController titleController =
      TextEditingController(text: 'Subtile');
  final TextEditingController bodyController =
      TextEditingController(text: 'Body123');
  final List<Message> messages = [];
  int i = 0;

  @override
  void initState() {
    super.initState();
    getmessage();
  }

  void getmessage() {
    print('///////////////////////////////////////////////////////');
    _firebaseMessaging.onTokenRefresh.listen(sendTokenToServer);
    //   _firebaseMessaging.getToken();
    //_firebaseMessaging.subscribeToTopic('all');
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    print('***///////////////////////////////////////');

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        i++;
        print("$i onMessage: $message");
        final notification = message['notification'];
        setState(() {
          messages.add(Message(
              title: notification['title'], body: notification['body'], usertoken: null));
        });
      },
      onLaunch: (Map<String, dynamic> message) async {
        i++;
        print("onLaunch: $message");

        final notification = message['data'];
        setState(() {
          messages.add(Message(
            title: '${notification['title']}',
            body: '${notification['body']}', usertoken: null,
          ));
        });
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
  }

  Future sendNotification() async {
    //String uerstoken = await _firebaseMessaging.getToken();
    //print('Token------------------- sendnoti:   ' );
    final response = await Messaging.sendToTopic(
      title: controller1.text,
      body: controller2.text,
      usertoken:
          "e7AhF6XHKpA:APA91bH7-utjnd9eLl9MH6QDXJQbtM5SPlw6p5su0Jz74uwH4dYbw8dWq2_oKZMFb36524roArlKMC7vKmBR5F3JMhIwW0rn_HDM1MEhK3mXwfpAyICOX5u_gJNnlXbwTDtYJafCLsvh",
      // fcmToken: fcmToken,
    );
    print('Token**************************** sendnoti:   ');
    if (response.statusCode != 200) {
      print("11111111111111111111111111");
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(
            '[${response.statusCode}] Error message------------------------------------------: ${response.body}'),
      ));
    }
  }

  String sendTokenToServer(String fcmToken) {
    print('Token------------------- addtransfer token: $fcmToken');
    // send key to your server to allow server to use
    // this token to send push notifications
    return fcmToken;
  }

  static const id = 1;
  bool visibilityTag = false;
  bool visibilityObs = false;

  void _changed(bool visibility, String field) {
    setState(() {
      if (field == "tag") {
        visibilityTag = visibility;
      }
      if (field == "obs") {
        visibilityObs = visibility;
        //Assitask();
      }
    });
  }

  String createurl = 'http://10.0.2.2:3000/assi/$id';

  TextEditingController controller1 = new TextEditingController();
  TextEditingController controller2 = new TextEditingController();
  TextEditingController controller3 = new TextEditingController();

//--------------------------------------------
  // @override
  // void initState() {
  //   super.initState();
  //   _askPermissions();
  // }

  // Future<void> _askPermissions() async {
  //   PermissionStatus permissionStatus = await _getContactPermission();
  //   if (permissionStatus != PermissionStatus.granted) {
  //     _handleInvalidPermissions(permissionStatus);
  //   }
  // }

  // Future<PermissionStatus> _getContactPermission() async {
  //   PermissionStatus permission = await PermissionHandler()
  //       .checkPermissionStatus(PermissionGroup.contacts);
  //   if (permission != PermissionStatus.granted &&
  //       permission != PermissionStatus.disabled) {
  //     Map<PermissionGroup, PermissionStatus> permissionStatus =
  //         await PermissionHandler()
  //             .requestPermissions([PermissionGroup.contacts]);
  //     return permissionStatus[PermissionGroup.contacts] ??
  //         PermissionStatus.unknown;
  //   } else {
  //     return permission;
  //   }
  // }

  // void _handleInvalidPermissions(PermissionStatus permissionStatus) {
  //   if (permissionStatus == PermissionStatus.denied) {
  //     throw PlatformException(
  //         code: "PERMISSION_DENIED",
  //         message: "Access to location data denied",
  //         details: null);
  //   } else if (permissionStatus == PermissionStatus.disabled) {
  //     throw PlatformException(
  //         code: "PERMISSION_DISABLED",
  //         message: "Location data is not available on device",
  //         details: null);
  //   }
  // }

  //-------------------------------------------
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
                  controller: controller1,
                  decoration:
                      InputDecoration(hintText: "head", labelText: 'head'),
                ),
                TextField(
                  controller: controller2,
                  decoration:
                      InputDecoration(hintText: "email", labelText: 'desc'),
                ),
                TextField(
                  controller: controller3,
                  decoration:
                      InputDecoration(hintText: "date", labelText: 'date'),
                ),
                TextField(
                  //controller: controller4,
                  decoration:
                      InputDecoration(hintText: "date", labelText: 'date'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ContactListPage()));
                  },
                ),
                // RaisedButton(
                //   onPressed: () {
                //     _changed(true, "obs");
                //   },
                // ),
                RaisedButton(
                  onPressed: () async {
                    Taskpost newPost = new Taskpost(
                      head: controller1.text,
                      desc: controller2.text,
                      date: controller3.text,
                      assinumber: '${widget.value.transfernumber}',
                      assiid: '${widget.value.transferid}',
                    );
                    //print(newPost.fullname);
                    creatassipost(createurl,
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8'
                        },
                        body: jsonEncode(newPost.toMap()));
                    Navigator.pop(context);
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => Mainpage()));
                    // print(p);
                  },
                  child: const Text("Assitask"),
                ),
                RaisedButton(
                  child: const Text('Contacts list'),
                  onPressed: sendNotification,
                  // Navigator.pushNamed(context, ContactListPage()),}
                ),
              ]..addAll(messages.map(buildMessage).toList()),
            ),
          ),
        ),
      );
  Widget buildMessage(Message message) => ListTile(
        title: Text(message.title),
        subtitle: Text(message.body),
      );
}
