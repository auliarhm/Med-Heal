import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DateSelect extends StatefulWidget {
  final String maintext;
  final String date;
  final Function(String maintext, String date)? onSelectDate;

  const DateSelect({
    super.key, 
    required this.date, 
    required this.maintext,
    this.onSelectDate,
    });

  @override
  _DateSelectState createState() => _DateSelectState();
}

class _DateSelectState extends State<DateSelect> {
  bool isSelected = false;

  void toggleSelection() {
    setState(() {
      isSelected = !isSelected;
      if (isSelected && widget.onSelectDate != null) {
        widget.onSelectDate!(widget.maintext, widget.date);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleSelection,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5), 
        child: Container(
          height: 60.sp, 
          width: 60.sp, 
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF40BEF0) : Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.black12),
          ),
          child: Center( 
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.maintext,
                  style: GoogleFonts.poppins(
                    fontSize: 15.sp,
                    color: isSelected ? Colors.white : Colors.black54,
                  ),
                ),
                Text(
                  widget.date,
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    color: isSelected
                        ? Colors.white
                        : const Color.fromARGB(255, 27, 27, 27),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}