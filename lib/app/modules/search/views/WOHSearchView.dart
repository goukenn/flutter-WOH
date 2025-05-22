// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../WOHColorConstants.dart';
import '../../../../common/WOHUi.dart';
import '../../global_widgets/WOHFilterBottomSheetWidget.dart';
import '../controllers/WOHSearchController.dart';

class WOHSearchView extends GetView<SearchController> {
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
              color: Get.theme.focusColor.withOpacity(0.2),
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
                  style: Get.textTheme.bodyText2,
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
                  FilterBottomSheetWidget(),
                  isScrollControlled: true,
                );
              },
              child: Container(
                padding: const EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Get.theme.focusColor.withOpacity(0.1),
                ),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 4,
                  children: [
                    Text(
                      "Filter".tr,
                      style: Get.textTheme.bodyText2, //TextStyle(color: Get.theme.hintColor),
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