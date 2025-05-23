// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../WOHColorConstants.dart';
import '../../../main.dart';
import '../account/widgets/WOHAccountLinkWidget.dart';

class WOHUserWidget extends StatelessWidget {
  const WOHUserWidget({Key key,
    required this.user,
    this.selected,
    required this.imageUrl}) : super(key: key);

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
                          child: Text(user, style: Get.textTheme.headline4!.merge(TextStyle(fontSize: 13, color: buttonColor)), overflow: TextOverflow.ellipsis,)
                      )
                    ]
                )
            )
          ]
      )
    );
  }
}