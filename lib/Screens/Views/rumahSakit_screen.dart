import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RumahSakitScreen extends StatefulWidget {
  const RumahSakitScreen({Key? key}) : super(key: key);

  @override
  _RumahSakitScreenState createState() => _RumahSakitScreenState();
}

class _RumahSakitScreenState extends State<RumahSakitScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _autoSlide();
  }

  void _autoSlide() {
    Future.delayed(const Duration(seconds: 3), () {
      if (_pageController.hasClients) {
        setState(() {
          _currentPage = (_currentPage + 1) % 5;
        });
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        _autoSlide();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return Scaffold(
          backgroundColor: Colors.white,
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
            title: Text(
              "Rumah Sakit Sentosa",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Carousel
                Stack(
                  children: [
                    Container(
                      height: 300,
                      width: double.infinity,
                      color: Colors.white,
                      child: PageView(
                        controller: _pageController,
                        children: List.generate(5, (index) {
                          return Image.asset(
                            "images/rumah sakit${index + 1}.png",
                            fit: BoxFit.cover,
                          );
                        }),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      left: MediaQuery.of(context).size.width * 0.4,
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: 5,
                        effect: const ExpandingDotsEffect(
                          activeDotColor: Colors.blue,
                          dotHeight: 8,
                          dotWidth: 8,
                          spacing: 4,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3.h),

                // Hospital Info
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Rumah Sakit Sentosa",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            child: Image.asset("lib/icons/logo rs sentosa.png"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Image.asset("lib/icons/maps.png"),
                          SizedBox(width: 1.w),
                          Text(
                            "Jl. Sentosa, Surakarta",
                            style: GoogleFonts.poppins(fontSize: 14.sp),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Rumah sakit terkemuka dengan fasilitas kesehatan modern yang menyediakan layanan medis berkualitas dengan berbagai spesialisasi.",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 2.h),

                      // Rating Section
                      Row(
                        children: [
                          Image.asset("lib/icons/Star.png"),
                          const SizedBox(width: 4),
                          Text(
                            "4.9 (4097 Reviews)",
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3.h),

                      // Statistics
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: _buildStatItem(
                                "1500", "Kamar Rawat Inap", "lib/icons/rawat inap.png"),
                          ),
                          SizedBox(width: 1.w),
                          Expanded(
                            child: _buildStatItem(
                                "270", "Ruang Operasi", "lib/icons/suntik.png"),
                          ),
                          SizedBox(width: 1.w),
                          Expanded(
                            child: _buildStatItem(
                                "110", "Ruang Kamar ICU", "lib/icons/darah.png"),
                          ),
                          SizedBox(width: 1.w),
                          Expanded(
                            child: _buildStatItem(
                                "55", "Ruang Kamar NICU", "lib/icons/obat.png"),
                          ),
                        ],
                      ),
                      SizedBox(height: 3.h),

                      // Kelebihan
                      Text(
                        "Kelebihan:",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildBulletPoint(
                              "Dilengkapi ruang operasi canggih, laboratorium diagnostik, dan layanan radiologi terkini."),
                          _buildBulletPoint(
                              "Menyediakan layanan UGD, farmasi, dan konsultasi dokter spesialis secara nonstop."),
                          _buildBulletPoint(
                              "Didukung oleh tenaga medis profesional dan teknologi kesehatan terkini."),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatItem(String value, String label, String iconPath) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconPath,
            width: 7.w,
            height: 7.w,
          ),
          SizedBox(height: 1.h),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(fontSize: 12.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "• ",
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
