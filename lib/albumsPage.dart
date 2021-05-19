import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'photosArchive.dart';

class GetAlbums {
  int userId;
  int id;
  String title;
  GetAlbums ({
    this.id,
    this.userId,
    this.title,
  });
  factory GetAlbums.fromJson(Map<String, dynamic> json) {
    return GetAlbums(
        id: json['id'],
        userId: json['userId'],
        title: json['title'],
    );
  }
}

class albumsPage extends StatefulWidget {
  int useridOLD;
  String userNameOLD;
  albumsPage({Key key, @required this.useridOLD, @required this.userNameOLD}) : super(key: key);
  albumsPageState createState() => albumsPageState();
}

class albumsPageState extends State<albumsPage> {
  @override
  Widget build(BuildContext context) {
    final String apiURL = 'http://jsonplaceholder.typicode.com/albums/?userId='+widget.useridOLD.toString();
    Future<List<GetAlbums>> fetchJSONData() async {
      var jsonResponse = await http.get(Uri.parse(apiURL));
      if(jsonResponse.statusCode == 200) {
        final jsonItems = json.decode(jsonResponse.body).cast<Map<String, dynamic>>();
        List<GetAlbums> albumsList = jsonItems.map<GetAlbums>((json){
          return GetAlbums.fromJson(json);
        }).toList();
        return albumsList;
      } else {
        throw Exception('Failed to load Albums');
      }
    }
    return new Scaffold(
      appBar: AppBar(
        title: Text(widget.userNameOLD),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder<List<GetAlbums>>(
        future: fetchJSONData(),
        builder: (context, snapshot) {

          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          return ListView(
            children: snapshot.data
                .map((album) => ListTile(
              title: Text(album.title),

              onTap: () {
                Navigator.push(
                    context,
                  MaterialPageRoute(
                    builder: (_) =>
                        photosArchive(albumID: album.id)
                  ),
                );
              },
              subtitle: Text('Album id: '+album.id.toString()),
              leading: CircleAvatar(
                backgroundColor: Colors.green,
                child: Text(album.title[0].toUpperCase(),
                  style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                )),
              ),
            )
            ).toList(),
          );
        },
      )
    );
  }
}