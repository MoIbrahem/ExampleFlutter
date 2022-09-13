import 'package:carousel_slider/carousel_slider.dart';
import 'package:example/model/postModel.dart';
import 'package:flutter/material.dart';

class DetailsOfPost extends StatefulWidget {
  final PostModel postModel;
  const DetailsOfPost({Key? key, required this.postModel}) : super(key: key);



  @override
  State<DetailsOfPost> createState() => _DetailsOfPostState();
}

class _DetailsOfPostState extends State<DetailsOfPost> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('details of the post'),
        centerTitle: true,
      ),
      body: Card(
          child: Column(
        children: [
          CarouselSlider(
            items: widget.postModel.images!
                .map((item) => Container(
                      child: Center(
                          child: Image.network(item,
                              fit: BoxFit.cover, width: double.infinity)),
                    ))
                .toList(),
            options: CarouselOptions( enableInfiniteScroll: false,),
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
      )),
    );
  }
}
