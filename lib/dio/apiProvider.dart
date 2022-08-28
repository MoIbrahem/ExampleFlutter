import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:example/model/storyModel.dart';
import 'package:example/userScreen.dart';
import 'package:firebase_core/firebase_core.dart';

import '../model/userModel.dart';

class ApiProvider {
  SuccessStories? successStories;
  final String apiUrl = "http://159.89.4.181:2000/api/v1";

  Future<SuccessStories?> getSuccessStories() async {
    Response response = await Dio().get("$apiUrl/success-stories");
    successStories = SuccessStories.fromMap(response.data);
    print(successStories?.model![0].title);
    return successStories;
  }

  UsersModel? usersModel;
  Future<UserModel?> readUsers() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc("Minato")
        .get()
        .then((value) {
      usersModel = UsersModel.fromMap(value.data()!);

      print(usersModel?.name);
      print(value.data());
      return usersModel;
    });
  }

  signInEmail({required String email, required String password}) async {
    try {
      FormData formData =
          FormData.fromMap({"email": email, "password": password});

      Response response =
          await Dio().post("$apiUrl/auth/email/signin", data: formData);

      print(response.data);
      print(response.data["model"]["tokens"]["accessToken"]);
    } catch (e) {
      print(e);
    }
  }
}
