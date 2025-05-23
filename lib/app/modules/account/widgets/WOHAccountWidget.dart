// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
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