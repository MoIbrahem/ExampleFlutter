import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserManagement {
  storeNewUser(String firstName, String lastName, String email,
      DateTime birthDate, user, context) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser.uid)
        .set({
      'first name': firstName,
      'last name ': lastName,
      'email': email,
      'birth date': birthDate
    });
  }
}
