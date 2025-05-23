import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../WOHColorConstants.dart';

class WOHAccountWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final String label;
  final Color labelColor;
  final Color textColor;

  const WOHAccountWidget({super.key,  
    required this.icon,
    this.text = '',
    this.label = '',
    required this.labelColor,
    required this.textColor
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      child: Row(
        children: [
          SizedBox(
            width: 30,
            child: Icon( icon,color: buttonColor, size: 18),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            width: 1,
            height: 24,
            color: Get.theme.focusColor.withAlpha((255 * 0.3).toInt()),
          ),
          Expanded(
            child: Text(text, style: TextStyle(color: textColor))
          ),
          Text(label, style: TextStyle(color: labelColor))
        ],
      ),
    );
  }
}