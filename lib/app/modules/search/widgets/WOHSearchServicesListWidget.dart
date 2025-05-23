// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/WOHEServiceModel.dart';
import '../../category/widgets/WOHServicesListItemWidget.dart';
import '../../global_widgets/WOHCircularLoadingWidget.dart';

class WOHSearchServicesListWidget extends StatelessWidget {
  final List<WOHEServiceModel> services;

  WOHSearchServicesListWidget({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (this.services.isEmpty) {
        return WOHCircularLoadingWidget(height: 400);
      } else {
        return ListView.builder(
          padding: EdgeInsets.only(bottom: 10, top: 10),
          primary: false,
          shrinkWrap: true,
          itemCount: services.length,
          itemBuilder: ((_, index) {
            var _service = services.elementAt(index);
            return WOHServicesListItemWidget(service: _service);
          }),
        );
      }
    });
  }
}