import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical/auth.dart';
import 'package:medical/Screens/Login-Signup/login_register_page.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  Future<void> _logout(BuildContext context) async {
    try {
      await Auth().signOut(); // Memanggil fungsi logout dari auth.dart

      // Navigasi kembali ke halaman Login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } catch (e) {
      // Jika ada error saat logout
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saat logout: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Homepage',
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 64, 190, 240),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Selamat datang di Homepage!',
          style: GoogleFonts.poppins(fontSize: 18),
        ),
      ),
    );
  }
}
