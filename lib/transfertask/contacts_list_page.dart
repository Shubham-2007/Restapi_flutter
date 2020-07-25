import 'package:flutter/material.dart';
import 'addtransfertask.dart';
import 'contacts_picker_page.dart';

class Todo {
  final String transferid;
  final String transfernumber;

  Todo(this.transferid, this.transfernumber);
}

class ContactListPage extends StatefulWidget {
  @override
  _ContactListPageState createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  ContactDetail phone = new ContactDetail();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Contacts Plugin Example',
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.create),
              onPressed: () {},
            )
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.add),
        //   onPressed: () {},
        // ),
        body: FutureBuilder<List>(
          future: phone.refresh(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var list = snapshot.data;
              return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    var user = list.elementAt(index);
                    return Column(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new MaterialButton(
                          //minWidth: (MediaQuery.of(context).size.width),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: (MediaQuery.of(context).size.width),
                                child: Text(
                                  user.name,
                                  style: TextStyle(fontSize: 25),
                                ),
                              ),
                              Container(
                                  width: (MediaQuery.of(context).size.width),
                                  child: Text(
                                    user.number,
                                    style: TextStyle(fontSize: 15),
                                  )),
                              SizedBox(
                                height: 25,
                              ),
                            ],
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Assitask(
                                          value: Todo(user.id, user.number),
                                        )));
                          },
                        ),
                      ],
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
