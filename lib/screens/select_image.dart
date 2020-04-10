import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import './add_post.dart';


class SelectImage extends StatelessWidget {
  final String title;

  SelectImage({this.title});

  //Part of the following function from: https://stackoverflow.com/questions/58456293/flutter-how-do-i-navigate-to-a-new-page-after-an-image-is-picked-with-the-image
  Future getImage(BuildContext context) async {
    final navigator = Navigator.of(context);
    final image = await ImagePicker.pickImage(source: ImageSource.camera);
    StorageReference storageReference = FirebaseStorage.instance.ref().child('${DateTime.now()}.png');
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
    final url = await storageReference.getDownloadURL();

    if(image != null) {
      await navigator.push(
        MaterialPageRoute(
          builder: (context) =>
            AddPost(title: title, imagePath: image.path, url: url)
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(title),
        )
      ),
      body: Center(
        child: Semantics(
          button: true,
          onTapHint: 'Select a new photo',
          child: RaisedButton(
            onPressed: () {getImage(context);},
            child: Text('Upload a photo')
          )
        )
      )
    );
  }
}