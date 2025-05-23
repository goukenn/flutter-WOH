// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable, sort_child_properties_last
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../common/WOHUi.dart';
import '../../../models/WOHCategoryModel.dart';
import '../../../routes/WOHRoutes.dart';

class WOHCategoryGridItemWidget extends StatelessWidget {
  final WOHCategoryModel category;
  final String? heroTag;

  WOHCategoryGridItemWidget({super.key, required this.category, this.heroTag});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Get.theme.colorScheme.secondary.withAlpha((255 * 0.08).toInt()),
      onTap: () {
        Get.toNamed(WOHRoutes.CATEGORY, arguments: category);
      },
      child: Container(
        decoration: WOHUi.getBoxDecoration(),
        child: Wrap(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: [category.color!.withAlpha((255 * 1).toInt()), category.color!.withAlpha((255 * 0.1).toInt())],
                    begin: AlignmentDirectional.topStart,
                    //const FractionalOffset(1, 0),
                    end: AlignmentDirectional.bottomEnd,
                    stops: [0.1, 0.9],
                    tileMode: TileMode.clamp),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
              ),
              child: (category.image!.url!.toLowerCase().endsWith('.svg')
                  ? SvgPicture.network(
                      category.image!.url!,
                      color: category.color,
                      height: 100,
                    )
                  : CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: (category.image?.url != null ? category.image?.url! : '')!,
                      placeholder: (context, url) => Image.asset(
                        'assets/img/loading.gif',
                        fit: BoxFit.cover,
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error_outline),
                    )),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    category.name ?? '',
                    style: Theme.of(context).textTheme.bodyMedium,
                    softWrap: false,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                  if ((category.subCategories?.length ?? 0) > 0) Divider(height: 25, thickness: 0.5),
                  Wrap(
                    spacing: 5,
                    children: List.generate(category.subCategories?.length ?? 0, (index) {
                      var _category = category.subCategories!.elementAt(index);
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(WOHRoutes.CATEGORY, arguments: _category);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          child: Text(_category!.name!, style: Get.textTheme.labelSmall!.merge(TextStyle(fontSize: 10))),
                          decoration: BoxDecoration(
                              color: Get.theme.primaryColor,
                              border: Border.all(
                                color: Get.theme.focusColor.withAlpha((255 * 0.2).toInt()),
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(20))),
                        ),
                      );
                    }),
                    runSpacing: 5,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}