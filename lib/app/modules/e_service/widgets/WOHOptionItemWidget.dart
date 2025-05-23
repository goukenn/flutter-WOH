// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
/*
 * Copyright (c) 2020 .
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/WOHUi.dart';
import '../../../models/WOHEServiceModel.dart';
import '../../../models/WOHOptionGroupModel.dart';
import '../../../models/WOHOptionModel.dart';
import '../controllers/WOHEServiceController.dart'; 

class WOHOptionItemWidget extends GetWidget<WOHEServiceController> {
  WOHOptionItemWidget({super.key, 
    required WOHOptionModel option,
    required WOHOptionGroupModel optionGroup,
    required WOHEServiceModel eService,
  })  : _option = option,
        _optionGroup = optionGroup,
        _eService = eService;

  final WOHOptionModel _option;
  final WOHEServiceModel _eService;
  final WOHOptionGroupModel _optionGroup;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GestureDetector(
        onTap: () {
          if (_eService.enableBooking != null && _eService.enableBooking!) {
            controller.selectOption(_optionGroup, _option);
          }
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 3),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: WOHUi.getBoxDecoration(color: controller.getColor(_option), radius: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: CachedNetworkImage(
                      height: 54,
                      width: 54,
                      fit: BoxFit.cover,
                      imageUrl: _option.image!.thumb!,
                      placeholder: (context, url) => Image.asset(
                        'assets/img/loading.gif',
                        fit: BoxFit.cover,
                        height: 54,
                        width: 54,
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error_outline),
                    ),
                  ),
                  Container(
                    height: 54,
                    width: 54,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Get.theme.colorScheme.secondary.withAlpha((255 * (_option.checked! ? 0.8 : 0)).toInt()),
                    ),
                    child: Icon(
                      Icons.check,
                      size: 36,
                      color: Theme.of(context).primaryColor.withAlpha((255 * (_option.checked! ? 1 : 0)).toInt()),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 15),
              Flexible(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_option.name!, style: controller.getTitleTheme(_option)).paddingOnly(bottom: 5),
                          WOHUi.applyHtml(_option.description!, style: controller.getSubTitleTheme(_option)),
                        ],
                      ),
                    ),
                    SizedBox(width: 8),
                    WOHUi.getPrice(
                      _option.price!,
                      style: Get.textTheme.titleLarge!.merge(TextStyle(color: _option.checked! ? Get.theme.colorScheme.secondary : Get.theme.hintColor)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}