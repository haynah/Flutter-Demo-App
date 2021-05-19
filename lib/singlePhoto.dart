import 'package:flutter/material.dart';

class singlePhoto extends StatefulWidget {
  String photoURL;
  singlePhoto({Key key, @required this.photoURL}) : super(key: key);
  singlePhotoState createState() => singlePhotoState();
}

class singlePhotoState extends State<singlePhoto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Single Photo'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(widget.photoURL.toString()),
                fit: BoxFit.cover
            )
        ),
      ),
    );
  }

}