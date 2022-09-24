// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/BottomNavigation/Navigation.dart';
import 'package:example/model/postModel.dart';
import 'package:example/services/posts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class EditPost extends StatefulWidget {
  final PostModel postModel;

  const EditPost({Key? key, required this.postModel}) : super(key: key);

  @override
  State<EditPost> createState() => _EditPostState(post: postModel);
}

class _EditPostState extends State<EditPost> {
  PostModel post;

  _EditPostState({required this.post});

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List displayedImages = [];
  List imagesToUpload = [];
  List imagesToDelete = [];
  List orgImages = [];

  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    titleController.text = post.title;
    descriptionController.text = post.description!;
    orgImages = List.from(post.images!);
    print(orgImages);

    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future postUpdate(String title, String discreption) async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    var firebaseUser = await FirebaseAuth.instance.currentUser!;
    List urls = await PostsManagement().uploadFiles(imagesToUpload);

    await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser.uid)
        .collection('posts')
        .doc(post.id)
        .update({
      'title': title,
      'description': discreption,
      'images': orgImages + urls,
    });
    if (imagesToDelete.length != 0) {
      await PostsManagement().deleteFiles(imagesToDelete);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Post"),
        actions: [
          FlatButton(
            textColor: Colors.white,
            onPressed: () async {
              if (imagesToUpload.isNotEmpty || orgImages.isNotEmpty) {
                await postUpdate(
                        titleController.text, descriptionController.text)
                    .then((value) => Alert(
                            context: context,
                            type: AlertType.success,
                            title: "edited Sucessfully",
                            buttons: [
                              DialogButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Navigation(
                                                index: 0,
                                              )));
                                },
                                width: 120,
                                child: Text(
                                  "Cool",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              )
                            ],
                            desc: "Your Post is now available to all users.")
                        .show())
                    .catchError((e) {
                  Alert(
                          context: context,
                          type: AlertType.error,
                          title: "Failed post",
                          buttons: [
                            DialogButton(
                              onPressed: () => Navigator.pop(context),
                              width: 120,
                              child: Text(
                                "Ok",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            )
                          ],
                          desc: "${e}")
                      .show();
                  if (kDebugMode) {
                    print(e);
                  }
                });
              } else {
                Alert(
                        context: context,
                        type: AlertType.warning,
                        title: "No images",
                        buttons: [
                          DialogButton(
                            onPressed: () => Navigator.pop(context),
                            width: 120,
                            child: Text(
                              "Ok",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          )
                        ],
                        desc: "you must pick images to post")
                    .show();
              }
            },
            child: Text("Save", style: TextStyle(fontSize: 20)),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Form(
                key: formKey,
                child: Expanded(
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
                        controller: descriptionController,
                        decoration: InputDecoration(
                          labelText: "description",
                          prefixIcon: Icon(Icons.text_snippet_outlined),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        width: double.infinity,
                        child: ElevatedButton(
                          child: Text('Add Images'),
                          onPressed: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles(
                              allowMultiple: true,
                              type: FileType.custom,
                              allowedExtensions: ['jpg', 'jpeg', 'png'],
                            );

                            if (result != null) {
                              List<File> filess = result.paths
                                  .map((path) => File(path!))
                                  .toList();
                              for (PlatformFile pfile in result.files) {
                                imagesToUpload.add(File(pfile.path!));
                              }

                              setState(() {
                                displayedImages = filess;
                              });
                              print(imagesToUpload);
                            } else {
                              // User canceled the picker
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("original Images"),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: orgImages.length,
                        itemBuilder: (context, index) =>
                            buidImageCard(index, orgImages[index]),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                      ),
                      Text("Added Images"),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: displayedImages.length,
                        itemBuilder: (context, index) =>
                            buidImageCard(index, displayedImages[index]),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buidImageCard(int index, var url) => Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          margin: const EdgeInsets.all(8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              decoration: url is String
                  ? BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(url),
                        fit: BoxFit.cover,
                      ),
                    )
                  : BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(url),
                        fit: BoxFit.cover,
                      ),
                    ),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                    decoration: BoxDecoration(
                        // color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(100)),
                    child: IconButton(
                      onPressed: () {
                        if (url is String) {
                          imagesToDelete.add(url);
                          orgImages.removeAt(index);
                        } else {
                          displayedImages.removeAt(index);
                        }
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    )),
              ),
            ),
          ),
        ),
      );
}
