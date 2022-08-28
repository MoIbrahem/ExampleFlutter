import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/model/userModel.dart';
import 'package:example/userScreen.dart';
import 'package:flutter/material.dart';

class CreateUser extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: controller,
        ),
        actions: [
          IconButton(
              onPressed: () async {
                final String name = controller.text;
                final docUser = FirebaseFirestore.instance
                    .collection("users")
                    .doc('Minato');

                final user = UsersModel(
                  id: docUser.id,
                  name: name,
                  age: "25",

                );

                final json = user.toJson();

                // final json = {
                //   'name' : name,
                //   'age' : '25',
                //   'birthdate' : DateTime(1999,7,31),
                // };

                await docUser.set(json);
              },
              icon: Icon(Icons.add))
        ],
      ),
    );
  }
}
