// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
/*
 * Copyright (c) 2020 .
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/WOHUi.dart';
import '../../../models/WOHEServiceModel.dart';
import '../../../routes/WOHRoutes.dart';

class WOHSearchServicesListItemWidget extends StatelessWidget {
  const WOHSearchServicesListItemWidget({
    super.key,
    required WOHEServiceModel service,
  })  : _service = service;

  final WOHEServiceModel _service;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(WOHRoutes.E_SERVICE, arguments: {'eService': _service, 'heroTag': 'search_list'});
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: WOHUi.getBoxDecoration(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Hero(
                  tag: 'search_list' + _service.id!,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                    child: CachedNetworkImage(
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                      imageUrl: _service.firstImageUrl!,
                      placeholder: (context, url) => Image.asset(
                        'assets/img/loading.gif',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 80,
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error_outline),
                    ),
                  ),
                ),
                if (_service.eProvider!.available!)
                  Container(
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.green.withAlpha((255 * 0.2).toInt()),
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
                    child: Text("Available".tr,
                        maxLines: 1,
                        style: Get.textTheme.bodyMedium!.merge(
                          TextStyle(color: Colors.green, height: 1.4, fontSize: 10),
                        ),
                        softWrap: false,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade),
                  ),
                if (!_service.eProvider!.available!)
                  Container(
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey.withAlpha((255 * 0.2).toInt()),
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
                    child: Text("Offline".tr,
                        maxLines: 1,
                        style: Get.textTheme.bodyMedium!.merge(
                          TextStyle(color: Colors.grey, height: 1.4, fontSize: 10),
                        ),
                        softWrap: false,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade),
                  ),
              ],
            ),
            SizedBox(width: 12),
            Expanded(
              child: Wrap(
                runSpacing: 10,
                alignment: WrapAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Text(
                        _service.name ?? '',
                        style: Get.textTheme.bodyMedium,
                        maxLines: 3,
                        // textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                  Divider(height: 8, thickness: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 5,
                        children: [
                          SizedBox(
                            height: 32,
                            child: Chip(
                              padding: EdgeInsets.all(0),
                              label: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.star,
                                    color: Get.theme.colorScheme.secondary,
                                    size: 18,
                                  ),
                                  Text(_service.rate.toString(), style: Get.textTheme.bodyMedium!.merge(TextStyle(color: Get.theme.colorScheme.secondary, height: 1.4))),
                                ],
                              ),
                              backgroundColor: Get.theme.colorScheme.secondary.withAlpha((255 * 0.15).toInt()),
                              shape: StadiumBorder(),
                            ),
                          ),
                          Text(
                            "From (%s)".trArgs([_service.totalReviews.toString()]),
                            style: Get.textTheme.bodyLarge,
                          ),
                        ],
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
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.build_circle_outlined,
                        size: 18,
                        color: Get.theme.focusColor,
                      ),
                      SizedBox(width: 5),
                      Flexible(
                        child: Text(
                          _service.eProvider!.name!,
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: Get.textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.place_outlined,
                        size: 18,
                        color: Get.theme.focusColor,
                      ),
                      SizedBox(width: 5),
                      Flexible(
                        child: Text(
                          _service.eProvider!.firstAddress,
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: Get.textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 8, thickness: 1),
                  Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: List.generate(_service.subCategories!.length, (index) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                            color: Get.theme.primaryColor,
                            border: Border.all(
                              color: Get.theme.focusColor.withAlpha((255 * 0.2).toInt()),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                        child: Text(_service.subCategories!.elementAt(index).name!, style: Get.textTheme.labelSmall!.merge(TextStyle(fontSize: 10))),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}