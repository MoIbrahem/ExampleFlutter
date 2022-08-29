import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  late Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
              future: _fetch(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done)
                  return Text("Loading data...Please wait");
                return Column(
                  children: [
                    Text("Name  : ${data['first name']} ${data['last name']}"),
                    Text(
                        "Birth date  : ${DateFormat('yyyy-MM-dd').format(data['birth date'].toDate())}"),
                  ],
                );
              },
            ),
            Text('signed in as: ' + user.email!),
            MaterialButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              color: Colors.grey,
              child: Text('sign out'),
            )
          ],
        ),
      ),
    );
  }

  _fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    if (firebaseUser != null)
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        data = ds.data() as Map<String, dynamic>;
      }).catchError((e) {
        print(e);
      });
  }
}
