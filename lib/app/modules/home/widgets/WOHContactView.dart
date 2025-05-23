// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/WOHHomeController.dart';

class WOHContactView extends GetWidget<WOHHomeController> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: AlertDialog(
        title: Text('Vous souhaitez conatcter le service WillOnHair au +97798345348734', style: Get.textTheme.headlineMedium),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: ()=> Navigator.pop(context),
                  child: Text('Annuler', style: Get.textTheme.displayMedium!.merge(TextStyle(color: Colors.grey)))
              ),
              TextButton(
                  onPressed: () async{
                    Uri phone = Uri.parse('tel:+97798345348734');

                    if (await launchUrl(phone)) {
                      Navigator.pop(context);
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child: Text('contacter', style: Get.textTheme.displayMedium)
              )
            ],
          )
        ],
      ),
    );
  }
}