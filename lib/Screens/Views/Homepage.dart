import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medical/Screens/Views/Dashboard_screen.dart';
import 'package:medical/Screens/Views/doctor_search.dart';
import 'package:medical/Screens/Login-Signup/Profile_screen.dart';
import 'package:medical/Screens/Views/rumahSakit_screen.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<IconData> icons = [
    FontAwesomeIcons.house,
    FontAwesomeIcons.stethoscope,
    FontAwesomeIcons.hospital,
    FontAwesomeIcons.user,
  ];

  int page = 0;

  List<Widget> pages = [
    const Dashboard(),
    const doctor_search(),
    const RumahSakitScreen(),
    const Profile_screen(savedArticles: [],),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[page], // Display the selected page
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: icons,
        iconSize: 20,
        activeIndex: page,
        height: 80,
        splashSpeedInMilliseconds: 300,
        gapLocation: GapLocation.none,
        activeColor: const Color.fromARGB(255, 64, 190, 240),
        inactiveColor: const Color.fromARGB(255, 223, 219, 219),
        onTap: (int tappedIndex) {
          setState(() {
            page = tappedIndex; // Update the selected page
          });
        },
      ),
    );
  }
}
