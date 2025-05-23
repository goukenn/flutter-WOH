// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../WOHColorConstants.dart';

class WOHPopUpWidget extends StatelessWidget {
  const WOHPopUpWidget({super.key,
    required this.cancel,
    required this.confirm,
    required this.onTap,
    required this.icon,
    required this.title
  });

  final String cancel;
  final String confirm;
  final String title;
  final Widget icon;
  final VoidCallback?  onTap;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      icon: icon,
      content: Text(title, style: Get.textTheme.displayLarge!.merge(TextStyle(fontSize: 15, color: Colors.black))),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(onPressed: ()=>{
              Navigator.pop(context)
            },
                child: Text(cancel, style: TextStyle(color: inactive))),
            SizedBox(width: 10),
            TextButton(onPressed: onTap,
                child: Text(confirm, style: TextStyle(color: specialColor)))
          ],
        )
      ],
    );
  }
}