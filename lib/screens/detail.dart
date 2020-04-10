import 'dart:io';
import 'package:flutter/material.dart';
import '../models/post.dart';

class Detail extends StatelessWidget {

  final String title;
  final Post post;

  Detail({this.title, this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(title),
        )
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
            width: 200,
            child: Semantics(
              image: true,
              hint: 'Image of wasted food',
              child: Image(
                image: NetworkImage(post.imageURL)
              ),
            )
          ),
          Center(
            child: Text(post.convertDateDetail().toString())
          ),
          Center(
            child: Text('Items: ${post.quantity}')
          ),
          Center(
            child: Text('(${post.latitude}, ${post.longitude})')
          )
        ],
      )
    );
  }
}