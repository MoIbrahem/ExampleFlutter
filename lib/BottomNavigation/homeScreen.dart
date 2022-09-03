import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/content/addContent.dart';
import 'package:example/model/postModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
      postsList = _list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Task App"),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
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
}

Widget buildPosts(PostModel x) {
  return Card(
    child: Column(
      children: [
        Row(
          children: [Image.network(x.images![0])],
        ),
        Row(
          children: [
            Text(x.title),
            Text(DateFormat('yyyy-MM-dd').format(x.created!))
          ],
        )
      ],
    ),
  );
}
