import 'package:example/model/postModel.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;


class YourPosts extends StatefulWidget {
  const YourPosts({Key? key}) : super(key: key);

  @override
  State<YourPosts> createState() => _YourPostsState();
}

class _YourPostsState extends State<YourPosts> {
  final user = FirebaseAuth.instance.currentUser!;
  List yourPosts = [];

  @override
  void initState() {
    fetchYourPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Posts'),
        centerTitle: true,
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => buildPosts(yourPosts[index]),
          separatorBuilder: (context, index) => Divider(),
          itemCount: yourPosts.length),
    );
  }


  fetchYourPosts() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {

      var records =
          await FirebaseFirestore.instance.collection('users').doc(firebaseUser.uid).collection('posts').get();
      print(records);
      mapRecords(records);
    }
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
      yourPosts = _list;
    });
  }
  Widget buildPosts(PostModel x) {
    return Card(
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
          )
        ],
      ),
    );
  }
}
