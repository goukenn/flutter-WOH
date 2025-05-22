// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable, prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';
import 'package:get/get.dart'; 

import '../../../WOHColorConstants.dart';
import 'WOHTrianglePainter.dart';

class WOHBannerWidget extends StatelessWidget {
  final Color color;
  final double size;
  final Widget child;
  final String title;
  final double iconSize;
  final Color iconColor;

  WOHBannerWidget({super.key, 
    this.color = validateColor,
    this.size = 80,
    required this.child,
    this.iconSize = 24,
    required this.title,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(
          top: 0,
          right: 0,
          child: CustomPaint(
            painter: WOHTrianglePainter(color),
            size: Size(size, size),
          ),
        ),
        Positioned(
          top: 15,
          right: 0,
          child: Transform.rotate(
            angle: 120,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                title,
                style: Get.textTheme.displayMedium!.merge(
                  TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
