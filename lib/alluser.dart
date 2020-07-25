// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'main.dart';

class UserFilterDemo extends StatefulWidget {
  UserFilterDemo() : super();
  final String title = "Filter List Demo";

  @override
  UserFilterDemoState createState() => UserFilterDemoState();
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class UserFilterDemoState extends State<UserFilterDemo> {
  // https://jsonplaceholder.typicode.com/users

  final _debouncer = Debouncer(milliseconds: 500);
  List<User> users = List();
  List<User> filteredUsers = List();
  bool isSearchEmpty = true;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Services.getUsers().then((usersFromServer) {
      setState(() {
        users = usersFromServer;
        filteredUsers = users;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(15.0),
                      hintText: 'Filter by name or email',
                    ),
                    onChanged: (string) {
                      handleiconSearch(string);
                      handleSearch(string);
                    },
                    autofocus: false,
                  ),
                ),
                IconButton(
                  icon: Icon(isSearchEmpty ? Icons.search : Icons.cancel,
                      color: Colors.grey.shade300),
                  onPressed: cancelSearch,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: filteredUsers.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          filteredUsers[index].name,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          filteredUsers[index].email.toLowerCase(),
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void handleiconSearch(String value) {
    if (value.isNotEmpty) {
      setState(() {
        isSearchEmpty = false;
      });
    } else {
      setState(() {
        isSearchEmpty = true;
      });
    }
  }

  void handleSearch(String string) {
    setState(() {
      if (string != "") {
        _debouncer.run(() {
          filteredUsers = users
              .where((u) =>
                  ((u.name.toLowerCase()).contains(string.toLowerCase())) ||
                  ((u.email.toLowerCase()).contains(string.toLowerCase())))
              .toList();
          handleiconSearch(string);
        });
      }
      else {
        print("else---------------------else");
        _debouncer.run(() {
          filteredUsers = users;
          //handleiconSearch(string);
        });
      }
    });
  }

  void cancelSearch() {
    setState(() {
      searchController.clear();
      isSearchEmpty = true;
      super.initState();
    });
  }
}

class User {
  String name;
  String email;
  User({this.name, this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json["taskhead"] as String,
      email: json["taskdesc"] as String,
    );
  }
}

// class Allgetuser extends StatelessWidget {
//   final List users;
//   final List owntask;
//   Allgetuser({Key key, @required this.users, @required this.owntask})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: new AppBar(
//         title: new Text("Headlines"),
//         centerTitle: true,
//       ),
//       body: new Container(
//           child: Column(
//         children: <Widget>[

//           Expanded(
//             child: ListView.builder(
//                 padding: const EdgeInsets.all(15.0),
//                 itemCount: owntask.length,
//                 itemBuilder: (BuildContext context, int position) {
//                   final index = position;
//                   //print("index" + index.toString());
//                   return new Column(
//                     children: <Widget>[
//                       Container(
//                         child: Text("${owntask.elementAt(index)['taskhead']}"),
//                       ),
//                       Container(
//                         child: Text("${owntask.elementAt(index)['taskdesc']}"),
//                       ),
//                       Container(
//                         child: Text("${owntask.elementAt(index)['date']}"),
//                       ),
//                       Container(
//                         child: Text("${owntask.elementAt(index)['competed']}"),
//                       ),
//                     ],
//                   );
//                 }),
//           ),
//         ],
//       )),
//     );
//   }
// }
// // Expanded(
// //             child: ListView.builder(
// //                 padding: const EdgeInsets.all(15.0),
// //                 itemCount: users.length,
// //                 itemBuilder: (BuildContext context, int position) {
// //                   final index = position;
// //                   //print("index" + index.toString());
// //                   return Column(
// //                     children: <Widget>[
// //                       Container(
// //                         child: Text("${users.elementAt(index)['fullname']}"),
// //                       ),
// //                       Container(
// //                         child: Text("${users.elementAt(index)['email']}"),
// //                       ),
// //                       Container(
// //                         child: Text("${users.elementAt(index)['phone']}"),
// //                       ),
// //                       Container(
// //                         child: Text("${users.elementAt(index)['password']}"),
// //                       ),
// //                     ],
// //                   );
// //                 }),
// //           ),

// class Allowntask extends StatelessWidget {
//   final List users;
//   final List owntask;
//   Allowntask({Key key, @required this.users, @required this.owntask}) : super(key: key);

//   //_buildListRow() {}

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       body: Container(
//         child: SingleChildScrollView(
//           physics: ScrollPhysics(),
//           child: Column(
//             children: <Widget>[
//               Text('Hey'),
//               ListView.builder(
//                   physics: NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   padding: const EdgeInsets.all(15.0),
//                   itemCount: users.length,
//                   itemBuilder: (BuildContext context, int position) {
//                     final index = position;
//                     //print("index" + index.toString());
//                     return new Column(
//                       children: <Widget>[
//                         Container(
//                         child: Text("${users.elementAt(index)['fullname']}"),
//                       ),
//                       Container(
//                         child: Text("${users.elementAt(index)['email']}"),
//                       ),
//                       Container(
//                         child: Text("${users.elementAt(index)['phone']}"),
//                       ),
//                       Container(
//                         child: Text("${users.elementAt(index)['password']}"),
//                       ),
//                       ],
//                     );
//                   }),
//               ListView.builder(
//                   physics: NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   padding: const EdgeInsets.all(15.0),
//                   itemCount: owntask.length,
//                   itemBuilder: (BuildContext context, int position) {
//                     final index = position;
//                     //print("index" + index.toString());
//                     return new Column(
//                       children: <Widget>[
//                         Container(
//                           child: Text("${owntask.elementAt(index)['taskhead']}"),
//                         ),
//                         Container(
//                           child: Text("${owntask.elementAt(index)['taskdesc']}"),
//                         ),
//                         Container(
//                           child: Text("${owntask.elementAt(index)['date']}"),
//                         ),
//                         Container(
//                           child: Text("${owntask.elementAt(index)['competed']}"),
//                         ),
//                       ],
//                     );
//                   }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
