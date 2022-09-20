import 'package:example/BottomNavigation/AboutScreen.dart';
import 'package:example/BottomNavigation/Fields.dart';
import 'package:example/BottomNavigation/Profile/Profile.dart';
import 'package:example/BottomNavigation/homeScreen.dart';
import 'package:example/model/storyModel.dart';
import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  final int index;

  const Navigation({Key? key, required this.index}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState(currentIndex: this.index);
}

class _NavigationState extends State<Navigation> {
  int currentIndex;

  _NavigationState({required this.currentIndex});

  SuccessStories? successStories;
  bool isLoading = true;

  List<Widget> screens = [
    HomeScreen(),
    ProfileScreen(),
    FieldsScreen(),
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
