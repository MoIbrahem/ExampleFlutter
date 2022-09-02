import 'package:flutter/material.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fields"),
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
      body: Center(
        child: Text(
          'Done Screen',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}