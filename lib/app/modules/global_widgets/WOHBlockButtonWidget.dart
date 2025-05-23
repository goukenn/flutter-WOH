// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../WOHColorConstants.dart';
import '../../../WOHResponsive.dart'; 

class WOHBlockButtonWidget extends StatelessWidget {
  WOHBlockButtonWidget({super.key,
  required this.text, 
  this.loginPage =false, 
  this.color=null, 
  required this.onPressed,
  this.disabled = false});

  final Widget text;
  late Color? color;
  final VoidCallback? onPressed;
  bool loginPage;
  bool disabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      /*decoration: this.onPressed != null
          ? BoxDecoration(
              boxShadow: [
                BoxShadow(color: this.color.withAlpha((255 * 0.3).toInt()), blurRadius: 40, offset: Offset(0, 15)),
                BoxShadow(color: this.color.withAlpha((255 * 0.2).toInt()), blurRadius: 13, offset: Offset(0, 3))
              ],
              // borderRadius: BorderRadius.all(Radius.circular(20)),
            )
          : null,*/
      child: MaterialButton(

        onPressed: disabled ? null : this.onPressed,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        color: !loginPage ? WOHResponsive.isTablet(context) ?
        employeeInterfaceColor : interfaceColor : color,
        disabledElevation: 0,
        disabledColor: Get.theme.focusColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 0,
        child: this.text
      ),
    );
  }
}