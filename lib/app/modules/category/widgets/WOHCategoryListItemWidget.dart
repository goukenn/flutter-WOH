// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../common/WOHUi.dart';
import '../../../models/WOHCategoryModel.dart';
import '../../../routes/WOHRoutes.dart';

class WOHCategoryListItemWidget extends StatelessWidget {
  final WOHCategoryModel category;
  final String heroTag;
  final bool expanded;

  WOHCategoryListItemWidget({Key key, this.category, this.heroTag, this.expanded}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: WOHUi.getBoxDecoration(
          border: Border.fromBorderSide(BorderSide.none),
          gradient: new LinearGradient(
              colors: [category.color.withAlpha((255 * 0.6).toInt()), category.color.withAlpha((255 * 0.1).toInt())],
              begin: AlignmentDirectional.topStart,
              //const FractionalOffset(1, 0),
              end: AlignmentDirectional.topEnd,
              stops: [0.0, 0.5],
              tileMode: TileMode.clamp)),
      child: Theme(
        data: Get.theme.copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: this.expanded,
          expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          title: InkWell(
              highlightColor: Colors.transparent,
              splashColor: Get.theme.colorScheme.secondary.withAlpha((255 * 0.08).toInt()),
              onTap: () {
                Get.toNamed(WOHRoutes.CATEGORY, arguments: category);
                //Navigator.of(context).pushNamed('/Details', arguments: RouteArgument(id: '0', param: market.id, heroTag: heroTag));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: (category.image.url.toLowerCase().endsWith('.svg')
                        ? SvgPicture.network(
                            category.image.url,
                            color: category.color,
                            height: 100,
                          )
                        : CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: category.image.url,
                            placeholder: (context, url) => Image.asset(
                              'assets/img/loading.gif',
                              fit: BoxFit.cover,
                            ),
                            errorWidget: (context, url, error) => Icon(Icons.error_outline),
                          )),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      category.name,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: Get.textTheme.bodyMedium,
                    ),
                  ),
                  // TODO get service for each category
                  // Text(
                  //   "(" + category.services.length.toString() + ")",
                  //   overflow: TextOverflow.fade,
                  //   softWrap: false,
                  //   style: Get.textTheme.labelSmall,
                  // ),
                ],
              )),
          children: List.generate(category.subCategories?.length ?? 0, (index) {
            var _category = category.subCategories.elementAt(index);
            return GestureDetector(
              onTap: () {
                Get.toNamed(WOHRoutes.CATEGORY, arguments: _category);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 16),
                child: Text(_category.name, style: Get.textTheme.bodyLarge),
                decoration: BoxDecoration(
                  color: Get.theme.scaffoldBackgroundColor.withAlpha((255 * 0.2).toInt()),
                  border: Border(top: BorderSide(color: Get.theme.scaffoldBackgroundColor.withAlpha((255 * 0.3).toInt()))
                      //color: Get.theme.focusColor.withAlpha((255 * 0.2).toInt()),
                      ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}