import 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/content/detailsOfPost.dart';
import 'package:example/model/postModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class PostsManagement {
  final user = FirebaseAuth.instance.currentUser!;

  Widget buildPosts(State state, List postsList, PostModel x, context) {
    return GestureDetector(
      onTap: () {
        print("1");

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsOfPost(postModel: x),
          ),
        );

        // print(x.description);
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              x.images![0],
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            ListTile(
              title: Text(x.title),
              subtitle: Text(
                x.description!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
            x.email == user.email
                ? ButtonBar(
                    alignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                      IconButton(
                          onPressed: () {
                            Alert(
                                    context: context,
                                    type: AlertType.warning,
                                    title: "Confirm Delete",
                                    buttons: [
                                      DialogButton(
                                        onPressed: () async {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            },
                                          );

                                          await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(user.uid)
                                              .collection('posts')
                                              .doc(x.id)
                                              .delete();
                                          await postsList.remove(x);
                                          state.setState(() {});

                                          Navigator.pop(context);
                                          Navigator.of(context).pop();
                                        },
                                        color: Colors.green,
                                        width: 120,
                                        child: Text(
                                          "Yes",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ),
                                      DialogButton(
                                        onPressed: () => Navigator.pop(context),
                                        width: 120,
                                        color: Colors.red,
                                        child: Text(
                                          "No",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      )
                                    ],
                                    desc:
                                        "Are you sure you want to delete this post?")
                                .show();
                          },
                          icon: Icon(Icons.delete)),
                    ],
                  )
                : Container(),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Container(
                  width: double.infinity,
                  child: Text(
                    DateFormat('yyyy-MM-dd hh:mm').format(x.created!),
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.5), fontSize: 12),
                    textDirection: ui.TextDirection.rtl,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  List mapRecords(
      State state, List posts, QuerySnapshot<Map<String, dynamic>> records) {
    var _list = records.docs
        .map((post) => PostModel(
            id: post.id,
            title: post['title'],
            email: post['email'],
            images: post['images'],
            description: post['description'],
            created: post['created'].toDate()))
        .toList();

    print(_list);
    _list.sort((b, a) => a.created!.compareTo(b.created!));
    posts = _list;
    state.setState(() {});
    return posts;
  }
}
