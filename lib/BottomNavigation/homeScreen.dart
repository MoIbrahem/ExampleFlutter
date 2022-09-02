import 'package:example/content/addContent.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task App"),
        automaticallyImplyLeading: false,
        centerTitle: true,
        // actions: [
        //   IconButton(
        //       onPressed: () async {
        //         final prefs = await SharedPreferences.getInstance();
        //         prefs.setBool('showHome', false);
        //
        //         Navigator.of(context).pushReplacement(
        //             MaterialPageRoute(builder: (context) => OnBording()));
        //       },
        //       icon: const Icon(Icons.logout))
        // ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddContentScreen(),
            ),
          );
        },
      ),
    );
  }
}