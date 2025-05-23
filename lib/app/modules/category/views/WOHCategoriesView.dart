// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../../providers/WOHLaravelApiClientProvider.dart';
import '../../global_widgets/WOHCircularLoadingWidget.dart';
import '../controllers/WOHCategoriesController.dart';
import '../widgets/WOHCategoryGridItemWidget.dart';
import '../widgets/WOHCategoryListItemWidget.dart';

class WOHCategoriesView extends GetView<WOHCategoriesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Categories".tr,
            style: Get.textTheme.titleLarge,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: Get.theme.hintColor),
            onPressed: () => {Get.back()},
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            Get.find<WOHLaravelApiClientProvider>().forceRefresh();
            //controller.refreshCategories(showMessage: true);
            Get.find<WOHLaravelApiClientProvider>().unForceRefresh();
          },
          child: ListView(
            primary: true,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 10),
                child: Row(children: [
                  Expanded(
                    child: Text(
                      "Categories of services".tr,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          controller.layout.value = CategoriesLayout.LIST;
                        },
                        icon: Obx(() {
                          return Icon(
                            Icons.format_list_bulleted,
                            color: controller.layout.value == CategoriesLayout.LIST ? Get.theme.colorScheme.secondary : Get.theme.focusColor,
                          );
                        }),
                      ),
                      IconButton(
                        onPressed: () {
                          controller.layout.value = CategoriesLayout.GRID;
                        },
                        icon: Obx(() {
                          return Icon(
                            Icons.apps,
                            color: controller.layout.value == CategoriesLayout.GRID ? Get.theme.colorScheme.secondary : Get.theme.focusColor,
                          );
                        }),
                      )
                    ],
                  ),
                ]),
              ),
              Obx(() {
                return Offstage(
                  offstage: controller.layout.value != CategoriesLayout.GRID,
                  child: controller.categories.isEmpty
                      ? WOHCircularLoadingWidget(height: 400)
                      : MasonryGridView.count(
                          primary: false,
                          shrinkWrap: true,
                          crossAxisCount: MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 4,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          itemCount: controller.categories.length,
                          itemBuilder: (BuildContext context, int index) {
                            return WOHCategoryGridItemWidget(category: controller.categories.elementAt(index), heroTag: "heroTag");
                          },
                          mainAxisSpacing: 15.0,
                          crossAxisSpacing: 15.0,
                        ),
                );
              }),
              Obx(() {
                return Offstage(
                  offstage: controller.layout.value != CategoriesLayout.LIST,
                  child: controller.categories.isEmpty
                      ? WOHCircularLoadingWidget(height: 400)
                      : ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          primary: false,
                          itemCount: controller.categories.length,
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 10);
                          },
                          itemBuilder: (context, index) {
                            return WOHCategoryListItemWidget(
                              heroTag: 'category_list',
                              expanded: index == 0,
                              category: controller.categories.elementAt(index),
                            );
                          },
                        ),
                );
              }),
              // Container(
              //   child: ListView(
              //       primary: false,
              //       shrinkWrap: true,
              //       children: List.generate(controller.categories.length, (index) {
              //         return Obx(() {
              //           var _category = controller.categories.elementAt(index);
              //           return Padding(
              //             padding: const EdgeInsetsDirectional.only(start: 20),
              //             child: Text(_category.name),
              //           );
              //         });
              //       })),
              // ),
            ],
          ),
        ));
  }
}