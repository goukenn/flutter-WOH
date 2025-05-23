// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/WOHUi.dart';
import '../../../routes/WOHRoutes.dart';
import '../../global_widgets/WOHCircularLoadingWidget.dart';
import '../controllers/WOHEProviderController.dart';

class WOHFeaturedCarouselWidget extends GetWidget<WOHEProviderController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      color: Get.theme.primaryColor,
      child: Obx(() {
        if (controller.featuredEServices.isEmpty) {
          return WOHCircularLoadingWidget(height: 250);
        }
        return ListView.builder(
            padding: EdgeInsets.only(bottom: 10),
            primary: false,
            shrinkWrap: false,
            scrollDirection: Axis.horizontal,
            itemCount: controller.featuredEServices.length,
            itemBuilder: (_, index) {
              var _service = controller.featuredEServices.elementAt(index);
              return GestureDetector(
                onTap: () {
                  Get.toNamed(WOHRoutes.E_SERVICE, arguments: {'eService': _service, 'heroTag': 'featured_carousel'});
                },
                child: Container(
                  width: 170,
                  margin: EdgeInsetsDirectional.only(end: 20, start: index == 0 ? 20 : 0, top: 20, bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Get.theme.focusColor.withAlpha((255 * 0.1).toInt())),
                  ),
                  child: Column(
                    children: [
                      Hero(
                        tag: 'featured_carousel' + _service.id!,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                          child: CachedNetworkImage(
                            height: 140,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            imageUrl: _service.firstImageUrl!,
                            placeholder: (context, url) => Image.asset(
                              'assets/img/loading.gif',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 140,
                            ),
                            errorWidget: (context, url, error) => Icon(Icons.error_outline),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                        height: 135,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Get.theme.primaryColor,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              _service.name ?? '',
                              maxLines: 2,
                              style: Get.textTheme.bodyMedium!.merge(TextStyle(color: Get.theme.hintColor)),
                            ),
                            Wrap(
                              children: WOHUi.getStarsList(_service.rate!),
                            ),
                            SizedBox(height: 10),
                            Wrap(
                              spacing: 5,
                              alignment: WrapAlignment.spaceBetween,
                              direction: Axis.horizontal,
                              crossAxisAlignment: WrapCrossAlignment.end,
                              children: [
                                Text(
                                  "Start from".tr,
                                  style: Get.textTheme.labelSmall,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    if (_service.getOldPrice! > 0)
                                      WOHUi.getPrice(
                                        _service.getOldPrice!,
                                        style: Get.textTheme.bodyLarge!.merge(TextStyle(color: Get.theme.focusColor, decoration: TextDecoration.lineThrough)),
                                        unit: _service.getUnit,
                                      ),
                                    WOHUi.getPrice(
                                      _service.getPrice!,
                                      style: Get.textTheme.bodyMedium!.merge(TextStyle(color: Get.theme.colorScheme.secondary)),
                                      unit: _service.getUnit,
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      }),
    );
  }
}