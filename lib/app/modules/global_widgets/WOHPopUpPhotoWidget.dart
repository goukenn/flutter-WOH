// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../WOHColorConstants.dart';

class WOHPopUpPhotoWidget extends StatelessWidget {
  const WOHPopUpPhotoWidget({super.key,
    required this.cancel,
    required this.confirm,
    required this.onTap,
    required this.icon,
    required this.title,
    required this.url
  });

  final String cancel;
  final String confirm;
  final String title;
  final Widget icon;
  final Function onTap;
  final String url;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      icon: icon,
      content: SizedBox(
          height: MediaQuery.of(context).size.height/4,
          child: Column(
              children: [
                Text(title, style: Get.textTheme.displayLarge!.merge(TextStyle(fontSize: 15))),
                Spacer(),
                Divider(color: Colors.black),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: CachedNetworkImage(
                    height: 100,
                    width: 140,
                    fit: BoxFit.cover,
                    imageUrl: url,
                    placeholder: (context, url) => Image.asset(
                      'assets/img/loading.gif',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 100,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error_outline),
                  ),
                ),

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
              ]
          )
      ),
    );
  }
}