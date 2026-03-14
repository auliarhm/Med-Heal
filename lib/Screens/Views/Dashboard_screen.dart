import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical/Screens/Views/doctor_details_2.dart';
import 'package:medical/Screens/Views/doctor_details_3.dart';
import 'package:medical/Screens/Views/doctor_details_4.dart';
import 'package:medical/Screens/Views/doctor_details_5.dart';
import 'package:medical/Screens/Views/doctor_search.dart';
import 'package:medical/Screens/Views/rumahSakit_screen.dart';
import 'package:medical/Screens/Views/find_ambulance.dart';
import 'package:medical/Screens/Widgets/articlePage.dart';
import 'package:medical/Screens/Widgets/banner.dart';
import 'package:medical/Screens/Widgets/list_doctor1.dart';
import 'package:medical/Screens/Widgets/listicons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:medical/Screens/Widgets/article.dart';
class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Container(
              alignment: Alignment.bottomCenter,
              height: MediaQuery.of(context).size.height * 0.20,
              width: MediaQuery.of(context).size.width * 0.20,
              child: Image.asset(
                "images/Logo RS Sentosa.png",
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
        ],
        title: Column(
          children: [
            
            Text(
              "Healthcare RS Sentosa",
              style: GoogleFonts.inter(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1),
            ),
          ],
        ),
        toolbarHeight: 130,
        elevation: 0,
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 20,
          ),
          //Body Start fro here
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context, 
                    PageTransition( 
                      type: PageTransitionType.rightToLeft,
                      child: const doctor_search(),
                    )
                  );
                },
                child: const listIcons(
                  Icon: "lib/icons/stetoskop.png", 
                  text: "Dokter"
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context, 
                    PageTransition( 
                      type: PageTransitionType.rightToLeft,
                      child: const RumahSakitScreen(),
                    )
                  );
                },
                child: const listIcons(
                  Icon: "lib/icons/rumah sakit.png", 
                  text: "Rumah Sakit"
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context, 
                    PageTransition( 
                      type: PageTransitionType.rightToLeft,
                      child: const FindAmbulance(),
                    )
                  );
                },
                child: const listIcons(
                  Icon: "lib/icons/ambulans.png", 
                  text: "Ambulans"
                ),
              ),
            ],
          ),

          //List icons (Can Edit in Widgets )
          const SizedBox(
            height: 10,
          ),
          const banner(),
          // Banner Design
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Top Dokter",
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromARGB(255, 46, 46, 46),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: const doctor_search()));
                  },
                  child: Text(
                    "Lihat Semua",
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      color: const Color.fromARGB(255, 64, 190, 254),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SizedBox(
              height: 180,
              width: 400,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
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
                    child:const list_doctor1(
                      image: "lib/icons/adek.png",
                      maintext: "Dr. Adik N",
                      numRating: "4.8",
                      subtext: "Spesialis Kandungan"
                    ) ,               
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context, 
                        PageTransition(
                        child: const DoctorDetails4(), 
                        type: PageTransitionType.rightToLeft,
                        )
                      );
                    },
                    child:const list_doctor1(
                      image: "lib/icons/aul.png",
                      maintext: "Dr. Annisa A",
                      numRating: "4.7",
                      subtext: "Spesialis Mata"
                    ) , 
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context, 
                        PageTransition(
                        child: const DoctorDetails3(), 
                        type: PageTransitionType.rightToLeft,
                        )
                      );
                    },
                    child:const list_doctor1(
                      image: "lib/icons/cela.png",
                      maintext: "Dr. Sheila N",
                      numRating: "4.9",
                      subtext: "Spesialis Saraf"
                    ) , 
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context, 
                        PageTransition(
                        child: const DoctorDetails5(), 
                        type: PageTransitionType.rightToLeft,
                        )
                      );
                    },
                    child:const list_doctor1(
                      image: "lib/icons/dingan.png",
                      maintext: "Dr. Dian F",
                      numRating: "4.7",
                      subtext: "Spesialis Anak"
                    ) , 
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Artikel Kesehatan",
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromARGB(255, 46, 46, 46),
                  ),
                  ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: const ArticlePage()));
                  },
                  child: Text(
                    "Lihat Semua",
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      color: const Color.fromARGB(255, 64, 190, 240),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const article(
              image: "images/article1.jpg",
              dateText: "Jun 10, 2021 ",
              duration: "5min read",
              mainText:
                  "The 25 Healthiest Fruits You Can Eat,\nAccording to a Nutritionist"),        
        ]),
      ),
    );
  }
}