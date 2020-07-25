// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'messageing.dart';

// @immutable
// class Message {
//   final String title;
//   final String body;

//   const Message({
//     @required this.title,
//     @required this.body,
//   });
// }

// class MessagingWidget extends StatefulWidget {
//   @override
//   _MessagingWidgetState createState() => _MessagingWidgetState();
// }

// class _MessagingWidgetState extends State<MessagingWidget> {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
//   final TextEditingController titleController =
//       TextEditingController(text: 'Subtile');
//   final TextEditingController bodyController =
//       TextEditingController(text: 'Body123');
//   final List<Message> messages = [];
//   int i = 0;

//   @override
//   void initState() {
//     super.initState();
//     getmessage();
//   }

//   void getmessage() {
//     _firebaseMessaging.onTokenRefresh.listen(sendTokenToServer);
//     _firebaseMessaging.getToken();

//     _firebaseMessaging.subscribeToTopic('all');

//     _firebaseMessaging.configure(
//       onMessage: (Map<String, dynamic> message) async {
//         i++;
//         print("$i onMessage: $message");
//         // final notification = message['notification'];
//         // setState(() {
//         //   messages.add(Message(
//         //       title: notification['title'], body: notification['body']));
//         // });
//       },
//       onLaunch: (Map<String, dynamic> message) async {
//         i++;
//         print("onLaunch: $message");

//         final notification = message['data'];
//         setState(() {
//           messages.add(Message(
//             title: '${notification['title']}',
//             body: '${notification['body']}',
//           ));
//         });
//       },
//       onResume: (Map<String, dynamic> message) async {
//         print("onResume: $message");
//       },
//     );
//     _firebaseMessaging.requestNotificationPermissions(
//         const IosNotificationSettings(sound: true, badge: true, alert: true));
//   }

//   @override
//   Widget build(BuildContext context) => ListView(
//         children: [
//           TextFormField(
//             controller: titleController,
//             decoration: InputDecoration(labelText: 'Title'),
//           ),
//           TextFormField(
//             controller: bodyController,
//             decoration: InputDecoration(labelText: 'Body'),
//           ),
//           RaisedButton(
//             onPressed: sendNotification,
//             child: Text('Send notification to all'),
//           ),
//         ]..addAll(messages.map(buildMessage).toList()),
//       );

//   Widget buildMessage(Message message) => ListTile(
//         title: Text(message.title),
//         subtitle: Text(message.body),
//       );

//   Future sendNotification() async {
//     final response = await Messaging.sendToAll(
//       title: titleController.text,
//       body: bodyController.text,
//       // fcmToken: fcmToken,
//     );

//     if (response.statusCode != 200) {
//       print("11111111111111111111111111");
//       Scaffold.of(context).showSnackBar(SnackBar(
//         content: Text(
//             '[${response.statusCode}] Error message------------------------------------------: ${response.body}'),
//       ));
//     }
//   }

//   void sendTokenToServer(String fcmToken) {
//     print('Token-------------------: $fcmToken');
//     // send key to your server to allow server to use
//     // this token to send push notifications
//   }
// }

// //cA7OxelJx3A:APA91bHXjt9cK-6xXObbqmhZ4MrIYvCUYRRXJsD_Tkj4uBvvpLjzvOogtdactsVKZGKu8ArEW_KuGFsK6FJeeagAPd5OmA-qGRUyjsmJPGUYMQgdFgr3mFskhBPP7C_JCBz1LptKqt0c

// //poco
// //cyjCDV6PNaU:APA91bFhh10Xw7OLoegCphDZ_rI50e6i03FTfd0m4ZI11LZgT5mBSpuxZy_8T6SdWD-ZrtgiGcc8j2njw9yz6tfmKuj_ohlQnlNQ0KzELqMIfPsjEjFAVTI1qoYhe7WUyeqYSBglbgLM
// //cyjCDV6PNaU:APA91bFhh10Xw7OLoegCphDZ_rI50e6i03FTfd0m4ZI11LZgT5mBSpuxZy_8T6SdWD-ZrtgiGcc8j2njw9yz6tfmKuj_ohlQnlNQ0KzELqMIfPsjEjFAVTI1qoYhe7WUyeqYSBglbgLM
