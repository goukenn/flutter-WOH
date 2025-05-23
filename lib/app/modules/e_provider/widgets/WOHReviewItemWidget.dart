// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/WOHUi.dart';
import '../../../models/WOHReviewModel.dart';

class WOHReviewItemWidget extends StatelessWidget {
  final WOHReviewModel? review;

  WOHReviewItemWidget({Key? key, this.review});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Wrap(
        direction: Axis.horizontal,
        runSpacing: 20,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: CachedNetworkImage(
                  height: 65,
                  width: 65,
                  fit: BoxFit.cover,
                  imageUrl: review.user.avatar.thumb,
                  placeholder: (context, url) => Image.asset(
                    'assets/img/loading.gif',
                    fit: BoxFit.cover,
                    height: 65,
                    width: 65,
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error_outline),
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      review!.user.name,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      maxLines: 2,
                      style: Get.textTheme.bodyMedium!.merge(TextStyle(color: Get.theme.hintColor)),
                    ),
                    Text(
                      review?.user.bio,
                      overflow: TextOverflow.ellipsis,
                      style: Get.textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 32,
                child: Chip(
                  padding: EdgeInsets.all(0),
                  label: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(review.rate.toString(), style: Get.textTheme.bodyLarge!.merge(TextStyle(color: Get.theme.primaryColor))),
                      Icon(
                        Icons.star_border,
                        color: Get.theme.primaryColor,
                        size: 16,
                      ),
                    ],
                  ),
                  backgroundColor: Get.theme.colorScheme.secondary.withAlpha((255 * 0.9).toInt()),
                  shape: StadiumBorder(),
                ),
              ),
            ],
          ),
          WOHUi.removeHtml(review.review, style: Get.textTheme.bodyLarge),
        ],
      ),
    );
  }
}