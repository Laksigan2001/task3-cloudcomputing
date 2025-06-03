import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class GalleryPage extends StatefulWidget {
  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  final List<String> _imageUrls = [];

  @override
  void initState() {
    super.initState();
    _signInAnon();
    _loadImages();
  }

  Future<void> _signInAnon() async {
    await FirebaseAuth.instance.signInAnonymously();
  }

  Future<void> _pickAndUploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    final file = File(pickedFile.path);
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();

    final ref = FirebaseStorage.instance.ref().child('images/$fileName.jpg');
    await ref.putFile(file);
    final url = await ref.getDownloadURL();

    setState(() {
      _imageUrls.add(url);
    });
  }

  Future<void> _loadImages() async {
    final ListResult result = await FirebaseStorage.instance
        .ref('images')
        .listAll();
    final urls = await Future.wait(
      result.items.map((ref) => ref.getDownloadURL()).toList(),
    );

    setState(() {
      _imageUrls.addAll(urls);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Photo Gallery")),
      body: GridView.builder(
        padding: EdgeInsets.all(8),
        itemCount: _imageUrls.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) {
          return Image.network(_imageUrls[index], fit: BoxFit.cover);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickAndUploadImage,
        child: Icon(Icons.upload),
      ),
    );
  }
}
