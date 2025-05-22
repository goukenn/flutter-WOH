// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../providers/laravel_provider.dart';
import '../controllers/WOHEServicesController.dart';
import 'WOHServicesEmptyListWidget.dart';
import 'WOHServicesListItemWidget.dart';
import 'WOHServicesListLoaderWidget.dart';

class WOHServicesListWidget extends GetView<EServicesController> {
  WOHServicesListWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (Get.find<LaravelApiClient>().isLoading(tasks: [
            'getEProviderEServices',
            'getEProviderPopularEServices',
            'getEProviderMostRatedEServices',
            'getEProviderAvailableEServices',
            'getEProviderFeaturedEServices'
          ]) &&
          controller.page == 1) {
        return ServicesListLoaderWidget();
      } else if (controller.eServices.isEmpty) {
        return ServicesEmptyListWidget();
      } else {
        return ListView.builder(
          padding: EdgeInsets.only(bottom: 10, top: 10),
          primary: false,
          shrinkWrap: true,
          itemCount: controller.eServices.length + 1,
          itemBuilder: ((_, index) {
            if (index == controller.eServices.length) {
              return Obx(() {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Center(
                    child: new Opacity(
                      opacity: controller.isLoading.value ? 1 : 0,
                      child: new CircularProgressIndicator(),
                    ),
                  ),
                );
              });
            } else {
              var _service = controller.eServices.elementAt(index);
              return ServicesListItemWidget(service: _service);
            }
          }),
        );
      }
    });
  }
}