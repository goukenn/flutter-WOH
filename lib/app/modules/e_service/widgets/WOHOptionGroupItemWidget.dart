// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
/*
 * Copyright (c) 2020 .
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/WOHEServiceModel.dart';
import '../../../models/WOHOptionGroupModel.dart';
import '../controllers/WOHEServiceController.dart';
import 'WOHOptionItemWidget.dart';

class OptionGroupItemWidget extends GetWidget<EServiceController> {
  OptionGroupItemWidget({
    @required OptionGroup optionGroup,
    @required EService eService,
  })  : _optionGroup = optionGroup,
        _eService = eService;

  final OptionGroup _optionGroup;
  final EService _eService;

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
              style: Get.textTheme.headline5,
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