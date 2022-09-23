import 'package:example/BottomNavigation/AboutScreen.dart';
import 'package:example/BottomNavigation/Profile/Profile.dart';
import 'package:example/BottomNavigation/homeScreen.dart';
import 'package:example/content/addContent.dart';
import 'package:flutter/material.dart';

class FieldsScreen extends StatelessWidget {
  const FieldsScreen({Key? key}) : super(key: key);

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
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(5),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'App consists of : ',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  CircleAvatar(
                    child: Text(
                      '1',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.blue,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'OnBoarding Screen',
                    style: TextStyle(
                      fontSize: 23,
                      color: Colors.blue,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  CircleAvatar(
                    child: Text(
                      '2',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.blue,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Register System',
                    style: TextStyle(
                      fontSize: 23,
                      color: Colors.blue,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(children: [
                CircleAvatar(
                  child: Text(
                    '3',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.blue,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Home Screen',
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.blue,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    },
                    child: Text('Go'))
              ]),
              SizedBox(
                height: 20,
              ),
              Row(children: [
                CircleAvatar(
                  child: Text(
                    '4',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.blue,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Add content Screen',
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.blue,

                    // fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddContentScreen(),
                        ),
                      );
                    },
                    child: Text('Go'))
              ]),
              SizedBox(
                height: 20,
              ),
              Row(children: [
                CircleAvatar(
                  child: Text(
                    '5',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.blue,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Profile Screen',
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.blue,

                    // fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(),
                        ),
                      );
                    },
                    child: Text('Go'))
              ]),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  CircleAvatar(
                    child: Text(
                      '6',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.blue,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'fields Screen',
                    style: TextStyle(
                      fontSize: 23,
                      color: Colors.blue,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(children: [
                CircleAvatar(
                  child: Text(
                    '7',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.blue,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'About Screen',
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.blue,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AboutScreen(),
                        ),
                      );
                    },
                    child: Text('Go'))
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
