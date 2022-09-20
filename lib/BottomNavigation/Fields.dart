import 'package:example/BottomNavigation/AboutScreen.dart';
import 'package:example/BottomNavigation/Navigation.dart';
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
              Text(
                'App consist of : ',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '1. OnBoarding Screen',
                style: TextStyle(
                  fontSize: 23,
                  // fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '2. Register System',
                style: TextStyle(
                  fontSize: 23,
                  // fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(children: [
                Text(
                  '3. Home Screen',
                  style: TextStyle(
                    fontSize: 23,
                    // color: Colors.blue,
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
                Text(
                  '4. Add content Screen',
                  style: TextStyle(
                    fontSize: 23,


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
                Text(
                  '5. Profile Screen',
                  style: TextStyle(
                    fontSize: 23,


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
                          builder: (context) => Navigation(index: 1),
                        ),
                      );
                    },
                    child: Text('Go'))
              ]),
              SizedBox(
                height: 20,
              ),
              Text(
                '6. fields Screen',
                style: TextStyle(
                  fontSize: 23,
                  // fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),

              Row(children: [
                Text(
                  '7. About Screen',
                  style: TextStyle(
                    fontSize: 23,

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
