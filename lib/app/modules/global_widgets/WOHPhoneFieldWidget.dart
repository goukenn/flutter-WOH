// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
/*
 * Copyright (c) 2022 .
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../../WOHColorConstants.dart';

class WOHPhoneFieldWidget extends StatelessWidget {
  const WOHPhoneFieldWidget(
      {super.key,
      this.onSaved,
      this.onChanged,
      this.initialValue = '',
      this.hintText = '',
      this.errorText='',
      this.labelText='',
      this.obscureText=false,
      this.suffixIcon,
      this.isFirst = false,
      this.isLast = false,
      this.style,
      this.textAlign,
      this.suffix,
      this.initialCountryCode='be',
      this.countries  })
     ;

  final FormFieldSetter<PhoneNumber>? onSaved;
  final ValueChanged<PhoneNumber>? onChanged;
  final String initialValue;
  final String hintText;
  final String errorText;
  final TextAlign? textAlign;
  final String labelText;
  final TextStyle? style;
  final bool obscureText;
  final String initialCountryCode;
  final List<String>? countries;
  final bool isFirst;
  final bool isLast;
  final Widget? suffixIcon;
  final Widget? suffix;

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
            labelText,
            style: Get.textTheme.bodyLarge!.merge(TextStyle(color: labelColor)),
            textAlign: textAlign,
          ),
          IntlPhoneField(
              key: key,
              onSaved: onSaved,
              onChanged: onChanged,
              initialValue: initialValue,
              initialCountryCode: initialCountryCode,
              showDropdownIcon: false,
              pickerDialogStyle: PickerDialogStyle(countryNameStyle: Get.textTheme.bodyMedium),
              style: style,
              textAlign: textAlign!,
              disableLengthCheck: true,
              autovalidateMode: AutovalidateMode.disabled,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: Get.textTheme.labelSmall,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                contentPadding: EdgeInsets.all(0),
                border: OutlineInputBorder(borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                suffixIcon: suffixIcon,
                suffix: suffix,
                errorText: errorText,
              )),
        ],
      ),
    );
  }

  BorderRadius get buildBorderRadius {
    if (isFirst != null && isFirst) {
      return BorderRadius.vertical(top: Radius.circular(10));
    }
    if (isLast != null && isLast) {
      return BorderRadius.vertical(bottom: Radius.circular(10));
    }
    if (isFirst != null && !isFirst && isLast != null && !isLast) {
      return BorderRadius.all(Radius.circular(0));
    }
    return BorderRadius.all(Radius.circular(10));
  }

  double get topMargin {
    if ((isFirst != null && isFirst)) {
      return 20;
    } else if (isFirst == null) {
      return 20;
    } else {
      return 0;
    }
  }

  double get bottomMargin {
    if ((isLast != null && isLast)) {
      return 10;
    } else if (isLast == null) {
      return 10;
    } else {
      return 0;
    }
  }
}