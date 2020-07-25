import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
//import 'package:my_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signup_loginrestapi/main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue, Colors.teal],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: ListView(
          children: <Widget>[
            headerSection(),
            textSection(),
            buttonSection(),
          ],
        ),
      ),
    );
  }

  signIn(String email, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {'email': '$email', 'password': '$pass' };

    var jsonResponse;

    var response = await http.post("http://10.0.2.2:3000/user/login",
        headers: <String, String>{'Accept': 'application/json'}, body: data);
    if (response.statusCode < 200 ||
        response.statusCode > 400 ) {}
    jsonResponse = json.decode(response.body);
    print(jsonResponse);
    if (jsonResponse != null) {
      sharedPreferences.setString("token", jsonResponse['token']);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => MyApp()),
          (Route<dynamic> route) => false);
    } else {
      print(response.body);
    }
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      child: RaisedButton(
        onPressed: emailController.text == "" || passwordController.text == ""
            ? null
            : () {
                signIn(emailController.text, passwordController.text);
              },
        elevation: 0.0,
        color: Colors.purple,
        child: Text("Sign In", style: TextStyle(color: Colors.white70)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: emailController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              icon: Icon(Icons.email, color: Colors.white70),
              hintText: "Email",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          SizedBox(height: 30.0),
          TextFormField(
            controller: passwordController,
            cursorColor: Colors.white,
            obscureText: true,
            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              icon: Icon(Icons.lock, color: Colors.white70),
              hintText: "Password",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }

  Container headerSection() {
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Text("Code Land",
          style: TextStyle(
              color: Colors.white70,
              fontSize: 40.0,
              fontWeight: FontWeight.bold)),
    );
  }
}

// import 'package:flutter/material.dart';

// class Loginuser extends StatelessWidget {
//   final List users;
//   Loginuser({Key key, @required this.users}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: new AppBar(
//         title: new Text("Login"),
//         centerTitle: true,
//       ),
//       body: new Center(
//         child: new ListView.builder(
//             //key: ,
//             padding: const EdgeInsets.all(15.0),
//             itemCount: users.length,
//             itemBuilder: (BuildContext context, int position) {
//               final index = position;
//               //print("index" + index.toString());
//               return new Login(
// name: "${users.elementAt(index)['email']}",password: "${users.elementAt(index)['password']}",
//               );
//             }),
//       ),
//     );
//   }
// }

// class Login extends StatefulWidget {

// final name,password;
// Login ({Key key, @required this.name , @required this.password}) : super(key: key);
//   @override
//   _LoginState createState() => _LoginState();
// }

// class _LoginState extends State<Login> {

//   TextEditingController emailcontroller = new TextEditingController();
//   TextEditingController passwordcontroller = new TextEditingController();

//     @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return MaterialApp(
//       title: "Add user",
//       theme: ThemeData(
//         primaryColor: Colors.deepOrange,
//       ),
//       home: new Scaffold(
//           appBar: AppBar(
//             title: Text('Create Post'),
//           ),
//           body: Container(
//             margin: const EdgeInsets.only(left: 8.0, right: 8.0),
//             child: Column(
//               children: <Widget>[
//                 TextField(
//                   controller: emailcontroller,
//                   decoration: InputDecoration(
//                       hintText: "email", labelText: 'Post Title'),
//                 ),
//                 TextField(
//                   controller: passwordcontroller,
//                   decoration: InputDecoration(
//                       hintText: "password", labelText: 'Post Title'),
//                 ),
//               ],
//             ),

//           )

//           ),
//     );
//   }
// }
