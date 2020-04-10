import 'dart:io';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import '../components/upload_post.dart';
import '../models/post.dart';
import '../screens/list.dart';

class AddPost extends StatefulWidget {

  final String title;
  final String imagePath;
  final String url;
  final BuildContext context;

  AddPost({this.title, this.imagePath, this.url, this.context});

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {

  static final _formKey = GlobalKey<FormState>();
  final post = Post();

  @override
  void initState() {
    post.imageURL = widget.url;
    getDate();
    getLocation();
    super.initState();
    setState(() {});
  }

  void getDate() {
    post.date = DateTime.now();
  }

  void getLocation() async {
    Location _location = Location();
    LocationData _locationData = await _location.getLocation();

    post.latitude = _locationData.latitude;
    post.longitude = _locationData.longitude;
  }

  @override
  Widget build (BuildContext context) {
    return WillPopScope(
      onWillPop: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
            ListPage(title: widget.title)
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(widget.title),
          )
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 180,
                  width: 200,
                  child: Semantics(
                    image: true,
                    hint: 'Image of wasted food',
                    child: Image(
                      image: FileImage(File(widget.imagePath))
                    ),
                  )
                ),
                TextFormField(
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Quantity',
                    hintText: 'Quantity',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (quantity) {
                    post.quantity = int.parse(quantity);
                  },
                  validator: (value) {
                    if(value.isEmpty) {
                      return 'Please enter a quantity';
                    } else {
                      return null;
                    }
                  },
                ),
                Semantics(
                  button: true,
                  onTapHint: 'Save a new post',
                  child: RaisedButton(
                    onPressed: () {
                      if(_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        sendData(context, post, widget.title);
                      }
                    },
                    child: Text('Save post')
                  )
                )
              ]
            )
          )
        )
      )
    );
  }
}