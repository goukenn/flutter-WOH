// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/WOHUi.dart';
import '../../../models/WOHEServiceModel.dart';
import '../../../models/WOHMediaModel.dart';
import '../../../providers/laravel_provider.dart';
import '../../../routes/WOHRoutes.dart';
import '../../../services/WOHAuthService.dart';
import '../../global_widgets/WOHBlockButtonWidget.dart';
import '../../global_widgets/WOHCircularLoadingWidget.dart';
import '../controllers/WOHEServiceController.dart';
import '../widgets/WOHEProviderItemWidget.dart';
import '../widgets/WOHEServiceTilWidget.dart';
import '../widgets/WOHEServiceTitleBarWidget.dart';
import '../widgets/WOHOptionGroupItemWidget.dart';
import '../widgets/WOHReviewItemWidget.dart';

class WOHEServiceView extends GetView<EServiceController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var _eService = controller.eService.value;
      if (!_eService.hasData) {
        return Scaffold(
          body: WOHCircularLoadingWidget(height: Get.height),
        );
      } else {
        return Scaffold(
          bottomNavigationBar: buildBottomWidget(_eService),
          body: RefreshIndicator(
              onRefresh: () async {
                Get.find<WOHLaravelApiClientProvider>().forceRefresh();
                controller.refreshEService(showMessage: true);
                Get.find<WOHLaravelApiClientProvider>().unForceRefresh();
              },
              child: CustomScrollView(
                primary: true,
                shrinkWrap: false,
                slivers: <Widget>[
                  SliverAppBar(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    expandedHeight: 310,
                    elevation: 0,
                    floating: true,
                    iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
                    centerTitle: true,
                    automaticallyImplyLeading: false,
                    leading: new IconButton(
                      icon: Container(
                        decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                          BoxShadow(
                            color: Get.theme.primaryColor.withAlpha((255 * 0.5).toInt()),
                            blurRadius: 20,
                          ),
                        ]),
                        child: new Icon(Icons.arrow_back_ios, color: Get.theme.hintColor),
                      ),
                      onPressed: () => {Get.back()},
                    ),
                    actions: [
                      new IconButton(
                        icon: Container(
                          decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                            BoxShadow(
                              color: Get.theme.primaryColor.withAlpha((255 * 0.5).toInt()),
                              blurRadius: 20,
                            ),
                          ]),
                          child: (_eService?.isFavorite ?? false) ? Icon(Icons.favorite, color: Colors.redAccent) : Icon(Icons.favorite_outline, color: Get.theme.hintColor),
                        ),
                        onPressed: () {
                          if (!Get.find<WOHAuthService>().isAuth) {
                            Get.toNamed(WOHRoutes.LOGIN);
                          } else {
                            if (_eService?.isFavorite ?? false) {
                              //controller.removeFromFavorite();
                            } else {
                              //controller.addToFavorite();
                            }
                          }
                        },
                      ).marginSymmetric(horizontal: 10),
                    ],
                    bottom: buildEServiceTitleBarWidget(_eService),
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      background: Obx(() {
                        return Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: <Widget>[
                            buildCarouselSlider(_eService),
                            buildCarouselBullets(_eService),
                          ],
                        );
                      }),
                    ).marginOnly(bottom: 50),
                  ),

                  // WelcomeWidget(),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 10),
                        buildCategories(_eService),
                        WOHEServiceTilWidget(
                          title: Text("Description".tr, style: Get.textTheme.bodySmall),
                          content: Obx(() {
                            if (controller.eService.value.description == '') {
                              return SizedBox();
                            }
                            return WOHUi.applyHtml(_eService.description, style: Get.textTheme.bodyLarge);
                          }),
                        ),
                        buildDuration(_eService),
                        buildOptions(_eService),
                        buildServiceProvider(_eService),
                        if (_eService.images.isNotEmpty)
                          WOHEServiceTilWidget(
                            horizontalPadding: 0,
                            title: Text("Galleries".tr, style: Get.textTheme.bodySmall).paddingSymmetric(horizontal: 20),
                            content: Container(
                              height: 120,
                              child: ListView.builder(
                                  primary: false,
                                  shrinkWrap: false,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _eService.images.length,
                                  itemBuilder: (_, index) {
                                    var _media = _eService.images.elementAt(index);
                                    return InkWell(
                                      onTap: () {
                                        //Get.toNamed(WOHRoutes.GALLERY, arguments: {'media': _eService.images, 'current': _media, 'heroTag': 'e_services_galleries'});
                                      },
                                      child: Container(
                                        width: 100,
                                        height: 100,
                                        margin: EdgeInsetsDirectional.only(end: 20, start: index == 0 ? 20 : 0, top: 10, bottom: 10),
                                        child: Stack(
                                          alignment: AlignmentDirectional.topStart,
                                          children: [
                                            Hero(
                                              tag: 'e_services_galleries' + (_media?.id ?? ''),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                                child: CachedNetworkImage(
                                                  height: 100,
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                  imageUrl: _media.thumb,
                                                  placeholder: (context, url) => Image.asset(
                                                    'assets/img/loading.gif',
                                                    fit: BoxFit.cover,
                                                    width: double.infinity,
                                                    height: 100,
                                                  ),
                                                  errorWidget: (context, url, error) => Icon(Icons.error_outline),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsetsDirectional.only(start: 12, top: 8),
                                              child: Text(
                                                _media.name ?? '',
                                                maxLines: 2,
                                                style: Get.textTheme.bodyMedium!.merge(TextStyle(
                                                  color: Get.theme.primaryColor,
                                                  shadows: <Shadow>[
                                                    Shadow(
                                                      offset: Offset(0, 1),
                                                      blurRadius: 6.0,
                                                      color: Get.theme.hintColor.withAlpha((255 * 0.6).toInt()),
                                                    ),
                                                  ],
                                                )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        WOHEServiceTilWidget(
                          title: Text("Reviews & Ratings".tr, style: Get.textTheme.bodySmall),
                          content: Column(
                            children: [
                              Text(_eService.rate.toString(), style: Get.textTheme.displayLarge),
                              Wrap(
                                children: WOHUi.getStarsList(_eService.rate, size: 32),
                              ),
                              Text(
                                "Reviews (%s)".trArgs([_eService.totalReviews.toString()]),
                                style: Get.textTheme.labelSmall,
                              ).paddingOnly(top: 10),
                              Divider(height: 35, thickness: 1.3),
                              Obx(() {
                                if (controller.reviews.isEmpty) {
                                  return WOHCircularLoadingWidget(height: 100);
                                }
                                return ListView.separated(
                                  padding: EdgeInsets.all(0),
                                  itemBuilder: (context, index) {
                                    return ReviewItemWidget(review: controller.reviews.elementAt(index));
                                  },
                                  separatorBuilder: (context, index) {
                                    return Divider(height: 35, thickness: 1.3);
                                  },
                                  itemCount: controller.reviews.length,
                                  primary: false,
                                  shrinkWrap: true,
                                );
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        );
      }
    });
  }

  Widget buildOptions(WOHEServiceModel _eService) {
    return Obx(() {
      if (controller.optionGroups.isEmpty) {
        return SizedBox();
      }
      return WOHEServiceTilWidget(
        horizontalPadding: 0,
        title: Text("Options".tr, style: Get.textTheme.bodySmall).paddingSymmetric(horizontal: 20),
        content: ListView.separated(
          padding: EdgeInsets.all(0),
          itemBuilder: (context, index) {
            return OptionGroupItemWidget(optionGroup: controller.optionGroups.elementAt(index), eService: _eService);
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 6);
          },
          itemCount: controller.optionGroups.length,
          primary: false,
          shrinkWrap: true,
        ),
      );
    });
  }

  Container buildDuration(WOHEServiceModel _eService) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: WOHUi.getBoxDecoration(),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text("Duration".tr, style: Get.textTheme.bodySmall),
                Text("This service can take up to ".tr, style: Get.textTheme.bodyLarge),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
          Text(_eService.duration, style: Get.textTheme.titleLarge),
        ],
      ),
    );
  }

  CarouselSlider buildCarouselSlider(WOHEServiceModel _eService) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 7),
        height: 370,
        viewportFraction: 1.0,
        onPageChanged: (index, reason) {
          controller.currentSlide.value = index;
        },
      ),
      items: _eService.images.map((WOHMediaModel media) {
        return Builder(
          builder: (BuildContext context) {
            return Hero(
              tag: controller.heroTag.value + _eService.id,
              child: CachedNetworkImage(
                width: double.infinity,
                height: 350,
                fit: BoxFit.cover,
                imageUrl: media.url,
                placeholder: (context, url) => Image.asset(
                  'assets/img/loading.gif',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                errorWidget: (context, url, error) => Icon(Icons.error_outline),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Container buildCarouselBullets(WOHEServiceModel _eService) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 100, horizontal: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: _eService.images.map((WOHMediaModel media) {
          return Container(
            width: 20.0,
            height: 5.0,
            margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: controller.currentSlide.value == _eService.images.indexOf(media) ? Get.theme.hintColor : Get.theme.primaryColor.withAlpha((255 * 0.4).toInt())),
          );
        }).toList(),
      ),
    );
  }

  EServiceTitleBarWidget buildEServiceTitleBarWidget(WOHEServiceModel _eService) {
    return EServiceTitleBarWidget(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  _eService.name ?? '',
                  style: Get.textTheme.headlineSmall!.merge(TextStyle(height: 1.1)),
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
              ),
              if (_eService.eProvider == null)
                Container(
                  child: Text("  .  .  .  ".tr,
                      maxLines: 1,
                      style: Get.textTheme.bodyMedium!.merge(
                        TextStyle(color: Colors.grey, height: 1.4, fontSize: 10),
                      ),
                      softWrap: false,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.fade),
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha((255 * 0.2).toInt()),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  margin: EdgeInsets.symmetric(vertical: 3),
                ),
              if (_eService.eProvider != null && _eService.eProvider.available)
                Container(
                  child: Text("Available".tr,
                      maxLines: 1,
                      style: Get.textTheme.bodyMedium!.merge(
                        TextStyle(color: Colors.green, height: 1.4, fontSize: 10),
                      ),
                      softWrap: false,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.fade),
                  decoration: BoxDecoration(
                    color: Colors.green.withAlpha((255 * 0.2).toInt()),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  margin: EdgeInsets.symmetric(vertical: 3),
                ),
              if (_eService.eProvider != null && !_eService.eProvider.available)
                Container(
                  child: Text("Offline".tr,
                      maxLines: 1,
                      style: Get.textTheme.bodyMedium!.merge(
                        TextStyle(color: Colors.grey, height: 1.4, fontSize: 10),
                      ),
                      softWrap: false,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.fade),
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha((255 * 0.2).toInt()),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  margin: EdgeInsets.symmetric(vertical: 3),
                ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(crossAxisAlignment: WrapCrossAlignment.end, children: List.from(WOHUi.getStarsList(_eService.rate))),
                    Text(
                      "Reviews (%s)".trArgs([_eService.totalReviews.toString()]),
                      style: Get.textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (_eService.getOldPrice > 0)
                    WOHUi.getPrice(
                      _eService.getOldPrice,
                      style: Get.textTheme.titleLarge!.merge(TextStyle(color: Get.theme.focusColor, decoration: TextDecoration.lineThrough)),
                      unit: _eService.getUnit,
                    ),
                  WOHUi.getPrice(
                    _eService.getPrice,
                    style: Get.textTheme.headline3!.merge(TextStyle(color: Get.theme.colorScheme.secondary)),
                    unit: _eService.getUnit,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCategories(WOHEServiceModel _eService) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: 5,
        runSpacing: 8,
        children: List.generate(_eService.categories.length, (index) {
              var _category = _eService.categories.elementAt(index);
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: Text(_category.name, style: Get.textTheme.bodyLarge!.merge(TextStyle(color: _category.color))),
                decoration: BoxDecoration(
                    color: _category.color.withAlpha((255 * 0.2).toInt()),
                    border: Border.all(
                      color: _category.color.withAlpha((255 * 0.1).toInt()),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              );
            }) +
            List.generate(_eService.subCategories.length, (index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: Text(_eService.subCategories.elementAt(index).name, style: Get.textTheme.labelSmall),
                decoration: BoxDecoration(
                    color: Get.theme.primaryColor,
                    border: Border.all(
                      color: Get.theme.focusColor.withAlpha((255 * 0.2).toInt()),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              );
            }),
      ),
    );
  }

  Widget buildServiceProvider(WOHEServiceModel _eService) {
    if (_eService?.eProvider?.hasData ?? false) {
      return GestureDetector(
        onTap: () {
          Get.toNamed(WOHRoutes.E_PROVIDER, arguments: {'eProvider': _eService.eProvider, 'heroTag': 'e_service_details'});
        },
        child: WOHEServiceTilWidget(
          title: Text("Service Provider".tr, style: Get.textTheme.bodySmall),
          content: EProviderItemWidget(provider: _eService.eProvider),
        ),
      );
    } else {
      return WOHEServiceTilWidget(
        title: Text("Service Provider".tr, style: Get.textTheme.bodySmall),
        content: SizedBox(
          height: 60,
        ),
      );
    }
  }

  Widget buildBottomWidget(WOHEServiceModel _eService) {
    if (_eService.enableBooking == null || !_eService.enableBooking)
      return SizedBox();
    else
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Get.theme.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(color: Get.theme.focusColor.withAlpha((255 * 0.1).toInt()), blurRadius: 10, offset: Offset(0, -5)),
          ],
        ),
        child: Row(
          children: [
            if (_eService.priceUnit == 'fixed')
              Container(
                decoration: BoxDecoration(
                  color: Get.theme.colorScheme.secondary.withAlpha((255 * 0.2).toInt()),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  textDirection: TextDirection.ltr,
                  children: [
                    MaterialButton(
                      height: 24,
                      minWidth: 46,
                      onPressed: controller.decrementQuantity,
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      color: Get.theme.colorScheme.secondary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(left: Radius.circular(10))),
                      child: Icon(Icons.remove, color: Get.theme.primaryColor, size: 28),
                      elevation: 0,
                    ),
                    SizedBox(
                      width: 38,
                      child: Obx(() {
                        return Text(
                          controller.quantity.toString(),
                          textAlign: TextAlign.center,
                          style: Get.textTheme.bodySmall!.merge(
                            TextStyle(color: Get.theme.colorScheme.secondary),
                          ),
                        );
                      }),
                    ),
                    MaterialButton(
                      onPressed: controller.incrementQuantity,
                      height: 24,
                      minWidth: 46,
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      color: Get.theme.colorScheme.secondary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10))),
                      child: Icon(Icons.add, color: Get.theme.primaryColor, size: 28),
                      elevation: 0,
                    ),
                  ],
                ),
              ),
            if (_eService.priceUnit == 'fixed') SizedBox(width: 10),
            Expanded(
              child: WOHBlockButtonWidget(
                  text: Container(
                    height: 24,
                    alignment: Alignment.center,
                    child: Text(
                      "Book This Service".tr,
                      textAlign: TextAlign.center,
                      style: Get.textTheme.titleLarge!.merge(
                        TextStyle(color: Get.theme.primaryColor),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Get.toNamed(WOHRoutes.BOOK_E_SERVICE, arguments: {'eService': _eService, 'options': controller.getCheckedOptions(), 'quantity': controller.quantity.value});
                  }),
            ),
          ],
        ).paddingOnly(right: 20, left: 20),
      );
  }
}