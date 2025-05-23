// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../WOHColorConstants.dart';
import '../../../responsive.dart';

class WOHBlockButtonWidget extends StatelessWidget {
  const WOHBlockButtonWidget({Key key,required this.text, required this.loginPage, this.color, required this.onPressed,required this.disabled}) : super(key: key);

  final Widget text;
  final bool loginPage;
  final Color color;
  final VoidCallback onPressed;
  final bool disabled;

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
        child: this.text,
        elevation: 0,
      ),
    );
  }
}