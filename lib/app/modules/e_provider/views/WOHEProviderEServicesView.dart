// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../providers/WOHLaravelApiClientProvider.dart';
import '../../global_widgets/WOHHomeSearchBarWidget.dart';
import '../controllers/WOHEServicesController.dart';
import '../widgets/WOHServicesListWidget.dart';

class WOHEProviderEServicesView extends GetView<EServicesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          if (!Get.find<WOHLaravelApiClientProvider>().isLoading(tasks: [
            'getEProviderEServices',
            'getEProviderPopularEServices',
            'getEProviderMostRatedEServices',
            'getEProviderAvailableEServices',
            'getEProviderFeaturedEServices'
          ])) {
            Get.find<WOHLaravelApiClientProvider>().forceRefresh();
            controller.refreshEServices(showMessage: true);
            Get.find<WOHLaravelApiClientProvider>().unForceRefresh();
          }
        },
        child: CustomScrollView(
          controller: controller.scrollController,
          shrinkWrap: false,
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Get.theme.scaffoldBackgroundColor,
              expandedHeight: 140,
              elevation: 0.5,
              primary: true,
              pinned: false,
              // collapsedHeight: 70,
              floating: true,
              iconTheme: IconThemeData(color: Get.theme.primaryColor),
              title: Text(
                controller.eProvider.value.name,
                style: Get.textTheme.titleLarge!.merge(TextStyle(color: Get.theme.primaryColor)),
              ),
              centerTitle: true,
              automaticallyImplyLeading: false,
              leading: new IconButton(
                icon: new Icon(Icons.arrow_back_ios, color: Get.theme.primaryColor),
                onPressed: () => {Get.back()},
              ),
              bottom: HomeSearchBarWidget(),
              flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 75),
                    decoration: new BoxDecoration(
                      gradient: new LinearGradient(
                          colors: [Get.theme.colorScheme.secondary.withAlpha((255 * 1).toInt()), Get.theme.colorScheme.secondary.withAlpha((255 * 0.2).toInt())],
                          begin: AlignmentDirectional.topStart,
                          //const FractionalOffset(1, 0),
                          end: AlignmentDirectional.bottomEnd,
                          stops: [0.1, 0.9],
                          tileMode: TileMode.clamp),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                    ),
                  )).marginOnly(bottom: 42),
            ),
            SliverToBoxAdapter(
              child: Wrap(
                children: [
                  Container(
                    height: 60,
                    child: ListView(
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: List.generate(CategoryFilter.values.length, (index) {
                          var _filter = CategoryFilter.values.elementAt(index);
                          return Obx(() {
                            return Padding(
                              padding: const EdgeInsetsDirectional.only(start: 20),
                              child: RawChip(
                                elevation: 0,
                                label: Text(_filter.toString().tr),
                                labelStyle: controller.isSelected(_filter) ? Get.textTheme.bodyMedium!.merge(TextStyle(color: Get.theme.primaryColor)) : Get.textTheme.bodyMedium,
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                                backgroundColor: Theme.of(context).focusColor.withAlpha((255 * 0.1).toInt()),
                                selectedColor: Get.theme.colorScheme.secondary,
                                selected: controller.isSelected(_filter),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                showCheckmark: true,
                                checkmarkColor: Get.theme.primaryColor,
                                onSelected: (bool value) {
                                  controller.toggleSelected(_filter);
                                  controller.loadEServicesOfCategory(filter: controller.selected.value);
                                },
                              ),
                            );
                          });
                        })),
                  ),
                  ServicesListWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}