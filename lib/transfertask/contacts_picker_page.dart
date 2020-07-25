import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:contacts_service/contacts_service.dart';

class ContactDetail {
  String id;
  String name;
  String number;

  ContactDetail({
    this.id,
    this.name,
    this.number,
    
  });

  List<ContactDetail> phone;
  Future<List> refresh() async {
    print("/////////////////////////////////////////////////");
    //PermissionStatus pstatus = await getContactPermission();
    phone = [];
    var contacts = (await ContactsService.getContacts(
      withThumbnails: false,
    ))
        .toList();
    var response = await http.get("http://10.0.2.2:3000/user/number");
    List<dynamic> datanumlist = [];
    if (response.statusCode == 200) {
      datanumlist = jsonDecode(response.body);
    }
    for (final c in datanumlist) {
      for (final num in contacts) {
        print(c["phone"]);
        print(num.phones.elementAt(0).value.toString());
        print("-------------------------------");
        if (num.phones.elementAt(0).value.toString() == c["phone"].toString()) {
          ContactDetail temp = ContactDetail();
          temp.id = c["id"].toString();
          temp.name = c["fullname"].toString();
          temp.number = c["phone"].toString();
          //print(temp.id);
          phone.add(temp);
        }
      }
    }
    print(phone.length);
    return phone;
  }
}

