// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
/*
 * Copyright (c) 2020 .
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../WOHColorConstants.dart';
import '../../../common/WOHUi.dart'; 
class WOHTextFieldWidget extends StatelessWidget {
  const WOHTextFieldWidget(// Map<dynamic, Object> map, 
  {  
    super.key,
    this.initialValue = "",
    this.onSaved,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.hintText= "",
    this.errorText='',
    required this.iconData,
    this.labelText = "",
    this.obscureText = false,
    this.suffixIcon,
    this.isFirst = false,
    this.editable = false,
    this.isLast = false,
    this.style,
    this.textAlign,
    this.suffix,
    this.onTap,
    this.readOnly = false,
    this.maxLines = 0
  });

  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  final Function? onTap;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final String hintText;
  final String errorText;
  final TextAlign? textAlign;
  final String labelText;
  final TextStyle? style;
  final bool editable;
  final bool readOnly;
  final IconData iconData;
  final String initialValue;
  final bool obscureText;
  final bool isFirst;
  final bool isLast;
  final Widget? suffixIcon;
  final Widget? suffix;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      margin: EdgeInsets.only(left: 5, right: 5, top: topMargin, bottom: bottomMargin),
      decoration: BoxDecoration(
          color: Get.theme.primaryColor,
          borderRadius: buildBorderRadius,
          boxShadow: [
            BoxShadow(color: Get.theme.focusColor.withAlpha((255 * 0.1).toInt()), blurRadius: 10, offset: Offset(0, 5)),
          ],
          border: Border.all(color: Get.theme.focusColor.withAlpha((255 * 0.05).toInt()))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            labelText ?? "",
            style: Get.textTheme.bodyMedium!.merge(TextStyle(color: labelColor)),
            textAlign: textAlign ?? TextAlign.start,
          ),
          TextFormField(
            initialValue: initialValue,
            maxLines: keyboardType == TextInputType.multiline ? null : 1,
            key: key,
            keyboardType: keyboardType ?? TextInputType.text,
            onSaved: onSaved,
            onTap: onTap,
            readOnly: readOnly,
            onChanged: onChanged,
            minLines: maxLines,
            validator: validator,
            enabled: editable,
            style: style ?? Get.textTheme.bodyMedium!.merge(TextStyle(color: labelColor)),
            obscureText: obscureText,
            textAlign: textAlign ?? TextAlign.start,
            decoration: WOHUi.getInputDecoration(
              hintText: hintText,
              iconData: iconData,
              suffixIcon: suffixIcon,
              suffix: suffix,
              errorText: errorText,
            ),
          ),
        ],
      ),
    );
  }

  BorderRadius get buildBorderRadius {
    if (isFirst) {
      return BorderRadius.vertical(top: Radius.circular(10));
    }
    if (isLast) {
      return BorderRadius.vertical(bottom: Radius.circular(10));
    }
    if (!isFirst && !isLast) {
      return BorderRadius.all(Radius.circular(0));
    }
    return BorderRadius.all(Radius.circular(10));
  }

  double get topMargin {
    if ((isFirst)) {
      return 20;
    } else    return 0;
  
  }

  double get bottomMargin {
    if ((isLast)) {
      return 10;
    } else    return 0;
  
  }
}