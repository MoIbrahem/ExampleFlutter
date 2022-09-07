import 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/content/addContent.dart';
import 'package:example/model/postModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List postsList = [];
  final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    fetchRecords();
    super.initState();
  }

  fetchRecords() async {
    var records =
        await FirebaseFirestore.instance.collectionGroup("posts").get();
    print(records);
    mapRecords(records);
  }

  mapRecords(QuerySnapshot<Map<String, dynamic>> records) {
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

    setState(() {
      _list.sort((b, a) => a.created!.compareTo(b.created!));
      postsList = _list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddContentScreen(),
              ),
            );
          },
        ),
        body: SafeArea(
          child: ListView.separated(
              itemBuilder: (context, index) => buildPosts(postsList[index]),
              separatorBuilder: (context, index) => Divider(),
              itemCount: postsList.length),
        ));
  }

  Widget buildPosts(PostModel x) {
    return GestureDetector(
      onTap: () {
        print("1");
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
                            postsList.remove(x);
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(user.uid)
                                .collection('posts')
                                .doc(x.id)
                                .delete();
                            setState(() {});
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
}
