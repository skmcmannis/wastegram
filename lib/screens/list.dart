import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/post.dart';
import '../screens/select_image.dart';
import '../screens/detail.dart';

class ListPage extends StatefulWidget {
  final String title;

  const ListPage({Key key, this.title}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<Post> posts;

  int getTotalItems(AsyncSnapshot snapshot) {
    var totalItems = 0;
    snapshot.data.documents.forEach((entry) =>
      totalItems += entry.data['quantity']
    );
    return totalItems;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('posts').orderBy('date', descending: true).snapshots(),
      builder: (content, snapshot) {
        if(snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Center(
                child: Text(widget.title + ' - ' + getTotalItems(snapshot).toString()),
              )
            ),
            body: Center(
              child: ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  final Map <String, dynamic> map = snapshot.data.documents[index].data;
                  var post = Post.fromJson(map);
                  return Semantics(
                    button: true,
                    onTapHint: 'Load the post details',
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Detail(title: widget.title, post: post),
                          )
                        );
                      },
                      child: ListTile(
                        leading: Text(post.convertDateList()),
                        trailing: Text(post.quantity.toString())
                      )
                    )
                  );
                }
              )
            ),
            floatingActionButton: Container(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Semantics(
                  button: true,
                  onTapHint: 'Create a new post',
                  child: FloatingActionButton(
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SelectImage(title: widget.title),
                        )
                      )
                    },
                    tooltip: 'New Post',
                    child: const Icon(Icons.add),
                  )
                )
              )
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Center(
                child: Text(widget.title + ' - 0'),
              )
            ),
            body: Center(
              child: CircularProgressIndicator()
            ),
            floatingActionButton: Container(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Semantics(
                  button: true,
                  onTapHint: 'Create a new post',
                  child: FloatingActionButton(
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SelectImage(title: widget.title),
                        )
                      )
                    },
                    tooltip: 'New Post',
                    child: const Icon(Icons.add),
                  )
                )
              )
            ),
          );
        }
      }
    );
  }
}