import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
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
      body: Container(
        // color: Colors.grey,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'About App',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blue,
                ),
                child: Text(
                  'Our app provides lots of benefits Our app provides lots of benefitsOur app provides lots of benefits ',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'About Developers',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                            'https://avatars.githubusercontent.com/u/51864970?v=4'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Mohammed Ibrahim'),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Flutter Developer'),
                    ],
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                            'https://avatars.githubusercontent.com/u/73416301?s=400&u=c2542cf6d5ec4465dbfb8f46d86aced2d63d85dd&v=4'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Nada Elborhamy'),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Flutter Developer'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
