// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:flutter/material.dart';
 

// KeyPad widget
// This widget is reusable and its buttons are customizable (color, size)
class WOHNumPadView extends StatelessWidget {
  final double buttonSize;
  final Color buttonColor;
  final Color iconColor;
  final TextEditingController controller;
  final Function delete;
  final Function onSubmit;

  const WOHNumPadView({
    super.key,
    this.buttonSize = 50,
    this.buttonColor = Colors.white,
    this.iconColor = Colors.amber,
    required this.delete,
    required this.onSubmit,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // implement the number keys (from 0 to 9) with the OVHNumberButtonView widget
            // the OVHNumberButtonView widget is defined in the bottom of this file
            children: [
              OVHNumberButtonView(
                number: 1,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              OVHNumberButtonView(
                number: 2,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              OVHNumberButtonView(
                number: 3,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OVHNumberButtonView(
                number: 4,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              OVHNumberButtonView(
                number: 5,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              OVHNumberButtonView(
                number: 6,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OVHNumberButtonView(
                number: 7,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              OVHNumberButtonView(
                number: 8,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              OVHNumberButtonView(
                number: 9,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(width: 2),
              IconButton(
                onPressed: () => delete(),
                icon: Icon(
                  Icons.backspace,
                  color: iconColor,
                ),
                iconSize: 30,
              ),
              OVHNumberButtonView(
                number: 0,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              // this button is used to submit the entered value
              OVHNumberButtonView(
                dot: ".",
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
            ],
          ),
        ],
      ),
    );
  }
}