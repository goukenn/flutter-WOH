// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors, use_build_context_synchronously
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