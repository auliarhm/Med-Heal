import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical/Screens/Views/Homepage.dart';
import 'package:medical/Screens/Views/doctor_details_2.dart';
import 'package:medical/Screens/Views/doctor_details_3.dart';
import 'package:medical/Screens/Views/doctor_details_4.dart';
import 'package:medical/Screens/Views/doctor_details_5.dart';
import 'package:medical/Screens/Widgets/doctorList.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class doctor_search extends StatelessWidget {
  const doctor_search({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
                context,
                PageTransition(
                    type: PageTransitionType.fade, child: const Homepage()));
          },
          child: Container(
            height: 10,
            width: 10,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage("lib/icons/back1.png"),
            )),
          ),
        ),
        title: Text(
          "Top Dokter",
          style: GoogleFonts.poppins(color: Colors.black, fontSize: 18.sp),
        ),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 100,
        backgroundColor: const Color.fromARGB(255, 251, 252, 252),
      ),
      body: SafeArea(
          child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: const DoctorDetails2(),
                )
              );
            },
            child:const doctorList(
              image: "lib/icons/adek.png",
              maintext: "Dr. Adik N",
              numRating: "4.8",
              subtext: "Spesialis Kandungan") ,
          ),
          
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: const DoctorDetails4(),
                )
              );
            },
            child:const doctorList(
              image: "lib/icons/aul.png",
              maintext: "Dr. Annisa A",
              numRating: "4.7",
              subtext: "Spesialis Mata"),
          ),

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: const DoctorDetails5(),
                )
              );
            },
            child: const doctorList(
              image: "lib/icons/dingan.png",
              maintext: "Dr. Dian F",
              numRating: "4.7",
              subtext: "Spesialis Anak"),
          ),

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: const DoctorDetails3(),
                )
              );
            },
            child: const doctorList(
              image: "lib/icons/cela.png",
              maintext: "Dr. Sheila N",
              numRating: "4.9",
              subtext: "Spesialis Saraf"),
          ),
        ],
      )),
    );
  }
}
