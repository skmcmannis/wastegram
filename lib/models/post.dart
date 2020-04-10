import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Post {
  dynamic date;
  String imageURL;
  int quantity;
  double latitude;
  double longitude;

  Post();
  Post.populated(this.date, this.imageURL, this.quantity, this.latitude, this.longitude);

  factory Post.fromJson(
    Map<String, dynamic> json,
  ) {
    return Post.populated(
      json['date'] as Timestamp,
      json['imageURL'] as String,
      json['quantity'] as int,
      json['latitude'] as double,
      json['longitude'] as double
    );
  }

  String formatDateList(DateTime date) => new DateFormat("EEEE, MMMM d").format(date);

  String formatDateDetail(DateTime date) => new DateFormat("EEEE, MMMM d, y").format(date);

  String convertDateList() {
    return formatDateList(this.date.toDate());
  }

  String convertDateDetail() {
    return formatDateDetail(this.date.toDate());
  }
}