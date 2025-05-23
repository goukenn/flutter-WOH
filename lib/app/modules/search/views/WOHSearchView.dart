// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../WOHColorConstants.dart';
import '../../../../common/WOHUi.dart';
import '../../global_widgets/WOHFilterBottomSheetWidget.dart';
import '../controllers/WOHSearchController.dart';

class WOHSearchView extends GetView<WOHSearchController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search".tr,
          style: context.textTheme.titleLarge,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Get.theme.hintColor),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
      ),
      body: ListView(
        children: [
          buildSearchBar(),
          Container(
              height: MediaQuery.of(context).size.height/1.2,
              decoration: WOHUi.getBoxDecoration(color: backgroundColor),
              child: Column(
                children: [
                  Expanded(
                      child: Obx(()=>
                          ListView.separated(
                              physics: AlwaysScrollableScrollPhysics(),
                              itemCount: controller.items.value.length,
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 5);
                              },
                              shrinkWrap: true,
                              primary: false,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  child: Card(
                                    child: Container(
                                        padding: EdgeInsets.all(30),
                                        child: ListTile(
                                          title: Text(controller.items.value[index]['name']),
                                          subtitle: Text(controller.items.value[index]['country']),
                                        )
                                    ),
                                  ),
                                );
                              })
                      )
                  )
                ],
              )
          )
        ],
      ),
    );
  }

  Widget buildSearchBar() {
    return Hero(
      tag: Get.arguments ?? '',
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 16),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
        decoration: BoxDecoration(
            color: Get.theme.primaryColor,
            border: Border.all(
              color: Get.theme.focusColor.withAlpha((255 * 0.2).toInt()),
            ),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 12, left: 0),
              child: Icon(Icons.search, color: Get.theme.colorScheme.secondary),
            ),
            Expanded(
              child: Material(
                color: Get.theme.primaryColor,
                child: TextField(
                  controller: controller.textEditingController,
                  style: Get.textTheme.bodyMedium,
                  onChanged: (value)=>{
                    controller.filterSearchResults(value)
                  },
                  autofocus: true,
                  cursorColor: Get.theme.focusColor,
                  decoration: WOHUi.getInputDecoration(hintText: "Search for home service...".tr),
                ),
              ),
            ),
            SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                Get.bottomSheet(
                  WOHFilterBottomSheetWidget(),
                  isScrollControlled: true,
                );
              },
              child: Container(
                padding: const EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Get.theme.focusColor.withAlpha((255 * 0.1).toInt()),
                ),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 4,
                  children: [
                    Text(
                      "Filter".tr,
                      style: Get.textTheme.bodyMedium, //TextStyle(color: Get.theme.hintColor),
                    ),
                    Icon(
                      Icons.filter_list,
                      color: Get.theme.hintColor,
                      size: 21,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}