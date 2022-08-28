import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/dio/apiProvider.dart';
import 'package:example/model/userModel.dart';
import 'package:flutter/material.dart';

class ReadUsers extends StatefulWidget {
  @override
  State<ReadUsers> createState() => _ReadUsersState();
}

class _ReadUsersState extends State<ReadUsers> {
  /// put this method in api provider file

  // Future<UsersModel?> readUsers() async {
  //   await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc("my-id2")
  //       .get()
  //       .then((value) {
  //     usersModel = UsersModel.fromMap(value.data()!);
  //
  //     print(usersModel?.name);
  //     print(value.data());
  //     return usersModel;
  //   });
  // }

  UsersModel? usersModel;

  getUser() async {
    usersModel = (await ApiProvider().readUsers()) as UsersModel?;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All users"),
      ),
      body: IconButton(
        onPressed: () {
          FirebaseFirestore.instance
              .collection("users")
              .doc("my-id2")
              .update({'name': 'updated'});
          // FirebaseFirestore.instance.collection("users").doc("Minato").delete();
        },
        icon: Icon(
          Icons.add,
          size: 50,
        ),
      ),
    );
  }
}
