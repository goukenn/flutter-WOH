// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
/*
 * Copyright (c) 2020 .
 */

import 'package:flutter/material.dart'; 
import 'package:get/get.dart';

import '../../../../WOHColorConstants.dart';
import '../../global_widgets/WOHTextFieldWidget.dart';

class WOHAccountLinkWidget extends StatelessWidget {
  final IconData? icon;
  final String text;
  final String label;
  final bool edit;
  final ValueChanged<String> onChange;

  const WOHAccountLinkWidget({super.key,  
    this.icon,
    this.text = '',
    this.label = '',
    required this.edit,
    required this.onChange
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: !edit ?
        Row(
          children: [
            Icon(icon, color: appColor),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              width: 1,
              height: 24,
              color: Get.theme.focusColor.withAlpha((255 * 0.3).toInt()),
            ),
            SizedBox(
              width: Get.width/1.5,
              child: RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    children: [
                      TextSpan(text: text, style: Get.textTheme.displayLarge!.merge(TextStyle(fontSize: 12, color: appColor))),
                      TextSpan(text: "\n$label",
                          style: Get.textTheme.displayMedium!.merge(TextStyle(color: Colors.black, fontSize: 14))
                      )
                    ]
                  )
              )
            )
          ]
        ) :
        WOHTextFieldWidget(
          labelText: text,
          isFirst: false,
          isLast: false,
          hintText: "John Doe",
          readOnly: false,
          initialValue: label,
          //onSaved: (input) => controller.currentUser.value.password = input,
          onChanged: onChange,
          validator: (input) => input!.length < 3 ? "Should be more than 3 characters" : null,
          iconData: icon!,
          keyboardType: TextInputType.text,
        )
      ),
    );
  }
}