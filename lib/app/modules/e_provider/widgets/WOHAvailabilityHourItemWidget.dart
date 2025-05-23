// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WOHAvailabilityHourItemWidget extends StatelessWidget {
  const WOHAvailabilityHourItemWidget({
    super.key,
    required MapEntry<String, List<String>> availabilityHour,
    required List<String> data,
  })  : _availabilityHour = availabilityHour,
        _data = data;

  final MapEntry<String, List<String>> _availabilityHour;
  final List<String> _data;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                  Text(_availabilityHour.key.tr).paddingSymmetric(vertical: 5),
                ] +
                List.generate(_data.length, (index) {
                  return Text(
                    _data.elementAt(index),
                    style: Get.textTheme.labelSmall,
                  );
                }),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(_availabilityHour.value.length, (index) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 3),
              width: 125,
              decoration: BoxDecoration(
                color: Get.theme.focusColor.withAlpha((255 * 0.15).toInt()),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Text(
                _availabilityHour.value.elementAt(index),
                style: Get.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            );
          }),
        ),
      ],
    );
  }
}