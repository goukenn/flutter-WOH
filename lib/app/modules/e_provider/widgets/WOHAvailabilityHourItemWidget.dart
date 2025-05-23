// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
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