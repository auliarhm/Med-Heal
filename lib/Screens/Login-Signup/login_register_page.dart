import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical/Screens/Login-Signup/registerpage.dart';
import 'package:medical/Screens/Views/Homepage.dart';
import 'package:medical/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  bool isEmailFocused = false;
  bool isPasswordFocused = false;

  Future<void> signInWithEmailAndPassword() async {
    if (!RegExp(r'^\d{6}$').hasMatch(_controllerPassword.text)) {
      setState(() {
        errorMessage = 'Password harus terdiri dari 6 digit angka.';
      });
      return;
    }

    try {
      await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Homepage()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        if (e.code == 'user-not-found') {
          errorMessage = "Anda belum memiliki akun. Silakan daftar.";
        } else {
          errorMessage = e.message;
        }
      });
    }
  }

  Widget _entryField(String title, TextEditingController controller, bool isPassword, bool isFocused) {
    return Focus(
      onFocusChange: (focus) {
        setState(() {
          if (isPassword) {
            isPasswordFocused = focus;
          } else {
            isEmailFocused = focus;
          }
        });
      },
      child: TextField(
        obscureText: isPassword,
        controller: controller,
        keyboardType: isPassword ? TextInputType.number : TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: title,
          labelStyle: GoogleFonts.poppins(color: Colors.blueAccent, fontSize: 16),
          hintText: isFocused
              ? (isPassword
                  ? 'Masukkan password Anda.'
                  : 'Masukkan alamat email yang valid.')
              : null,
          hintStyle: GoogleFonts.poppins(fontSize: 14, color: Colors.black54),
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
        style: GoogleFonts.poppins(fontSize: 16, color: Colors.black87),
      ),
    );
  }

  Widget _errorMessage() {
    return Text(
      errorMessage == '' ? '' : '⚠️ $errorMessage',
      style: GoogleFonts.poppins(color: Colors.red, fontSize: 14),
    );
  }

  Widget _loginButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 64, 190, 240),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        shadowColor: Colors.black.withOpacity(0.2),
        elevation: 10,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
      ),
      onPressed: signInWithEmailAndPassword,
      child: Text(
        "Login",
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _registerNavigation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Belum punya akun? ",
          style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RegisterPage()),
            );
          },
          child: Text(
            'Register',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: const Color.fromARGB(255, 64, 190, 240),
             
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
                      image: AssetImage('images/Logo RS sentosa.png'),
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
                Text(
                  '',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 5,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 30),

                // Form Input Email dan Password
                _entryField('Email', _controllerEmail, false, isEmailFocused),
                const SizedBox(height: 20),
                _entryField('Password', _controllerPassword, true, isPasswordFocused),
                const SizedBox(height: 10),
                _errorMessage(),
                const SizedBox(height: 20),

                // Tombol Login
                _loginButton(),
                const SizedBox(height: 20),

                // Navigasi ke Register
                _registerNavigation(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
