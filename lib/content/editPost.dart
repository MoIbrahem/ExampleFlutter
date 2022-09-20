import 'package:example/model/postModel.dart';
import 'package:flutter/material.dart';

class EditPost extends StatefulWidget {
  final PostModel postModel;

  const EditPost({Key? key, required this.postModel}) : super(key: key);

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
