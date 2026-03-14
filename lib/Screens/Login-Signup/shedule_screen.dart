import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical/Screens/Views/appointment_screen.dart';
import 'package:medical/Screens/Views/appointment2_screen.dart';
import 'package:medical/Screens/Views/appointment3_screen.dart';
import 'package:medical/Screens/Views/appointment4_screen.dart';
import 'package:medical/Screens/Views/Homepage.dart';
import 'package:page_transition/page_transition.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<QueryDocumentSnapshot>> _getAllAppointments() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('datas').get();
      return querySnapshot.docs;
    } catch (e) {
      print("Error getting appointments: $e");
      return [];
    }
  }

  Future<List<QueryDocumentSnapshot>> _getUpcomingAppointments() async {
    try {
      DateTime now = DateTime.now();
      QuerySnapshot querySnapshot = await _firestore
          .collection('datas')
          .where('tanggal', isGreaterThan: now.toIso8601String())
          .get();
      return querySnapshot.docs;
    } catch (e) {
      return [];
    }
  }

  Future<List<QueryDocumentSnapshot>> _getPastAppointments() async {
    try {
      DateTime now = DateTime.now();
      QuerySnapshot querySnapshot = await _firestore
          .collection('datas')
          .where('tanggal', isLessThan: now.toIso8601String())
          .get();
      return querySnapshot.docs;
    } catch (e) {
      return [];
    }
  }

  void _navigateToDetail(BuildContext context, QueryDocumentSnapshot appointment) {
    final doctor = appointment['dokter'];
    if (doctor == "Dr. Adik N") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Appointment(
            selectedDate: appointment['tanggal'],
            selectedDay: appointment['hari'],
            selectedTime: appointment['jam'],
          ),
        ),
      );
    } else if (doctor == "Dr. Sheila N") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Appointment2(
            selectedDate: appointment['tanggal'],
            selectedDay: appointment['hari'],
            selectedTime: appointment['jam'],
          ),
        ),
      );
    } else if (doctor == "Dr. Annisa A") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Appointment3(
            selectedDate: appointment['tanggal'],
            selectedDay: appointment['hari'],
            selectedTime: appointment['jam'],
          ),
        ),
      );
    } else if (doctor == "Dr. Dian F") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Appointment4(
            selectedDate: appointment['tanggal'],
            selectedDay: appointment['hari'],
            selectedTime: appointment['jam'],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(

        leading: IconButton(
          icon: SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.06,
            child: Image.asset("lib/icons/back2.png"),
          ),
          onPressed: (){

            Navigator.pushReplacement(
              context,
              PageTransition(
              type: PageTransitionType.rightToLeft,
              child: const Homepage()));
          },
        ),

        title: Text(
          "Jadwal Pemeriksaan",
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 248, 249, 250),
        elevation: 0,
        toolbarHeight: 80,
        centerTitle: true,
      ),
      body: FutureBuilder<List<QueryDocumentSnapshot>>(
        future: _getAllAppointments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada data tersedia.'));
          }

          final appointments = snapshot.data!;
          return DefaultTabController(
            length: 3,
            child: Column(
              children: [
                const TabBar(
                  indicatorColor: Color(0xFF40bef0),
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(text: "Semua"),
                    Tab(text: "Mendatang"),
                    Tab(text: "Selesai"),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      _buildAppointmentList(appointments),
                      FutureBuilder<List<QueryDocumentSnapshot>>(
                        future: _getUpcomingAppointments(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          }
                          final upcomingAppointments = snapshot.data ?? [];
                          return _buildAppointmentList(upcomingAppointments);
                        },
                      ),
                      FutureBuilder<List<QueryDocumentSnapshot>>(
                        future: _getPastAppointments(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          }
                          final pastAppointments = snapshot.data ?? [];
                          return _buildAppointmentList(pastAppointments);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppointmentList(List<QueryDocumentSnapshot> appointments) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final appointment = appointments[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appointment['dokter'] ?? 'Nama Dokter Tidak Ada',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Hari: ${appointment['hari'] ?? '-'}',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                      Text(
                        'Jam: ${appointment['jam'] ?? '-'}',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Keluhan: ${appointment['keluhan'] ?? '-'}',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _navigateToDetail(context, appointment);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF40bef0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        ),
                        child: Text(
                          'Lihat Detail',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
