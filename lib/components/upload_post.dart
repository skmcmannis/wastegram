import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/post.dart';
import '../screens/list.dart';

void sendData(BuildContext context, Post post, String title) async {
  final navigator = Navigator.of(context);

  await Firestore.instance.collection('posts').add({
    'date': post.date,
    'imageURL': post.imageURL,
    'latitude': post.latitude,
    'longitude': post.longitude,
    'quantity': post.quantity
  });

  navigator.push(
    MaterialPageRoute(
      builder: (context) =>
        ListPage(title: title)
    )
);
}