import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/auth/LoginScreen.dart';
import 'package:example/main_page.dart';
import 'package:example/services/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool visible = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();

  @override
  void initState() {
    birthDateController.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    birthDateController.dispose();
    super.dispose();
  }

  Future signUp() async {
    if (passwordConfirmed()) {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim())
          .then((signedInUser) {
            UserManagement().storeNewUser(
                firstNameController.text.trim(),
                lastNameController.text.trim(),
                emailController.text.trim(),
                DateTime.parse(birthDateController.text.trim()),
                signedInUser.user,
                context);
          })
          .then((value) => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MainPage())))
          .catchError((e) {
            Alert(
                    context: context,
                    type: AlertType.error,
                    title: "Failed Register",
                    buttons: [
                      DialogButton(
                        onPressed: () => Navigator.pop(context),
                        width: 120,
                        child: Text(
                          "Ok",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      )
                    ],
                    desc: e.runtimeType == FirebaseAuthException
                        ? "This email is already in use"
                        : "${e}")
                .show();
            if (kDebugMode) {
              print(e);
            }
          });
    }
  }

  Future addUserDetails(String firstName, String lastName, String email,
      DateTime birthDate) async {
    await FirebaseFirestore.instance.collection('users').add({
      'first name': firstName,
      'last name': lastName,
      'email': email,
      'birth date': birthDate
    });
  }

  bool passwordConfirmed() {
    if (passwordController.text.trim() ==
        confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
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
                        "Register",
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
                      height: 25,
                    ),
                    TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "password must not be empty";
                        } else if (value.length < 5) {
                          return "password is too short";
                        }
                      },
                      obscureText: visible,
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                            onPressed: () {
                              visible = !visible;
                              setState(() {});
                            },
                            icon: visible
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility)),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: confirmPasswordController,
                      validator: (value) {
                        if (passwordController.text.trim() !=
                            confirmPasswordController.text.trim()) {
                          return "must match password above";
                        }
                      },
                      obscureText: visible,
                      decoration: InputDecoration(
                        labelText: "confirm password",
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                            onPressed: () {
                              visible = !visible;
                              setState(() {});
                            },
                            icon: visible
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility)),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      width: double.infinity,
                      child: MaterialButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            print(emailController.text);
                            print(passwordController.text);
                            signUp();
                          }
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account ?"),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          },
                          child: Text("Login"),
                        ),
                      ],
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
