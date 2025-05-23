// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../WOHColorConstants.dart';

class WOHPopUpPhotoWidget extends StatelessWidget {
  const WOHPopUpPhotoWidget({Key key,
    required this.cancel,
    required this.confirm,
    required this.onTap,
    required this.icon,
    required this.title,
    required this.url
  }) : super(key: key);

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