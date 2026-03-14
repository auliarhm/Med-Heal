import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical/Screens/Login-Signup/shedule_screen.dart';
import 'package:medical/Screens/Widgets/doctorList.dart';
import 'package:page_transition/page_transition.dart';
import 'Homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Appointment2 extends StatefulWidget {
  final String selectedDate;
  final String selectedDay;
  final String selectedTime;

  const Appointment2({
    Key? key,
    required this.selectedDate,
    required this.selectedDay,
    required this.selectedTime,
  }) : super(key: key);

  @override
  _Appointment2State createState() => _Appointment2State();
}

class _Appointment2State extends State<Appointment2> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _sendData() async {
    
    final User? user = FirebaseAuth.instance.currentUser;
    try {
      final data = {
        'email': user?.email ?? 'user@example.com', // Ganti dengan email pengguna
        'dokter': 'Dr. Sheila N',
        'hari': widget.selectedDay,
        'tanggal': widget.selectedDate,
        'keluhan': 'Periksa/Konsultasi Saraf',
        'jam': widget.selectedTime,
      };

      await _firestore.collection('datas').add(data);

      // Tampilkan Snackbar jika berhasil
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data berhasil dikirimkan!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigasi ke halaman utama
      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: const Homepage(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan saat mengirim data: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 1,
        ),
      ),
    );
  }

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
                type: PageTransitionType.fade,
                child: const ScheduleScreen(),
              ),
            );
          },
          child: Image.asset("lib/icons/back1.png"),
        ),
        title: Text(
          "Jadwal Pemeriksaan",
          style: GoogleFonts.poppins(color: Colors.black, fontSize: 18),
        ),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 100,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            const doctorList(
              image: "lib/icons/cela.png",
              maintext: "Dr. Sheila N",
              numRating: "4.9",
              subtext: "Spesialis Saraf",
            ),
            const SizedBox(height: 10),
            _buildSectionTitle("Tanggal"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Image.asset(
                    "lib/icons/callender.png",
                    height: 40,
                    width: 40,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "${widget.selectedDate}, ${widget.selectedDay} pukul ${widget.selectedTime}",
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle("Keluhan"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Image.asset(
                    "lib/icons/pencil.png",
                    height: 40,
                    width: 40,
                  ),
                  const SizedBox(width: 10),
                  const Text("Periksa/Konsultasi Saraf"),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle("Detail Pembayaran"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildPaymentRow("Pemeriksaan/Konsultasi", "Rp. 650.000"),
                  _buildPaymentRow("Biaya Pelayanan", "Rp. 50.000"),
                  const Divider(),
                  _buildPaymentRow("Total", "Rp. 700.000",
                      totalStyle: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF40BEF0),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Metode pembayaran dilakukan langsung di meja pelayanan lantai 1, RS Sentosa.",
              ),
            ),
            
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentRow(String label, String value, {TextStyle? totalStyle}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.poppins(fontSize: 15)),
          Text(value, style: totalStyle ?? GoogleFonts.poppins(fontSize: 16)),
        ],
      ),
    );
  }
}
