import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("home"),
        centerTitle: true,
        leading: Icon(Icons.menu),
        actions: [
          Icon(Icons.star),
          IconButton(
              onPressed: () {
                print("1234");
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: SafeArea(
          child: Container(
        width: double.infinity,
        color: Colors.cyan,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                height: 150,
                child: Text(
                  "barca",
                  style: TextStyle(
                    backgroundColor: Colors.blue,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Container(
              height: 150,
              child: Text(
                "hidden",
                style: TextStyle(
                  backgroundColor: Colors.yellow,
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              height: 150,
              child: Text(
                "two",
                style: TextStyle(
                  backgroundColor: Colors.red,
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
                height: 150,
                color: Colors.redAccent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 150,
                      child: Text(
                        "rowelement1",
                        style: TextStyle(
                          backgroundColor: Colors.blue,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      width: 150,
                      child: Text(
                        "rowelement2",
                        style: TextStyle(
                          backgroundColor: Colors.blue,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      width: 150,
                      child: Text(
                        "rowelement3",
                        style: TextStyle(
                          backgroundColor: Colors.blue,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    )
                  ],
                )),
          ],
        ),
      )),
    );
  }
}
