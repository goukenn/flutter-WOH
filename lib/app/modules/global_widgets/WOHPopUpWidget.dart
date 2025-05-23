// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
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
  final Function onTap;

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