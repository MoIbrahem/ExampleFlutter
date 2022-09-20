import 'package:carousel_slider/carousel_slider.dart';
import 'package:example/model/postModel.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';


class DetailsOfPost extends StatefulWidget {
  final PostModel postModel;
  const DetailsOfPost({Key? key, required this.postModel}) : super(key: key);

  @override
  State<DetailsOfPost> createState() => _DetailsOfPostState();
}

class _DetailsOfPostState extends State<DetailsOfPost> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('details of the post'),
        centerTitle: true,
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
                      child: ClipRRect(
                        child: Image.network(
                          item,
                          fit: BoxFit.cover,
                          width: 1000.0,
                        ),
                      ),
                    ))
                    .toList(),
                options: CarouselOptions(
                    enableInfiniteScroll: false,
                    enlargeCenterPage: true,
                    height: 400,
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
