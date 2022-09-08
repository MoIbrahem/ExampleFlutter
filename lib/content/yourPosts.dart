import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/services/posts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class YourPosts extends StatefulWidget {
  const YourPosts({Key? key}) : super(key: key);

  @override
  State<YourPosts> createState() => _YourPostsState();
}

class _YourPostsState extends State<YourPosts> {
  List postsList = [];

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
          itemBuilder: (context, index) =>
              PostsManagement().buildPosts(this, postsList, postsList[index]),
          separatorBuilder: (context, index) => Divider(),
          itemCount: postsList.length),
    );
  }

  fetchYourPosts() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      var records = await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .collection('posts')
          .get();
      print(records);
      postsList = PostsManagement().mapRecords(this, postsList, records);
    }
  }
}
