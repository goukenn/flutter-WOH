// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../WOHColorConstants.dart';
import '../../../main.dart';
import '../account/widgets/WOHAccountLinkWidget.dart';

class WOHUserWidget extends StatelessWidget {
  const WOHUserWidget({super.key,
    required this.user,
    this.selected,
    required this.imageUrl});

  final String user;
  final bool selected;
  final String imageUrl;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
        decoration: BoxDecoration(
            border: selected ? Border.all(color: interfaceColor,width: 2) : null,
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
      padding: EdgeInsets.all(10),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipOval(
                child: FadeInImage(
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    image: NetworkImage(this.imageUrl, headers: WOHConstants.getTokenHeaders()),
                    placeholder: AssetImage(
                        "assets/img/loading.gif"),
                    imageErrorBuilder:
                        (context, error, stackTrace) {
                      return Image.asset(
                          "assets/img/téléchargement (1).png",
                          width: 50,
                          height: 50,
                          fit: BoxFit.fitWidth);
                    }
                )
            ),
            SizedBox(width: 20),
            SizedBox(
                height: 40,
                width: Get.width/2.5,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Text(user, style: Get.textTheme.headlineMedium!.merge(TextStyle(fontSize: 13, color: buttonColor)), overflow: TextOverflow.ellipsis,)
                      )
                    ]
                )
            )
          ]
      )
    );
  }
}