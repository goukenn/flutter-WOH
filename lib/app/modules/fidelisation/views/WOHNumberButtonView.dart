// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:flutter/material.dart';
import '../../../../WOHColorConstants.dart';


class WOHNumberButtonView extends StatelessWidget {
  final int? number;
  final double size;
  final Color color;
  final String? dot;
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
          controller.text += number.toString();
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