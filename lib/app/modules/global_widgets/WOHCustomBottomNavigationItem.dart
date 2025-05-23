import 'package:com_igkdev_new_app/WOHColorConstants.dart';
import 'package:flutter/material.dart';



class WOHCustomBottomNavigationItem {
  final IconData icon;
  final String label;
  final Color color;

  WOHCustomBottomNavigationItem({required this.icon, required this.label, this.color = primaryColor});
}