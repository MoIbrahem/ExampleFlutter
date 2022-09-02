import 'package:example/BottomNavigation/AboutScreen.dart';
import 'package:example/BottomNavigation/DoneScreen.dart';
import 'package:example/BottomNavigation/Profile.dart';
import 'package:example/BottomNavigation/homeScreen.dart';
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

  List<Widget> screens = [
    HomeScreen(),
    ProfileScreen(),
    DoneScreen(),
    AboutScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          print(index);
          currentIndex = index;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded), label: "Profile"),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Fields",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: "About")
        ],
      ),
      body: screens[currentIndex],
    );
  }
}
