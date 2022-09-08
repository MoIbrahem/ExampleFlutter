import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/content/addContent.dart';
import 'package:example/services/posts.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List postsList = [];

  @override
  void initState() {
    fetchRecords();
    super.initState();
  }

  fetchRecords() async {
    var records =
        await FirebaseFirestore.instance.collectionGroup("posts").get();
    print(records);
    postsList = PostsManagement().mapRecords(this, postsList, records);
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
              itemBuilder: (context, index) => PostsManagement()
                  .buildPosts(this, postsList, postsList[index]),
              separatorBuilder: (context, index) => Divider(),
              itemCount: postsList.length),
        ));
  }

}
