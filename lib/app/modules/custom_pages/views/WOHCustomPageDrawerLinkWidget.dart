// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/WOHCustomPageModel.dart';
import '../../../routes/WOHRoutes.dart';
import '../../global_widgets/WOHDrawerLinkWidget.dart';
import '../../root/controllers/WOHRootController.dart';

class WOHCustomPageDrawerLinkWidget extends GetView<WOHRootController> {
  const WOHCustomPageDrawerLinkWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.customPages.isEmpty) {
        return SizedBox();
      }
      return Column(
        children: List.generate(controller.customPages.length, (index) {
          var _page = controller.customPages.elementAt(index);
          return DrawerLinkWidget(
            icon: getDrawerLinkIcon(_page),
            text: _page.title,
            onTap: (e) async {
              //print(_page.id);
              await Get.offAndToNamed(WOHRoutes.CUSTOM_PAGES, arguments: _page);
            },
          );
        }),
      );
    });
  }

  IconData getDrawerLinkIcon(CustomPage _page) {
    switch (_page.id) {
      case '1':
        return Icons.privacy_tip_outlined;
      default:
        return Icons.article_outlined;
    }
  }
}