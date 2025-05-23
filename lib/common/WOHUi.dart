// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart' hide OnTap;
import 'package:get/get.dart';



import '../app/services/WOHSettingsService.dart';



// uri package access
class WOHUi {
  static GetSnackBar SuccessSnackBar({
    String title = 'Success',
    required String message,
  }) {
    Get.log("[$title] $message");
    return GetSnackBar(
      titleText: Text(
        title.tr,
        style: Get.textTheme.titleLarge!.merge(
          TextStyle(color: Get.theme.primaryColor),
        ),
      ),
      messageText: Text(
        message,
        style: Get.textTheme.labelSmall!.merge(
          TextStyle(color: Get.theme.primaryColor),
        ),
      ),
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(20),
      backgroundColor: Colors.green,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      icon: Icon(
        Icons.check_circle_outline,
        size: 32,
        color: Get.theme.primaryColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: Duration(seconds: 2),
    );
  }

  static GetSnackBar ErrorSnackBar({
    String title = 'Error',
    required String message
  }) {
    Get.log("[$title] $message", isError: true);
    return GetSnackBar(
      titleText: Text(
        title.tr,
        style: Get.textTheme.titleLarge!.merge(
          TextStyle(color: Get.theme.primaryColor),
        ),
      ),
      messageText: Text(
        message.substring(0, min(message.length, 200)),
        style: Get.textTheme.labelSmall!.merge(
          TextStyle(color: Get.theme.primaryColor),
        ),
      ),
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(20),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      backgroundColor: Colors.redAccent,
      icon: Icon(
        Icons.remove_circle_outline,
        size: 32,
        color: Get.theme.primaryColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: Duration(seconds: 5),
    );
  }

  static GetSnackBar InfoSnackBar({String title = 'Info', 
    required String message}) {
    Get.log("[$title] $message", isError: true);
    return GetSnackBar(
      titleText: Text(
        title.tr,
        style: Get.textTheme.titleLarge!.merge(
          TextStyle(color: Get.theme.primaryColor),
        ),
      ),
      messageText: Text(
        message.substring(0, min(message.length, 200)),
        style: Get.textTheme.labelSmall!.merge(
          TextStyle(color: Get.theme.primaryColor),
        ),
      ),
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(20),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      backgroundColor: Colors.blue,
      icon: Icon(
        Icons.info_outline_rounded,
        size: 32,
        color: Get.theme.primaryColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: Duration(seconds: 5),
    );
  }

  static GetSnackBar warningSnackBar({
    String title = 'Warning',
    required String message,
  }) {
    Get.log("[$title] $message", isError: true);
    return GetSnackBar(
      titleText: Text(
        title.tr,
        style: Get.textTheme.titleLarge!.merge(
          TextStyle(color: Get.theme.primaryColor),
        ),
      ),
      messageText: Text(
        message.substring(0, min(message.length, 200)),
        style: Get.textTheme.labelSmall!.merge(
          TextStyle(color: Get.theme.primaryColor),
        ),
      ),
      snackPosition: SnackPosition.BOTTOM,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      margin: EdgeInsets.all(20),
      backgroundColor: Colors.orangeAccent,
      icon: Icon(
        Icons.warning_amber_rounded,
        size: 32,
        color: Get.theme.primaryColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: Duration(seconds: 5),
    );
  }

  static GetSnackBar defaultSnackBar({String title = 'Alert', 
  required String message}) {
    Get.log("[$title] $message", isError: false);
    return GetSnackBar(
      titleText: Text(
        title.tr,
        style: Get.textTheme.titleLarge!.merge(
          TextStyle(color: Get.theme.hintColor),
        ),
      ),
      messageText: Text(
        message,
        style: Get.textTheme.labelSmall!.merge(
          TextStyle(color: Get.theme.focusColor),
        ),
      ),
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(20),
      backgroundColor: Get.theme.primaryColor,
      // borderColor: Get.theme.focusColor
      //.withValues(alpha=0.1)
      // .withAlpha((255 * 0.1).toInt())
      // ,
      icon: Icon(
        Icons.warning_amber_rounded,
        size: 32,
        color: Get.theme.hintColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: Duration(seconds: 5),
    );
  }

  static GetSnackBar notificationSnackBar({
    String title = 'Notification',
    required String message,
    OnTap? onTap,
    Widget? mainButton,
    Color? buttonColor
  }) {
    Get.log("[$title] $message", isError: false);
    return GetSnackBar(
      onTap: onTap,
      mainButton: mainButton,
      isDismissible: true,
      dismissDirection: DismissDirection.vertical,
      titleText: Text(title.tr, style: Get.textTheme.bodySmall),
      messageText: Text(
        message,
        style: Get.textTheme.labelSmall!.merge(
          TextStyle(color: buttonColor, fontSize: 12),
        ),
        maxLines: 2,
      ),
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.symmetric(horizontal: 10),
      backgroundColor: Get.theme.primaryColor,
      borderColor: null,// Get.theme.focusColor.withAlpha((255 * 0.1).toInt()),
      icon: Icon(
        Icons.notifications_none,
        size: 32,
        color: Get.theme.hintColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 5,
      duration: Duration(seconds: 5),
    );
  }

  static Color parseColor(String hexCode, {double? opacity}) {
    int s = ((opacity ?? 1) * 255).toInt();
    try {
      return Color(
        int.parse(hexCode.replaceAll("#", "0xFF")),
      ).withAlpha(s);
      // .withAlpha((255 * opacity ?? 1).toInt());
    } catch (e) {
      return Color(0xFFCCCCCC)
      .withAlpha(s)
      // .withAlpha((255 * opacity ?? 1).toInt())
      ;
    }
  }

  static List<Icon> getStarsList(double rate, {double? size = 18}) {
    var list = <Icon>[];
    list = List.generate(rate.floor(), (index) {
      return Icon(Icons.star, size: size, color: Color(0xFFFFB24D));
    });
    if (rate - rate.floor() > 0) {
      list.add(Icon(Icons.star_half, size: size, color: Color(0xFFFFB24D)));
    }
    list.addAll(
      List.generate(5 - rate.floor() - (rate - rate.floor()).ceil(), (index) {
        return Icon(Icons.star_border, size: size, color: Color(0xFFFFB24D));
      }),
    );
    return list;
  }

  static Widget getPrice(
    double myPrice, {
    TextStyle? style,
    String? zeroPlaceholder = '-',
    String? unit,
  }) {
    var _setting = Get.find<WOHSettingsService>();
    if (style != null) {
      style = style.merge(TextStyle(fontSize: style.fontSize! + 2));
    }
    try {
      if (myPrice == 0) {
        return Text('-', style: style ?? Get.textTheme.bodySmall);
      }
      return RichText(
        softWrap: false,
        overflow: TextOverflow.fade,
        maxLines: 1,
        text:
            _setting.setting.value.currencyRight != null &&
                _setting.setting.value.currencyRight == false
            ? TextSpan(
                text: _setting.setting.value.defaultCurrency,
                style: getPriceStyle(style),
                children: <TextSpan>[
                  TextSpan(
                    text:
                        myPrice.toStringAsFixed(
                          _setting.setting.value.defaultCurrencyDecimalDigits!,
                        ),
                    style: style ?? Get.textTheme.bodySmall,
                  ),
                  TextSpan(text: " " + unit! + " ", style: getPriceStyle(style)),
                ],
              )
            : TextSpan(
                text:
                    myPrice.toStringAsFixed(
                      _setting.setting.value.defaultCurrencyDecimalDigits!,
                    ),
                style: style ?? Get.textTheme.bodySmall,
                children: <TextSpan>[
                  TextSpan(
                    text: _setting.setting.value.defaultCurrency,
                    style: getPriceStyle(style),
                  ),
                  TextSpan(text: " " + unit! + " ", style: getPriceStyle(style)),
                ],
              ),
      );
    } catch (e) {
      return Text('');
    }
  }

  static TextStyle getPriceStyle(TextStyle? style) {
    if (style == null) {
      return Get.textTheme.bodySmall!.merge(
        TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: (Get.textTheme.bodySmall!.fontSize! - 4),
        ),
      );
    } else {
      return style.merge(
        TextStyle(fontWeight: FontWeight.w300, fontSize: style.fontSize! - 4),
      );
    }
  }

  static BoxDecoration getBoxDecoration({
    Color? color,
    double? radius,
    Border? border,
    Gradient? gradient,
  }) {
    return BoxDecoration(
      color: color ?? Get.theme.primaryColor,
      borderRadius: BorderRadius.all(Radius.circular(radius ?? 10)),
      boxShadow: [
        BoxShadow(
          color: Get.theme.focusColor
            .withAlpha((0.1 * 255).toInt())
          // .withAlpha((255 * 0.1).toInt())
          ,
          blurRadius: 10,
          offset: Offset(0, 5),
        ),
      ],
      border:
          border ?? Border.all(color: Get.theme.focusColor
          .withAlpha((0.05 * 255).toInt())
          //.withAlpha((255 * 0.05).toInt())
          ),
      gradient: gradient,
    );
  }

  static InputDecoration getInputDecoration({
    String? hintText = '',
    String? errorText,
    IconData? iconData,
    Widget? suffixIcon,
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: Get.textTheme.labelSmall,
      prefixIcon: iconData != null
          ? Icon(iconData, color: Get.theme.focusColor).marginOnly(right: 14)
          : SizedBox(),
      prefixIconConstraints: iconData != null
          ? BoxConstraints.expand(width: 38, height: 38)
          : BoxConstraints.expand(width: 0, height: 0),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      contentPadding: EdgeInsets.all(0),
      border: OutlineInputBorder(borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
      suffixIcon: suffixIcon,
      suffix: suffix,
      errorText: errorText,
    );
  }

  static Html applyHtml(
    String html, {
    TextStyle? style,
    TextAlign? textAlign,
    Alignment alignment = Alignment.centerLeft,
  }) {
    // CustomRenderMatcher pMatcher() =>
    //     (context) => context.tree.element?.localName == "p";
    return Html(
      data: html.replaceAll('\r\n', ''),
      /*customRenders: {
        pMatcher(): CustomRender.widget(
          widget: (context, child) {
            return Text(
              context.tree.element.text,
              textAlign: textAlign,
              style: style == null
                  ? Get.textTheme.bodyLarge!.merge(TextStyle(fontSize: 11))
                  : style!.merge(TextStyle(fontSize: 11)),
            );
          },
        ),
      },
      */
      style: {
        "*": Style(
          textAlign: textAlign,
          alignment: alignment,
          color: style == null ? Get.theme.hintColor : style.color,
          fontSize: style == null ? FontSize(16.0) : FontSize(style.fontSize!),
          display: Display.inlineBlock,
          fontWeight: style == null ? FontWeight.w300 : style.fontWeight,
          width: Width(Get.width),
        ),
        "li": Style(
          textAlign: textAlign,
          lineHeight: LineHeight.normal,
          listStylePosition: ListStylePosition.outside,
          fontSize: FontSize(style?.fontSize ?? 14.0),
          display: Display.block,
        ),
        "h4,h5,h6": Style(
          textAlign: textAlign,
          fontSize: style == null
              ? FontSize(16.0)
              : FontSize(style.fontSize! + 2),
        ),
        "h1,h2,h3": Style(
          textAlign: textAlign,
          lineHeight: LineHeight.number(2),
          fontSize: style == null
              ? FontSize(18.0)
              : FontSize(style.fontSize! + 4),
        ),
        "br": Style(height: Height(0)),
      },
    );
  }

  static BoxFit getBoxFit(String? boxFit) {
    switch (boxFit) {
      case 'cover':
        return BoxFit.cover;
      case 'fill':
        return BoxFit.fill;
      case 'contain':
        return BoxFit.contain;
      case 'fit_height':
        return BoxFit.fitHeight;
      case 'fit_width':
        return BoxFit.fitWidth;
      case 'none':
        return BoxFit.none;
      case 'scale_down':
        return BoxFit.scaleDown;
      default:
        return BoxFit.cover;
    }
  }

  static Html removeHtml(
    String html, {
    TextStyle? style,
    TextAlign? textAlign,
    Alignment alignment = Alignment.centerLeft,
  }) {
    // CustomRenderMatcher pMatcher() =>
    //     (context) => context.tree.element?.localName == "p";
    return Html(
      data: html.replaceAll('\r\n', ''),
      /*
      customRenders: {
        pMatcher(): CustomRender.widget(
          widget: (context, child) {
            return Text(
              context.tree.element.text,
              textAlign: textAlign,
              style: style == null
                  ? Get.textTheme.bodyLarge!.merge(TextStyle(fontSize: 11))
                  : style!.merge(TextStyle(fontSize: 11)),
            );
          },
        ),
      },
      */
      style: {
        "*": Style(
          textAlign: textAlign,
          alignment: alignment,
          color: style == null ? Get.theme.hintColor : style.color,
          fontSize: FontSize(style?.fontSize ?? 11.0),
          display: Display.inlineBlock,
          fontWeight: style == null ? FontWeight.w300 : style.fontWeight,
          width: Width( Get.width),
        ),
        "br": Style(height: Height(0)),
      },
    );
  }

  static AlignmentDirectional getAlignmentDirectional(
    String? alignmentDirectional,
  ) {
    switch (alignmentDirectional) {
      case 'top_start':
        return AlignmentDirectional.topStart;
      case 'top_center':
        return AlignmentDirectional.topCenter;
      case 'top_end':
        return AlignmentDirectional.topEnd;
      case 'center_start':
        return AlignmentDirectional.centerStart;
      case 'center':
        return AlignmentDirectional.topCenter;
      case 'center_end':
        return AlignmentDirectional.centerEnd;
      case 'bottom_start':
        return AlignmentDirectional.bottomStart;
      case 'bottom_center':
        return AlignmentDirectional.bottomCenter;
      case 'bottom_end':
        return AlignmentDirectional.bottomEnd;
      default:
        return AlignmentDirectional.bottomEnd;
    }
  }

  static CrossAxisAlignment getCrossAxisAlignment(String? textPosition) {
    switch (textPosition) {
      case 'top_start':
        return CrossAxisAlignment.start;
      case 'top_center':
        return CrossAxisAlignment.center;
      case 'top_end':
        return CrossAxisAlignment.end;
      case 'center_start':
        return CrossAxisAlignment.center;
      case 'center':
        return CrossAxisAlignment.center;
      case 'center_end':
        return CrossAxisAlignment.center;
      case 'bottom_start':
        return CrossAxisAlignment.start;
      case 'bottom_center':
        return CrossAxisAlignment.center;
      case 'bottom_end':
        return CrossAxisAlignment.end;
      default:
        return CrossAxisAlignment.start;
    }
  }

  static bool isDesktop(BoxConstraints constraint) {
    return constraint.maxWidth >= 1280;
  }

  static bool isTablet(BoxConstraints constraint) {
    return constraint.maxWidth >= 768 && constraint.maxWidth <= 1280;
  }

  static bool isMobile(BoxConstraints constraint) {
    return constraint.maxWidth < 768;
  }

  static double col12(
    BoxConstraints constraint, {
    double desktopWidth = 1280,
    double tabletWidth = 768,
    double mobileWidth = 480,
  }) {
    if (isMobile(constraint)) {
      return mobileWidth;
    } else if (isTablet(constraint)) {
      return tabletWidth;
    } else {
      return desktopWidth;
    }
  }

  static double? col9(
    BoxConstraints constraint, {
    double desktopWidth = 1280,
    double tabletWidth = 768,
    double mobileWidth = 480,
  }) {
    if (isMobile(constraint)) {
      return mobileWidth * 3 / 4;
    } else if (isTablet(constraint)) {
      return tabletWidth * 3 / 4;
    } else {
      return desktopWidth * 3 / 4;
    }
  }

  static double? col8(
    BoxConstraints constraint, {
    double desktopWidth = 1280,
    double tabletWidth = 768,
    double mobileWidth = 480,
  }) {
    if (isMobile(constraint)) {
      return mobileWidth * 2 / 3;
    } else if (isTablet(constraint)) {
      return tabletWidth * 2 / 3;
    } else {
      return desktopWidth * 2 / 3;
    }
  }

  static double? col6(
    BoxConstraints constraint, {
    double desktopWidth = 1280,
    double tabletWidth = 768,
    double mobileWidth = 480,
  }) {
    if (isMobile(constraint)) {
      return mobileWidth / 2;
    } else if (isTablet(constraint)) {
      return tabletWidth / 2;
    } else {
      return desktopWidth / 2;
    }
  }

  static double? col4(
    BoxConstraints constraint, {
    double desktopWidth = 1280,
    double tabletWidth = 768,
    double mobileWidth = 480,
  }) {
    if (isMobile(constraint)) {
      return mobileWidth * 1 / 3;
    } else if (isTablet(constraint)) {
      return tabletWidth * 1 / 3;
    } else {
      return desktopWidth * 1 / 3;
    }
  }

  static double? col3(
    BoxConstraints constraint, {
    double desktopWidth = 1280,
    double tabletWidth = 768,
    double mobileWidth = 480,
  }) {
    if (isMobile(constraint)) {
      return mobileWidth * 1 / 4;
    } else if (isTablet(constraint)) {
      return tabletWidth * 1 / 4;
    } else {
      return desktopWidth * 1 / 4;
    }
  }
}