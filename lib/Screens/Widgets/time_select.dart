import 'package:flutter/material.dart';

class time_select extends StatefulWidget {
  final String mainText;
  final Function(String mainText)? onSelectTime;

  const time_select({super.key, required this.mainText, this.onSelectTime});

  @override
  _time_selectState createState() => _time_selectState();
}

class _time_selectState extends State<time_select> {
  bool isSelected = false;

  void toggleSelection() {
    setState(() {
      isSelected = !isSelected;
      if (isSelected && widget.onSelectTime != null) {
        widget.onSelectTime!(widget.mainText);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleSelection,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.width * 0.2700,
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF40BEF0)
              : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.mainText,
              style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : const Color.fromARGB(255, 85, 85, 85),
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
