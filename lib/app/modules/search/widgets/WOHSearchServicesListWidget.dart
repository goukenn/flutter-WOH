// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/WOHEServiceModel.dart';
import '../../category/widgets/WOHServicesListItemWidget.dart';
import '../../global_widgets/WOHCircularLoadingWidget.dart';

class WOHSearchServicesListWidget extends StatelessWidget {
  final List<EService> services;

  WOHSearchServicesListWidget({Key key, List<EService> this.services}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (this.services.isEmpty) {
        return CircularLoadingWidget(height: 400);
      } else {
        return ListView.builder(
          padding: EdgeInsets.only(bottom: 10, top: 10),
          primary: false,
          shrinkWrap: true,
          itemCount: services.length,
          itemBuilder: ((_, index) {
            var _service = services.elementAt(index);
            return ServicesListItemWidget(service: _service);
          }),
        );
      }
    });
  }
}