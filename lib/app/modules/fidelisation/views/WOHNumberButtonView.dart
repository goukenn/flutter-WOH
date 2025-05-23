
import 'package:flutter/material.dart';
import '../../../../WOHColorConstants.dart';


class WOHNumberButtonView extends StatelessWidget {
  final int number;
  final double size;
  final Color color;
  final String dot;
  final TextEditingController controller;

  const WOHNumberButtonView({
    super.key,
    this.number,
    required this.size,
    required this.color,
    required this.controller,
    this.dot
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          // primary: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(size / 2),
          ),
        ),
        onPressed: () {
          if(number != null) {
            controller.text += number.toString();
          }else {
            controller.text += dot.toString();
          }
        },
        child: Center(
          child: Text(
            number != null ?
            number.toString() : dot.toString(),
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: appColor, fontSize: 30),
          ),
        ),
      ),
    );
  }
}



