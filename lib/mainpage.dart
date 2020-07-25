import 'package:flutter/material.dart';
import 'package:signup_loginrestapi/transfertask/addtransfertask.dart';
//import 'main.dart';
import 'owntastadd.dart';

// appBar: AppBar(
//     title: Container(
//       child: Text('Basic AppBar',
//       ),

//     ),
//     actions: <Widget>[
//   // action button
//   // action button
//   IconButton(
//     icon: const Icon(Icons.more_vert),
//     tooltip: 'Show Snackbar',
//     onPressed: () {
//       //scaffoldKey.currentState.showSnackBar(snackBar);
//     },
//   ),
// ]),

class Mainpage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Main();
}

class Main extends State<Mainpage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Flutter App'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
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
      ),
    );
  }
}


