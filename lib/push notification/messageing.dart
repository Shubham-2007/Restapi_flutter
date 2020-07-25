import 'dart:convert';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

class Messaging {
  static final Client client = Client();
  // from 'https://console.firebase.google.com'
  // --> project settings --> cloud messaging --> "Server key"
  // static const String serverKey =
  //     'AAAAlkDkoQ8:APA91bHowoniYGIVdVUNv-jlZ3Dtruq7wpTeu4aZKeKJz-jU95iE01jKRmsfz2lg74GDCLUGR8iqvbMPXjoFGDko__kS3ROfpZfZKNyKdS8j2SAav6xF6fk8SH9s2Kk7F0mNl7T_tlOx';
      static const String serverKey ='AAAA7mRLJEI:APA91bGS7Wz2m_qyyRlDNNU-xxL7qCisvvwJg74DjIp_zsvxFHh219m7DB0lzZ-27_lt6qsv0nk52NfuRFpyQ00tdtSUrshr8vHFUbq0__OL_-pfEi3S5xeXGw66czmpDIaXjhZ0bxGe';
  //   static const String xl2 = 'ey5hSehog5E:APA91bGddWz_tjFEa0SQLCXtrzpdk7iGZX6D4VlNHYohBVrZ1IPjsNPc3cj9E1p5gIeZPP9LegMu5i22XZe0xBXvfpfU1cYzMYYphx2jy1CsIGIiieu59yffPT8csifr9VMrcKPJFh7b';
  //   static const String poco = 'cyjCDV6PNaU:APA91bFhh10Xw7OLoegCphDZ_rI50e6i03FTfd0m4ZI11LZgT5mBSpuxZy_8T6SdWD-ZrtgiGcc8j2njw9yz6tfmKuj_ohlQnlNQ0KzELqMIfPsjEjFAVTI1qoYhe7WUyeqYSBglbgLM';
  //   static Future<Response> sendToAll({
  //   @required String title,
  //   @required String body,
  // }) =>
  //     sendToTopic(title: title, body: body, topic: usertoken);

  static Future<Response> sendToTopic(
          {@required String title,
          @required String body,
          @required String usertoken}) =>
      sendTo(title: title, body: body, fcmToken: '/$usertoken');

  static Future<Response> sendTo({
    @required String title,
    @required String body,
    @required String fcmToken,
  }) =>
      client.post(
        'https://fcm.googleapis.com/fcm/send',
        body: json.encode({
          'notification': {'body': '$body', 'title': '$title'},
          'priority': 'high',
          'data': {
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done',
          },
          'to': '$fcmToken',
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
      );
}
