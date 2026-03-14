import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical/Screens/Login-Signup/shedule_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medical/Screens/Widgets/articlePage.dart';
import 'package:medical/Screens/Login-Signup/login_register_page.dart';

class Profile_screen extends StatelessWidget {
  final List<Article> savedArticles;

  const Profile_screen({Key? key, required this.savedArticles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the current logged-in user
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFF40bef0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            // Profile image in the center
            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  border: Border.all(width: 4, color: Colors.white),
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.1),
                    ),
                  ],
                  shape: BoxShape.circle,
                  image: const DecorationImage(
                    image: AssetImage("lib/icons/akun2.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Email or username below the profile image
            Text(
              user?.email ?? 'user@example.com', // Show email or default
              style: GoogleFonts.poppins(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            // Main menu
            Container(
              height: 550,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  // Appointment Section
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ScheduleScreen(),
                        ),
                      );
                    },
                    child: const profile_list(
                      image: "lib/icons/appoint.png",
                      title: "Appointment",
                      color: Color(0xFF40bef0),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    child: Divider(),
                  ),
                  // Logout Section
                  GestureDetector(
                    onTap: () async {
                      // Logout dari Firebase Authentication
                      await FirebaseAuth.instance.signOut();

                      // Navigasi ke Homepage
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                        (route) => false, // Menghapus semua halaman sebelumnya dari stack
                      );
                    },
                    child: const profile_list(
                      image: "lib/icons/logout.png",
                      title: "Log out",
                      color: Colors.red,
                    ),
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

class profile_list extends StatelessWidget {
  final String image;
  final String title;
  final Color color;

  const profile_list({
    Key? key,
    required this.image,
    required this.title,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Row(
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            child: Image.asset(
              image,
              height: 30,
              width: 30,
            ),
          ),
          const SizedBox(width: 20),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
