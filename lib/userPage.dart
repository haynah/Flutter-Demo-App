import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'albumsPage.dart';

class GetUsers {
  int id;
  String name;
  int userID;
  String email;
  String phoneNumber;
  GetUsers ({
    this.id,
    this.name,
    this.userID,
    this.email,
    this.phoneNumber
  });
  factory GetUsers.fromJson(Map<String, dynamic> json) {
    return GetUsers(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        userID: json['id'],
        phoneNumber: json['phone']
    );
  }
}
class userPage extends StatefulWidget {
  String username;
  userPage({Key key, @required this.username}) : super(key: key);
  CustomJSONListView createState() => CustomJSONListView();
}

class CustomJSONListView extends State<userPage> {
  final String apiURL = 'https://jsonplaceholder.typicode.com/users';
  Future<List<GetUsers>> fetchJSONData() async {
    var jsonResponse = await http.get(Uri.parse(apiURL));
    if(jsonResponse.statusCode == 200) {
      final jsonItems = json.decode(jsonResponse.body).cast<Map<String, dynamic>>();
      List<GetUsers> usersList = jsonItems.map<GetUsers>((json) {
        return GetUsers.fromJson(json);
      }).toList();
      return usersList;
    } else {
      throw Exception('Failed to load JSON data');
    }
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(widget.username),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder<List<GetUsers>>(
        future: fetchJSONData(),
        builder: (context, snapshot) {

          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          return ListView(
            children: snapshot.data
                .map((user) => ListTile(
              title: Text(user.name),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          albumsPage(useridOLD: user.userID, userNameOLD: user.name)
                    ),
                );
                //MaterialPageRoute(builder: (context) => albumsPage(userID: user.userID, userName: user.name) );
              },
              subtitle: Text(user.email),
              leading: CircleAvatar(
                backgroundColor: Colors.green,
                child: Text(user.name[0],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    )),
              ),
            ),
            )
                .toList(),
          );
        },
      ),
    );
  }
}
