// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../WOHColorConstants.dart';

class WOHButtonAllTravelsWidget extends StatelessWidget implements PreferredSize {

  Widget buildButtonWidget() {
    return GestureDetector(
      onTap: () =>{ },
      child: Container(
          height: 50,
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 16),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          decoration: BoxDecoration(
              color: interfaceColor,
              border: Border.all(
                color: Get.theme.focusColor.withAlpha((255 * 0.2).toInt()),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(1.0, 1.0), //(x,y)
                  blurRadius: 3.0,
                ),
              ],
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 12, left: 10),
                child: FaIcon(FontAwesomeIcons.planeDeparture, color: Colors.white),
              ),
              Text(
                "View available Travels".tr,
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.fade,
                style: Get.textTheme.headlineMedium!.merge(TextStyle(color: Colors.white)),
              ),
            ],
          )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildButtonWidget();
  }

  @override
  Widget get child => buildButtonWidget();

  @override
  Size get preferredSize => new Size(Get.width, 80);
}