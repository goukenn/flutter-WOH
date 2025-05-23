// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../providers/WOHLaravelApiClientProvider.dart';
import '../../category/widgets/WOHServicesEmptyListWidget.dart';
import '../../category/widgets/WOHServicesListItemWidget.dart';
import '../../category/widgets/WOHServicesListLoaderWidget.dart';
import '../controllers/WOHEServicesController.dart';

class WOHServicesListWidget extends GetView<WOHEServicesController> {
  WOHServicesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (Get.find<WOHLaravelApiClientProvider>().isLoading(task:'', tasks: [
            'getEProviderEServices',
            'getEProviderPopularEServices',
            'getEProviderMostRatedEServices',
            'getEProviderAvailableEServices',
            'getEProviderFeaturedEServices'
          ]) &&
          controller.page.value == 1) {
        return WOHServicesListLoaderWidget();
      } else if (controller.eServices.isEmpty) {
        return WOHServicesEmptyListWidget();
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
              return WOHServicesListItemWidget(service: _service);
            }
          }),
        );
      }
    });
  }
}