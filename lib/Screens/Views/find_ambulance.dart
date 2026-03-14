import 'package:medical/Screens/Views/ambulance1_details_screen.dart';
import 'package:medical/Screens/Views/ambulance2_details_screen.dart';
import 'package:medical/Screens/Views/ambulance3_details_screen.dart';
import 'package:medical/Screens/Views/ambulance4_details_screen.dart';
import 'package:medical/Screens/Views/ambulance5_details_screen.dart';
import 'package:medical/Screens/Views/ambulance6_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:page_transition/page_transition.dart';

class FindAmbulance extends StatelessWidget {
  const FindAmbulance({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.06,
            child: Image.asset("lib/icons/back2.png"),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: const Color(0xFFFFFFFF),
        title: Text(
          "Ambulans",
          style: GoogleFonts.inter(
            color: const Color(0xFF33302F),
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFF7F8FB),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 26),
              Text(
                "Rekomendasi Top Ambulans",
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF2E2E2E),
                ),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const AmbulanceDetail(), // Pastikan widget ini sudah didefinisikan.
                    ),
                  );
                },
                child: _buildAmbulanceCard(
                  context,
                  nama: "Ambulans Siaga",
                  nomorTelepon: "0815-6789-0123",
                  nomorPlat: "E 3456 SA",
                  gambar: "images/ambulance1.png",
                  deskripsi: "Ambulans Standby Event untuk acara besar",
                  rating: 4.8,
                  review: 456,
                ),
              ),
              const SizedBox(height: 1),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const AmbulanceDetail2(), // Pastikan widget ini sudah didefinisikan.
                    ),
                  );
                },
                child:_buildAmbulanceCard(
                  context,
                  nama: "Ambulans Ramah",
                  nomorTelepon: "0817-8901-2345",
                  nomorPlat: "A 1122 AA",
                  gambar: "images/ambulance2.png",
                  deskripsi: "Ambulans pediatrik untuk anak-anak",
                  rating: 4.7,
                  review: 389,
                ),
              ),
              const SizedBox(height: 1),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const AmbulanceDetail3(), // Pastikan widget ini sudah didefinisikan.
                    ),
                  );
                },
                child:_buildAmbulanceCard(
                  context,
                  nama: "Ambulans Safety",
                  nomorTelepon: "0818-9012-3456",
                  nomorPlat: "H 3344 IS",
                  gambar: "images/ambulance3.png",
                  deskripsi: "Ambulans Kebidanan",
                  rating: 4.9,
                  review: 501,
                ),
              ),
              const SizedBox(height: 1),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const AmbulanceDetail4(), // Pastikan widget ini sudah didefinisikan.
                    ),
                  );
                },
                child:_buildAmbulanceCard(
                  context,
                  nama: "Ambulans Peduli A1",
                  nomorTelepon: "0814-5678-9012",
                  nomorPlat: "F 9012 PB",
                  gambar: "images/ambulance4.png",
                  deskripsi: "Ambulans Neonatal",
                  rating: 4.6,
                  review: 320,
                ),
              ),
              const SizedBox(height: 1),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const AmbulanceDetail5(), // Pastikan widget ini sudah didefinisikan.
                    ),
                  );
                },
                child:_buildAmbulanceCard(
                  context,
                  nama: "Ambulans Medical",
                  nomorTelepon: "0813-4567-8901",
                  nomorPlat: "D 5678 CM",
                  gambar: "images/ambulance5.png",
                  deskripsi: "Ambulans Transportasi Medis",
                  rating: 4.5,
                  review: 210,
                ),
              ),
              const SizedBox(height: 1),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const AmbulanceDetail6(), // Pastikan widget ini sudah didefinisikan.
                    ),
                  );
                },
                child:_buildAmbulanceCard(
                  context,
                  nama: "Ambulans Hero",
                  nomorTelepon: "0812-3456-7890",
                  nomorPlat: "B 1234 PS",
                  gambar: "images/ambulance6.png",
                  deskripsi: "Ambulans Gawat Darurat (AGD)",
                  rating: 4.8,
                  review: 532,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAmbulanceCard(
    BuildContext context, {
    required String nama,
    required String nomorTelepon,
    required String nomorPlat,
    required String gambar,
    required String deskripsi,
    required double rating,
    required int review,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              gambar,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      nama,
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF33302F),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          "Promo",
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFFF0000),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Image.asset(
                          "lib/icons/Promo1.png",
                          width: 20,
                          height: 20,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  nomorTelepon,
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF8A8A8A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  deskripsi,
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF8A8A8A),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Image.asset("lib/icons/Star.png"),
                    const SizedBox(width: 4),
                    Text(
                      "$rating",
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.yellow,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "($review Reviews)",
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF8A8A8A),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
