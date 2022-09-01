import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;

class AddContentScreen extends StatefulWidget {
  const AddContentScreen({Key? key}) : super(key: key);

  @override
  State<AddContentScreen> createState() => _AddContentScreenState();
}

class _AddContentScreenState extends State<AddContentScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController discreptionController = TextEditingController();
  List a = [];
  List imagesNames = [];

  @override
  void dispose() {
    titleController.dispose();
    discreptionController.dispose();
    super.dispose();
  }

  Future postMake(String title, String discreption) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser!;
    List Urls = await uploadFiles(imagesNames);
    await FirebaseFirestore.instance.collection('posts').doc().set({
      'title': title,
      'discreption': discreption,
      'email': firebaseUser.email,
      'images': Urls
    });
  }

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Title must not be empty";
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Tiltle",
                      prefixIcon: Icon(Icons.title),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 10,
                    controller: discreptionController,
                    decoration: InputDecoration(
                      labelText: "discreption",
                      prefixIcon: Icon(Icons.text_snippet_outlined),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  ElevatedButton(
                    child: Text('pick files'),
                    onPressed: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        allowMultiple: true,
                        type: FileType.custom,
                        allowedExtensions: ['jpg', 'jpeg', 'png'],
                      );

                      if (result != null) {
                        List<File> filess =
                            result.paths.map((path) => File(path!)).toList();
                        for (PlatformFile pfile in result.files) {
                          imagesNames.add(File(pfile.path!));
                        }

                        setState(() {
                          a = filess;
                        });
                        print(imagesNames);
                      } else {
                        // User canceled the picker
                      }
                    },
                  ),
                  Expanded(
                    child: a.length != 0
                        ? ListView.separated(
                            itemBuilder: (context, index) =>
                                buildImages(a[index]),
                            separatorBuilder: (context, index) => Divider(),
                            itemCount: a.length)
                        : Text('Pick'),
                  ),
                  ElevatedButton(
                    child: Text('upload'),
                    onPressed: () async {
                      await postMake(
                          titleController.text, discreptionController.text);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<List<String>> uploadFiles(List _images) async {
    List<String> imagesUrls = [];

    for (var _image in _images) {
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('posts/${pid}/${Path.basename(_image.path)}');
      UploadTask uploadTask = storageReference.putFile(_image);

      var snapshot = await uploadTask.whenComplete(() {});
      var urlDownload = await snapshot.ref.getDownloadURL();

      imagesUrls.add(urlDownload);
    }

    print(imagesUrls);
    return imagesUrls;
  }
}

Widget buildImages(File x) {
  return Image.file(
    x,
    width: double.infinity,
    fit: BoxFit.cover,
  );
}
