import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/BottomNavigation/Navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../services/user.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final user = FirebaseAuth.instance.currentUser!;
  late Map<String, dynamic> data;
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();

  @override
  void initState() {
    _fetch();

    super.initState();
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
    emailController.text = data['email'];
    firstNameController.text = data['first name'];
    lastNameController.text = data['last name'];
    birthDateController.text =
        DateFormat('yyyy-MM-dd').format(data['birth date'].toDate());
  }

  @override
  void dispose() {
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    birthDateController.dispose();
    super.dispose();
  }

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Edit Profile",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "email address must not be empty";
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: firstNameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "first name must not be empty";
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "first name",
                        prefixIcon: Icon(Icons.account_circle),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: lastNameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "last name must not be empty";
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "last name",
                        prefixIcon: Icon(Icons.account_circle),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.datetime,
                      controller: birthDateController,
                      decoration: InputDecoration(
                        labelText: "Birth date",
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2100));

                        if (pickedDate != null) {
                          print(
                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(
                              formattedDate); //formatted date output using intl package =>  2021-03-16
                          setState(() {
                            birthDateController.text =
                                formattedDate; //set output date to TextField value.
                          });
                        } else {}
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          width: 150,
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Navigation(index: 1),
                                ),
                              );
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          width: 150,
                          child: MaterialButton(
                            onPressed: () {
                              UserManagement()
                                  .storeNewUser(
                                      firstNameController.text.trim(),
                                      lastNameController.text.trim(),
                                      emailController.text.trim(),
                                      DateTime.parse(
                                          birthDateController.text.trim()),
                                      user,
                                      context)
                                  .then((value) => Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Navigation(index: 1))))
                                  .catchError((e) {
                                Alert(
                                        context: context,
                                        type: AlertType.error,
                                        title: "Failed",
                                        buttons: [
                                          DialogButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            width: 120,
                                            child: Text(
                                              "Ok",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                          )
                                        ],
                                        desc: e.runtimeType ==
                                                FirebaseAuthException
                                            ? "some error with authentication"
                                            : "${e}")
                                    .show();
                                if (kDebugMode) {
                                  print(e);
                                }
                              });
                              ;
                            },
                            child: Text(
                              "Save",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
