import 'package:flutter/material.dart';

class UserModel {
  final int id;
  final String name;
  final String phone;

  UserModel({required this.id, required this.name, required this.phone});
}

class UserScreen extends StatelessWidget {
  List<UserModel> users = [
    UserModel(id: 1, name: "mohamed", phone: "02315"),
    UserModel(id: 2, name: "ahmed", phone: "0562315"),
    UserModel(id: 3, name: "mahmoud", phone: "02312121235"),
    UserModel(id: 4, name: "salah", phone: "024456315"),
    UserModel(id: 5, name: "adel", phone: "0236654515"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("home"),
          centerTitle: true,
        ),
        body: ListView.separated(
            itemBuilder: (context, index) => buildUsers(users[index]),
            separatorBuilder: (context, index) => Divider(),
            itemCount: users.length));
  }
}

Widget buildUsers(UserModel user) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 25,
          child: Text(
            "${user.id}",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              user.name,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              user.phone,
              style: TextStyle(
                color: Colors.grey,
              ),
            )
          ],
        )
      ],
    ),
  );
}
