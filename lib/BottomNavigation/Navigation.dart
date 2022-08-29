import 'package:example/BottomNavigation/DoneScreen.dart';
import 'package:example/BottomNavigation/Profile.dart';
import 'package:example/BottomNavigation/TaskScreen.dart';
import 'package:example/model/storyModel.dart';
import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentIndex = 0;
  SuccessStories? successStories;
  bool isLoading = true;

  List<Widget> screens = [TaskScreen(), DoneScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task App"),
      ),
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
              icon: Icon(Icons.person_rounded), label: "Profile"),
        ],
      ),
      body: screens[currentIndex],
    );
  }
}