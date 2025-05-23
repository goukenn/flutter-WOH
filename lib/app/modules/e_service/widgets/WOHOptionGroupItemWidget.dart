// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
/*
 * Copyright (c) 2020 .
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/WOHEServiceModel.dart';
import '../../../models/WOHOptionGroupModel.dart';

class WOHOptionGroupItemWidget extends GetWidget<WOHEServiceController> {
  WOHOptionGroupItemWidget({
    required WOHOptionGroupModel optionGroup,
    required WOHEServiceModel eService,
  })  : _optionGroup = optionGroup,
        _eService = eService;

  final WOHOptionGroupModel _optionGroup;
  final WOHEServiceModel _eService;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 10,
          children: [
            Icon(
              Icons.create_new_folder_outlined,
              color: Get.theme.hintColor,
            ),
            Text(
              _optionGroup.name ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Get.textTheme.headlineSmall,
            ),
          ],
        ).paddingSymmetric(horizontal: 20, vertical: 10),
        ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          primary: false,
          padding: EdgeInsets.zero,
          itemCount: _optionGroup.options.length,
          separatorBuilder: (context, index) {
            return SizedBox(height: 6);
          },
          itemBuilder: (context, index) {
            var _option = _optionGroup.options.elementAt(index);
            return OptionItemWidget(option: _option, optionGroup: _optionGroup, eService: _eService);
          },
        ),
      ],
    );
  }
}