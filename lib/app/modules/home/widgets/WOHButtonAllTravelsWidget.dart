// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../color_constants.dart';

class ButtonAllTravelsWidget extends StatelessWidget implements PreferredSize {

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
                color: Get.theme.focusColor.withOpacity(0.2),
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
                style: Get.textTheme.headline4.merge(TextStyle(color: Colors.white)),
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