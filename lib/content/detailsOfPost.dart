import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/content/editPost.dart';
import 'package:example/model/postModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DetailsOfPost extends StatefulWidget {
  final PostModel postModel;

  const DetailsOfPost({Key? key, required this.postModel}) : super(key: key);

  @override
  State<DetailsOfPost> createState() => _DetailsOfPostState();
}

class _DetailsOfPostState extends State<DetailsOfPost> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details of the post'),
        actions: [
          widget.postModel.email == user.email
              ? ButtonBar(
                  alignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditPost(postModel: widget.postModel),
                            ),
                          );
                        },
                        icon: Icon(Icons.edit)),
                    IconButton(
                        onPressed: () {
                          Alert(
                                  context: context,
                                  type: AlertType.warning,
                                  title: "Confirm Delete",
                                  buttons: [
                                    DialogButton(
                                      onPressed: () async {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          },
                                        );

                                        await FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(user.uid)
                                            .collection('posts')
                                            .doc(widget.postModel.id)
                                            .delete();
                                        setState(() {});

                                        Navigator.pop(context);
                                        Navigator.of(context).pop();
                                      },
                                      color: Colors.green,
                                      width: 120,
                                      child: Text(
                                        "Yes",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                    DialogButton(
                                      onPressed: () => Navigator.pop(context),
                                      width: 120,
                                      color: Colors.red,
                                      child: Text(
                                        "No",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    )
                                  ],
                                  desc:
                                      "Are you sure you want to delete this post?")
                              .show();
                        },
                        icon: Icon(Icons.delete)),
                  ],
                )
              : Container(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Container(
            //   child: PhotoView(
            //     imageProvider: NetworkImage(
            //         'https://cdn.pixabay.com/photo/2015/04/19/08/33/flower-729512__340.jpg'),
            //   ),
            // )

              CarouselSlider(
                items: widget.postModel.images!
                    .map((item) => FullScreenWidget(
                        child: Center(
                          child: ClipRRect(
                            child: Image.network(
                              item,
                              fit: BoxFit.cover,
                              width: 1000.0,
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                      ))
                    .toList(),
                options: CarouselOptions(
                    enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                  height: 400,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.postModel.images!.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                      width: 12.0,
                      height: 12.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black)
                              .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                    ),
                  );
                }).toList(),
              ),

            ListTile(
                title: Center(child: Text(widget.postModel.title)),
                subtitle: Center(
                  child: Text(
                    widget.postModel.description!,
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
              ),

          ],
        ),
      ),
    );
  }
}
