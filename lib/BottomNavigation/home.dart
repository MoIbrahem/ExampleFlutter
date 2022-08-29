import 'package:example/BottomNavigation/DoneScreen.dart';
import 'package:example/BottomNavigation/Profile.dart';
import 'package:example/BottomNavigation/TaskScreen.dart';
import 'package:example/dio/apiProvider.dart';
import 'package:example/model/storyModel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int currentIndex=0;
  SuccessStories? successStories;
  bool isLoading = true;

  getData() async {
    successStories = await ApiProvider().getSuccessStories();
    setState(() {
      isLoading = false;
    });
    print(successStories?.model![0].id);
  }

  createSharedPrefrences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("num", 7);
    prefs.setString("name", "mohamed");

    int? x = prefs.getInt("num");
    String? y = prefs.getString("name");

    print(x);
    print(y);


  }


  List<Widget> screens = [
    TaskScreen(),
    DoneScreen(),
    ProfileScreen()];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    createSharedPrefrences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task App"),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){},
      //   child: Icon(Icons.add),
      // ),
      body: isLoading
          ? CircularProgressIndicator()
          : Text(successStories!.model![0].title!),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          print(index);
          currentIndex = index;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Tasks"),
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: "Done",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.archive_outlined), label: "Archived"),
        ],
      ),
    );
  }
}