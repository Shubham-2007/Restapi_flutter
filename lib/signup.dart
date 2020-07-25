import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main.dart';

class Post {
  final String fullname;
  final String email;
  final String phone;
  final String password;
  final String token;

  Post({
    @required this.fullname,
    @required this.email,
    @required this.phone,
    @required this.password,
    @required this.token,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      fullname: json['fullname'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      password: json['password'] as String,
      token: json['token'] as String,
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["fullname"] = fullname;
    map["email"] = email;
    map["phone"] = phone;
    map["password"] = password;
    map["token"] = token;
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

class Signup extends StatefulWidget {
  final Future<Post> post;
  final value;
  Signup({Key key, this.post, this.value}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  //final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  String createurl = 'http://10.0.2.2:3000/user/signup';

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
            appBar: AppBar(
              title: Text('Create Post'),
            ),
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
                    decoration: InputDecoration(
                        hintText: "email", labelText: 'Post Title'),
                  ),
                  TextField(
                    controller: phonecontroller,
                    decoration: InputDecoration(
                        hintText: "phone", labelText: 'Post Title'),
                  ),
                  TextField(
                    controller: passwordcontroller,
                    decoration: InputDecoration(
                        hintText: "password", labelText: 'Post Title'),
                  ),
                  RaisedButton(
                    onPressed: () async {
                      Post newPost = new Post(
                          fullname: fullnamecontroller.text,
                          email: emailcontroller.text,
                          phone: phonecontroller.text,
                          password: passwordcontroller.text,
                          token: widget.value.pcmtoken);
                      //print(newPost.fullname);

                      createPost(createurl,
                          headers: <String, String>{
                            'Content-Type': 'application/json; charset=UTF-8'
                          },
                          body: jsonEncode(newPost.toMap()));
                      //print(p);
                       Navigator.pop(context);
                    },
                    child: const Text("Create"),
                  ),
                  Container(
                    child: Text(widget.value.pcmtoken),
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
