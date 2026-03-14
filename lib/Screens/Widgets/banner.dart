import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class banner extends StatelessWidget {
  const banner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.16,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 64, 190, 240),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 25),
                  Text(
                    "Perlindungan dini untuk\nkesehatan keluarga Anda",
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp, 
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8), // Jarak antara teks dan tombol
                  InkWell(
                    onTap: () {
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 8, 
                        horizontal: 16,
                      ), // Padding responsif
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 64, 190, 240),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.2,
              alignment: Alignment.bottomCenter,
              child: FittedBox(
                fit: BoxFit.cover,
                child: Image.asset("lib/icons/female.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
