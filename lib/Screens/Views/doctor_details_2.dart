import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical/Screens/Views/appointment.dart';
import 'package:medical/Screens/Widgets/date_select.dart';
import 'package:medical/Screens/Widgets/doctorList.dart';
import 'package:medical/Screens/Widgets/time_select.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DoctorDetails2 extends StatefulWidget {
  const DoctorDetails2({super.key});

  @override
  _DoctorDetails2State createState() => _DoctorDetails2State();
}

class _DoctorDetails2State extends State<DoctorDetails2> {
  bool showExtendedText = false;
  List<String> dates = [];
  List<String> days = [];
  String selectedDate = "";
  String selectedDay = "";
  String selectedTime = "";

  @override
  void initState() {
    super.initState();
    _initializeDates();
  }

  void _initializeDates() {
    DateTime now = DateTime.now();
    for (int i = 0; i < 7; i++) {
      DateTime date = now.add(Duration(days: i));
      dates.add(date.day.toString());
      days.add(_getDayName(date.weekday));
    }
  }
  void onSelectDate(String maintext, String date) {
    setState(() {
      selectedDate = date;
      selectedDay = maintext;
    });
  }

  void onSelectTime(String mainText) {
    setState(() {
      selectedTime = mainText;
    });
  }

  String _getDayName(int weekday) {
    switch (weekday) {
      case 1: return "Senin";
      case 2: return "Selasa";
      case 3: return "Rabu";
      case 4: return "Kamis";
      case 5: return "Jumat";
      case 6: return "Sabtu";
      case 7: return "Minggu";
      default: return "";
    }
  }
  void toggleTextVisibility() {
    setState(() {
      showExtendedText = !showExtendedText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
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
            "Informasi Dokter",
            style: GoogleFonts.poppins(color: Colors.black, fontSize: 18.sp),
          ),
          centerTitle: true,
          elevation: 0,
          toolbarHeight: 100,
          backgroundColor: Colors.white,
        ),

        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                const doctorList(
                  image: "lib/icons/adek.png",
                  maintext: "Dr. Adik N",
                  numRating: "4.8",
                  subtext: "Spesialis Kandungan",
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: toggleTextVisibility,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tentang Dokter",
                          style: GoogleFonts.poppins(
                              fontSize: 15.sp, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          showExtendedText
                              ? "Dr. Adik N adalah seorang spesialis kandungan berpengalaman yang telah menangani berbagai keluhan kandungan. Beliau menyelesaikan pendidikan spesialis di Stanford University dan memiliki pengalaman klinis selama lebih dari 5 tahun."
                              : "Dr. Adik N adalah seorang spesialis kandungan berpengalaman yang telah menangani berbagai keluhan kandungan... ",
                          style: GoogleFonts.poppins(
                            color: const Color.fromARGB(255, 37, 37, 37),
                            fontSize: 14.sp,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          showExtendedText ? "Read less" : "Read more",
                          style: TextStyle(
                            color: showExtendedText
                                ? const Color(0xFF40BEF0)
                                : const Color(0xFF40BEF0), // Change color based on visibility
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.11,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: dates.length,
                      itemBuilder: (context, index) {
                        return DateSelect(
                          date: dates[index], 
                          maintext: days[index],
                          onSelectDate: onSelectDate,
                        );
                      },
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    color: Colors.black12,
                    thickness: 1,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2400,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2500,
                        width: MediaQuery.of(context).size.width * 0.2900,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              time_select(mainText: "08:00 AM", onSelectTime: onSelectTime),
                              time_select(mainText: "09:00 AM", onSelectTime: onSelectTime),
                              time_select(mainText: "10:00 AM", onSelectTime: onSelectTime),
                              time_select(mainText: "11:00 AM", onSelectTime: onSelectTime),
                            ]
                          ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2500,
                        width: MediaQuery.of(context).size.width * 0.2500,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              time_select(mainText: "13:00 PM", onSelectTime: onSelectTime),
                               time_select(mainText: "14:00 PM", onSelectTime: onSelectTime),
                               time_select(mainText: "15:00 PM", onSelectTime: onSelectTime),
                               time_select(mainText: "16:00 PM", onSelectTime: onSelectTime),
                            ]),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2500,
                        width: MediaQuery.of(context).size.width * 0.2500,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            time_select(mainText: "19:00 PM", onSelectTime: onSelectTime),
                            time_select(mainText: "20:00 PM", onSelectTime: onSelectTime),
                            time_select(mainText: "21:00 PM", onSelectTime: onSelectTime),
                            time_select(mainText: "21:30 PM", onSelectTime: onSelectTime),
                          ]
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 80,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (selectedDate.isNotEmpty && selectedDay.isNotEmpty) {
                            Navigator.pushReplacement(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: Appointment(
                                  selectedDate: selectedDate,
                                  selectedDay: selectedDay,
                                  selectedTime: selectedTime,
                                ),
                              ),
                            );
                          }else {
                            // Tampilkan pesan jika tanggal atau waktu belum dipilih
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Silakan pilih tanggal dan waktu")),
                            );
                          }
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.6300,
                          decoration: BoxDecoration(
                            color: const Color(0xFF40BEF0),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Jadwalkan Pemeriksaan",
                                  style: GoogleFonts.poppins(
                                    fontSize: 15.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500
                                  ),
                                )
                              ]
                            ),
                        ),
                      ),
                    ]
                  ),
              ),
            ),
          ],
        )
      );
  }
}


