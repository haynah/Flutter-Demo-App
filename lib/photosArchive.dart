import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'singlePhoto.dart';

class GetPhotos {
  int id;
  String thumbnailUrl;
  String title;
  String url;
  GetPhotos ({
    this.id,
    this.thumbnailUrl,
    this.title,
    this.url,
  });
  factory GetPhotos.fromJson(Map<String, dynamic> json) {
    return GetPhotos(
      id: json['id'],
      thumbnailUrl: json['thumbnailUrl'],
      title: json['title'],
      url: json['url'],
    );
  }
}

class photosArchive extends StatefulWidget {
  int albumID;
  photosArchive({Key key, @required this.albumID}) : super(key: key);
  photosArchiveState createState() => photosArchiveState();
}

class photosArchiveState extends State<photosArchive> {
  @override
  Widget build(BuildContext context) {
    final String apiURL = 'https://jsonplaceholder.typicode.com/photos?albumId='+widget.albumID.toString();
    Future<List<GetPhotos>> fetchJSONData() async {
      var jsonResponse = await http.get(Uri.parse(apiURL));
      if(jsonResponse.statusCode == 200) {
        final jsonItems = json.decode(jsonResponse.body).cast<Map<String, dynamic>>();
        List<GetPhotos> photosList = jsonItems.map<GetPhotos>((json){
          return GetPhotos.fromJson(json);
        }).toList();
        return photosList;
      } else {
        throw Exception('Failed to load Albums');
      }
    }
    return new Scaffold(
        appBar: AppBar(
          title: Text('Photos Archive'),
          backgroundColor: Colors.green,
        ),
        body: FutureBuilder<List<GetPhotos>>(
          future: fetchJSONData(),
          builder: (context, snapshot) {

            if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

            return ListView(
              children: snapshot.data
                  .map((photo) => ListTile(
                title: Text(photo.title),
                onTap: () {
                  Navigator.push(
                      context,
                    MaterialPageRoute(builder: (_) => singlePhoto(photoURL: photo.url))
                  );
                },
                subtitle: Text('Photo id: '+photo.id.toString()),
                leading: Image.network(photo.thumbnailUrl)
              )
              ).toList(),
            );
          },
        )
    );
  }
}