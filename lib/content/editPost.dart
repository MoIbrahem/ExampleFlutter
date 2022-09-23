import 'package:example/BottomNavigation/Navigation.dart';
import 'package:example/model/postModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EditPost extends StatefulWidget {
  final PostModel postModel;

  const EditPost({Key? key, required this.postModel}) : super(key: key);

  @override
  State<EditPost> createState() => _EditPostState(post: postModel);
}

class _EditPostState extends State<EditPost> {
  PostModel post;

  _EditPostState({required this.post});

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List a = [];
  List imagesNames = [];

  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    titleController.text = post.title;
    descriptionController.text = post.description!;
    imagesNames = post.images!;
    print(imagesNames);

    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Form(
              key: formKey,
              child: Expanded(
                child: Column(
                  children: [
                    TextFormField(
                      controller: titleController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Title must not be empty";
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Tiltle",
                        prefixIcon: Icon(Icons.title),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 10,
                      controller: descriptionController,
                      decoration: InputDecoration(
                        labelText: "description",
                        prefixIcon: Icon(Icons.text_snippet_outlined),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        child: GridView.builder(
                      itemCount: imagesNames.length,
                      itemBuilder: (context, index) =>
                          buidImageCard(index, imagesNames[index]),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                      ),
                    )),
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
                                  builder: (context) => Navigation(index: 0),
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
                              // UserManagement()
                              //     .storeNewUser(
                              //     firstNameController.text.trim(),
                              //     lastNameController.text.trim(),
                              //     emailController.text.trim(),
                              //     DateTime.parse(
                              //         birthDateController.text.trim()),
                              //     user,
                              //     context)
                              //     .then((value) => Navigator.pushReplacement(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             Navigation(index: 1))))
                              //     .catchError((e) {
                              //   Alert(
                              //       context: context,
                              //       type: AlertType.error,
                              //       title: "Failed",
                              //       buttons: [
                              //         DialogButton(
                              //           onPressed: () =>
                              //               Navigator.pop(context),
                              //           width: 120,
                              //           child: Text(
                              //             "Ok",
                              //             style: TextStyle(
                              //                 color: Colors.white,
                              //                 fontSize: 20),
                              //           ),
                              //         )
                              //       ],
                              //       desc: e.runtimeType ==
                              //           FirebaseAuthException
                              //           ? "some error with authentication"
                              //           : "${e}")
                              //       .show();
                              //   if (kDebugMode) {
                              //     print(e);
                              //   }
                              // });
                              // ;
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

Widget buidImageCard(int index, String url) => Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(url),
                fit: BoxFit.cover,
              ),
            ),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                  decoration: BoxDecoration(
                      // color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(100)),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
