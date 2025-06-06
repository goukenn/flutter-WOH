// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher_string.dart';
 
import '../../../../common/WOHMapsUtil.dart';
import '../../../../common/WOHUi.dart';
import '../../../models/WOHEProviderModel.dart';
import '../../../models/WOHMediaModel.dart';
import '../../../providers/WOHLaravelApiClientProvider.dart';
import '../../../routes/WOHRoutes.dart';
import '../../global_widgets/WOHCircularLoadingWidget.dart';
import '../controllers/WOHEProviderController.dart';
import '../widgets/WOHAvailabilityHourItemWidget.dart';
import '../widgets/WOHEProviderTilWidget.dart';
import '../widgets/WOHEProviderTitleBarWidget.dart';
import '../widgets/WOHFeaturedCarouselWidget.dart';
import '../widgets/WOHReviewItemWidget.dart';

class WOHEProviderView extends GetView<WOHEProviderController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var _eProvider = controller.eProvider.value;
      if (!_eProvider.hasData) {
        return Scaffold(
          body: WOHCircularLoadingWidget(height: Get.height),
        );
      } else {
        return Scaffold(
          body: RefreshIndicator(
              onRefresh: () async {
                Get.find<WOHLaravelApiClientProvider>().forceRefresh();
                controller.refreshEProvider(showMessage: true);
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
                      icon: new Icon(Icons.arrow_back_ios, color: Get.theme.hintColor),
                      onPressed: () => {Get.back()},
                    ),
                    bottom: buildEProviderTitleBarWidget(_eProvider),
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      background: Obx(() {
                        return Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: <Widget>[
                            buildCarouselSlider(_eProvider),
                            buildCarouselBullets(_eProvider),
                          ],
                        );
                      }),
                    ).marginOnly(bottom: 50),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 10),
                        buildContactUs(),
                        WOHEProviderTilWidget(
                          title: Text("Description".tr, style: Get.textTheme.bodySmall),
                          content: WOHUi.applyHtml(_eProvider.description ?? '', style: Get.textTheme.bodyLarge),
                        ),
                        buildAddresses(context),
                        buildAvailabilityHours(_eProvider),
                        buildAwards(),
                        buildExperiences(),
                        WOHEProviderTilWidget(
                          horizontalPadding: 0,
                          title: Text("Featured Services".tr, style: Get.textTheme.bodySmall).paddingSymmetric(horizontal: 20),
                          content: WOHFeaturedCarouselWidget(),
                          actions: [
                            InkWell(
                              onTap: () {
                                Get.toNamed(WOHRoutes.E_PROVIDER_E_SERVICES, arguments: _eProvider);
                              },
                              child: Text("View All".tr, style: Get.textTheme.titleMedium),
                            ).paddingSymmetric(horizontal: 20),
                          ],
                        ),
                        buildGalleries(),
                        WOHEProviderTilWidget(
                          title: Text("Reviews & Ratings".tr, style: Get.textTheme.bodySmall),
                          content: Column(
                            children: [
                              Text(_eProvider.rate.toString(), style: Get.textTheme.displayLarge),
                              Wrap(
                                children: WOHUi.getStarsList(_eProvider.rate!, size: 32),
                              ),
                              Text(
                                "Reviews (%s)".trArgs([_eProvider.totalReviews.toString()]),
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
                                    return WOHReviewItemWidget(review: controller.reviews.elementAt(index));
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
                          actions: [
                            // TODO view all reviews
                          ],
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

  Widget buildGalleries() {
    return Obx(() {
      if (controller.galleries.isEmpty) {
        return SizedBox();
      }
      return WOHEProviderTilWidget(
        horizontalPadding: 0,
        title: Text("Galleries".tr, style: Get.textTheme.bodySmall).paddingSymmetric(horizontal: 20),
        content: Container(
          height: 120,
          child: ListView.builder(
              primary: false,
              shrinkWrap: false,
              scrollDirection: Axis.horizontal,
              itemCount: controller.galleries.length,
              itemBuilder: (_, index) {
                var _media = controller.galleries.elementAt(index);
                return InkWell(
                  onTap: () {
                    //Get.toNamed(WOHRoutes.GALLERY, arguments: {'media': controller.galleries, 'current': _media, 'heroTag': 'e_provide_galleries'});
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsetsDirectional.only(end: 20, start: index == 0 ? 20 : 0, top: 10, bottom: 10),
                    child: Stack(
                      alignment: AlignmentDirectional.topStart,
                      children: [
                        Hero(
                          tag: 'e_provide_galleries' + _media.id!,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: CachedNetworkImage(
                              height: 100,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              imageUrl: _media.thumb!,
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
                            style: Get.textTheme.bodyMedium!.merge(TextStyle(color: Get.theme.primaryColor)),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
        actions: [
          // TODO show all galleries
        ],
      );
    });
  }

  WOHEProviderTilWidget buildAvailabilityHours(WOHEProviderModel _eProvider) {
    return WOHEProviderTilWidget(
      title: Text("Availability".tr, style: Get.textTheme.bodySmall),
      content: _eProvider.availabilityHours!.isEmpty
          ? WOHCircularLoadingWidget(height: 150)
          : ListView.separated(
              padding: EdgeInsets.zero,
              primary: false,
              shrinkWrap: true,
              itemCount: _eProvider.groupedAvailabilityHours().entries.length,
              separatorBuilder: (context, index) {
                return Divider(height: 16, thickness: 0.8);
              },
              itemBuilder: (context, index) {
                var _availabilityHour = _eProvider.groupedAvailabilityHours().entries.elementAt(index);
                var _data = _eProvider.getAvailabilityHoursData(_availabilityHour.key);
                return WOHAvailabilityHourItemWidget(availabilityHour: _availabilityHour, data: _data);
              },
            ),
      actions: [
        if (_eProvider.available!)
          Container(
            decoration: BoxDecoration(
              color: Colors.green.withAlpha((255 * 0.2).toInt()),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Text("Available".tr,
                maxLines: 1,
                style: Get.textTheme.bodyMedium!.merge(
                  TextStyle(color: Colors.green, height: 1.4, fontSize: 10),
                ),
                softWrap: false,
                textAlign: TextAlign.center,
                overflow: TextOverflow.fade),
          ),
        if (!_eProvider.available!)
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha((255 * 0.2).toInt()),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Text("Offline".tr,
                maxLines: 1,
                style: Get.textTheme.bodyMedium!.merge(
                  TextStyle(color: Colors.grey, height: 1.4, fontSize: 10),
                ),
                softWrap: false,
                textAlign: TextAlign.center,
                overflow: TextOverflow.fade),
          ),
      ],
    );
  }

  Widget buildAwards() {
    return Obx(() {
      if (controller.awards.isEmpty) {
        return SizedBox(height: 0);
      }
      return WOHEProviderTilWidget(
        title: Text("Awards".tr, style: Get.textTheme.bodySmall),
        content: ListView.separated(
          padding: EdgeInsets.zero,
          primary: false,
          shrinkWrap: true,
          itemCount: controller.awards.length,
          separatorBuilder: (context, index) {
            return Divider(height: 16, thickness: 0.8);
          },
          itemBuilder: (context, index) {
            var _award = controller.awards.elementAt(index);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_award.title ?? '').paddingSymmetric(vertical: 5),
                WOHUi.applyHtml(
                  _award.description ?? '',
                  style: Get.textTheme.labelSmall,
                ),
              ],
            );
          },
        ),
      );
    });
  }

  Widget buildExperiences() {
    return Obx(() {
      if (controller.experiences.isEmpty) {
        return SizedBox(height: 0);
      }
      return WOHEProviderTilWidget(
        title: Text("Experiences".tr, style: Get.textTheme.bodySmall),
        content: ListView.separated(
          padding: EdgeInsets.zero,
          primary: false,
          shrinkWrap: true,
          itemCount: controller.experiences.length,
          separatorBuilder: (context, index) {
            return Divider(height: 16, thickness: 0.8);
          },
          itemBuilder: (context, index) {
            var _experience = controller.experiences.elementAt(index);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_experience.title ?? '').paddingSymmetric(vertical: 5),
                Text(
                  _experience.description ?? '',
                  style: Get.textTheme.labelSmall,
                ),
              ],
            );
          },
        ),
      );
    });
  }

  Container buildContactUs() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: WOHUi.getBoxDecoration(),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Contact us".tr, style: Get.textTheme.bodySmall),
                Text("If your have any question!".tr, style: Get.textTheme.labelSmall),
              ],
            ),
          ),
          Wrap(
            spacing: 5,
            children: [
              MaterialButton(
                onPressed: () {
                  launchUrlString("tel:${controller.eProvider.value.mobileNumber}");
                },
                height: 44,
                minWidth: 44,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color: Get.theme.colorScheme.secondary.withAlpha((255 * 0.2).toInt()),
                elevation: 0,
                child: Icon(
                  Icons.phone_android_outlined,
                  color: Get.theme.colorScheme.secondary,
                ),
              ),
              MaterialButton(
                onPressed: () {
                  launchUrlString("tel:${controller.eProvider.value.phoneNumber}");
                },
                height: 44,
                minWidth: 44,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color: Get.theme.colorScheme.secondary.withAlpha((255 * 0.2).toInt()),
                elevation: 0,
                child: Icon(
                  Icons.call_outlined,
                  color: Get.theme.colorScheme.secondary,
                ),
              ),
              MaterialButton(
                onPressed: () {
                  controller.startChat();
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color: Get.theme.colorScheme.secondary.withAlpha((255 * 0.2).toInt()),
                padding: EdgeInsets.zero,
                height: 44,
                minWidth: 44,
                elevation: 0,
                child: Icon(
                  Icons.chat_outlined,
                  color: Get.theme.colorScheme.secondary,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Container buildAddresses(context) {
    var _addresses = controller.eProvider.value.addresses;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: WOHUi.getBoxDecoration(),
      child: (_addresses!.isEmpty)
          ? Shimmer.fromColors(
              baseColor: Colors.grey.withAlpha((255 * 0.15).toInt()),
              highlightColor: Colors.grey[200]!.withAlpha((255 * 0.1).toInt()),
              child: Container(
                width: double.infinity,
                height: 220,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            )
          : Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  child: WOHMapsUtil.getStaticMaps(_addresses.map((e) => e.getLatLng()).toList()),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: Get.theme.primaryColor,
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
                  ),
                  child: Column(
                    children: List.generate(_addresses.length, (index) {
                      var _address = _addresses.elementAt(index);
                      return Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_address.description!, style: Get.textTheme.bodySmall),
                                SizedBox(height: 5),
                                Text(_address.address!, style: Get.textTheme.labelSmall),
                              ],
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              // WOHMapsUtil.openMapsSheet(context, _address.getLatLng(), controller.eProvider.value.name);
                            },
                            height: 44,
                            minWidth: 44,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            color: Get.theme.colorScheme.secondary.withAlpha((255 * 0.2).toInt()),
                            elevation: 0,
                            child: Icon(
                              Icons.directions_outlined,
                              color: Get.theme.colorScheme.secondary,
                            ),
                          ),
                        ],
                      ).marginOnly(bottom: 10);
                    }),
                  ),
                ),
              ],
            ),
    );
  }

  CarouselSlider buildCarouselSlider(WOHEProviderModel _eProvider) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 7),
        height: 360,
        viewportFraction: 1.0,
        onPageChanged: (index, reason) {
          controller.currentSlide.value = index;
        },
      ),
      items: _eProvider.images!.map((WOHMediaModel media) {
        return Builder(
          builder: (BuildContext context) {
            return Hero(
              tag: controller.heroTag + _eProvider.id!,
              child: CachedNetworkImage(
                width: double.infinity,
                height: 360,
                fit: BoxFit.cover,
                imageUrl: media.url!,
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

  Container buildCarouselBullets(WOHEProviderModel _eProvider) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 100, horizontal: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: _eProvider.images!.map((WOHMediaModel media) {
          return Container(
            width: 20.0,
            height: 5.0,
            margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: controller.currentSlide.value == _eProvider.images!.indexOf(media) ? Get.theme.hintColor : Get.theme.primaryColor.withAlpha((255 * 0.4).toInt())),
          );
        }).toList(),
      ),
    );
  }

  WOHEProviderTitleBarWidget buildEProviderTitleBarWidget(WOHEProviderModel _eProvider) {
    return WOHEProviderTitleBarWidget(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  _eProvider.name ?? '',
                  style: Get.textTheme.headlineSmall!.merge(TextStyle(height: 1.1)),
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Get.theme.colorScheme.secondary.withAlpha((255 * 0.2).toInt()),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(_eProvider.type?.name?.tr ?? ' . . . ',
                    maxLines: 1,
                    style: Get.textTheme.bodyMedium!.merge(
                      TextStyle(color: Get.theme.colorScheme.secondary, height: 1.4, fontSize: 10),
                    ),
                    softWrap: false,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.fade),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.end,
                  children: List.from(WOHUi.getStarsList(_eProvider.rate ?? 0))
                    ..addAll([
                      SizedBox(width: 5),
                      Text(
                        "Reviews (%s)".trArgs([_eProvider.totalReviews.toString()]),
                        style: Get.textTheme.labelSmall,
                      ),
                    ]),
                ),
              ),
              Text(
                "Bookings (%s)".trArgs([_eProvider.bookingsInProgress.toString()]),
                style: Get.textTheme.labelSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}