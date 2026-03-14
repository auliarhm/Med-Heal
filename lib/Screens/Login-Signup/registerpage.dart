import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical/auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? errorMessage = '';

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  // Fungsi untuk register dengan email dan password
  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);

      // Jika registrasi berhasil, kembali ke halaman login
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _entryField(String title, String hint, TextEditingController controller, bool isPassword) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          obscureText: isPassword,
          controller: controller,
          decoration: InputDecoration(
            labelText: title,
            labelStyle: const TextStyle(color: Colors.blueAccent),
            hintText: hint, // Tambahkan hint text di sini
            hintStyle: const TextStyle(color: Colors.grey),
            filled: true,
            fillColor: Colors.blue[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: Colors.blueAccent, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0),
            ),
          ),
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ],
    );
  }

  Widget _errorMessage() {
    return Text(
      errorMessage == '' ? '' : '⚠️ $errorMessage',
      style: const TextStyle(color: Colors.red, fontSize: 14),
    );
  }

  Widget _registerButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 64, 190, 240),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        shadowColor: Colors.black.withOpacity(0.2),
        elevation: 10,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
      ),
      onPressed: createUserWithEmailAndPassword,
      child: const Text(
        'Register',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Widget _alreadyHaveAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Sudah punya akun? ',
          style: TextStyle(fontSize: 14, color: Colors.black54),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Login',
            style: TextStyle(
              fontSize: 14,
              color: Color.fromARGB(255, 64, 190, 240),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo Rumah Sakit
                Container(
                  height: 120,
                  width: 120,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/Logo RS sentosa.png'), // Masukkan path logo Anda di sini
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Teks Selamat Datang
               Text(
                  'Healthcare',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),

                  Text(
                  'Rumah Sakit Sentosa',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                
                const Text(
                  '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 5,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 30),

                // Form Input
                _entryField('Email', 'Masukkan email Anda', _controllerEmail, false),
                const SizedBox(height: 20),
                _entryField('Password', 'Masukkan password (6 digit angka).', _controllerPassword, true),
                const SizedBox(height: 10),
                _errorMessage(),
                const SizedBox(height: 20),

                // Tombol Register
                _registerButton(),
                const SizedBox(height: 20),

                // Navigasi ke Login
                _alreadyHaveAccount(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
