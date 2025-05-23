// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:get/get.dart';

import 'WOHCategoryModel.dart';
import 'WOHEProviderModel.dart';
import 'WOHMediaModel.dart';
import 'parents/WOHModel.dart';

class WOHEServiceModel extends WOHModel {
  @override
  String? id;
  String? name;
  String? description;
  List<WOHMediaModel>? images;
  double? price;
  double? discountPrice;
  String? priceUnit;
  String? quantityUnit;
  double? rate;
  int? totalReviews;
  String? duration;
  bool? featured;
  bool? enableBooking;
  bool? isFavorite;
  List<WOHCategoryModel>? categories;
  List<WOHCategoryModel>? subCategories;
  WOHEProviderModel? eProvider;

  WOHEServiceModel(
      {this.id,
      this.name,
      this.description,
      this.images,
      this.price,
      this.discountPrice,
      this.priceUnit,
      this.quantityUnit,
      this.rate,
      this.totalReviews,
      this.duration,
      this.featured,
      this.enableBooking,
      this.isFavorite,
      this.categories,
      this.subCategories,
      this.eProvider});

  WOHEServiceModel.fromJson(Map<String, dynamic> json) {
    name = transStringFromJson(json, 'name');
    description = transStringFromJson(json, 'description');
    images = mediaListFromJson(json, 'images');
    price = doubleFromJson(json, 'price');
    discountPrice = doubleFromJson(json, 'discount_price');
    priceUnit = stringFromJson(json, 'price_unit');
    quantityUnit = transStringFromJson(json, 'quantity_unit');
    rate = doubleFromJson(json, 'rate');
    totalReviews = intFromJson(json, 'total_reviews');
    duration = stringFromJson(json, 'duration');
    featured = boolFromJson(json, 'featured');
    enableBooking = boolFromJson(json, 'enable_booking');
    isFavorite = boolFromJson(json, 'is_favorite');
    categories = listFromJson<WOHCategoryModel>(json, 'categories', (value) => WOHCategoryModel.fromJson(value));
    subCategories = listFromJson<WOHCategoryModel>(json, 'sub_categories', (value) => WOHCategoryModel.fromJson(value));
    eProvider = objectFromJson(json, 'e_provider', (value) => WOHEProviderModel.fromJson(value));
    super.fromJson(json);
  }

@override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['discount_price'] = this.discountPrice;
    data['price_unit'] = this.priceUnit;
    if (quantityUnit != 'null') data['quantity_unit'] = this.quantityUnit;
    data['rate'] = this.rate;
    data['total_reviews'] = this.totalReviews;
    data['duration'] = this.duration;
    data['featured'] = this.featured;
    data['enable_booking'] = this.enableBooking;
    data['is_favorite'] = this.isFavorite;
    data['categories'] = this.categories!.map((v) => v.id).toList();
      data['image'] = this.images!.map((v) => v.toJson()).toList();
      data['sub_categories'] = this.subCategories!.map((v) => v.toJson()).toList();
      if (this.eProvider!.hasData) {
      data['e_provider_id'] = this.eProvider!.id;
    }
    return data;
  }

  String? get firstImageUrl => this.images!.first.url ?? '';

  String? get firstImageThumb => this.images!.first.thumb ?? '';

  String? get firstImageIcon => this.images!.first.icon ?? '';

  @override
  bool get hasData {
    return name != null;
  }

  /*
  * Get the real price of the service
  * when the discount not set, then it return the price
  * otherwise it return the discount price instead
  * */
  double? get getPrice {
    return (discountPrice ?? 0) > 0 ? discountPrice : price;
  }

  /*
  * Get discount price
  * */
  double? get getOldPrice {
    return (discountPrice ?? 0) > 0 ? price : 0;
  }

  String? get getUnit {
    if (priceUnit == 'fixed') {
      if (quantityUnit!.isNotEmpty) {
        return "/" + quantityUnit!.tr;
      } else {
        return "";
      }
    } else {
      return "/h".tr;
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is WOHEServiceModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          rate == other.rate &&
          isFavorite == other.isFavorite &&
          enableBooking == other.enableBooking &&
          categories == other.categories &&
          subCategories == other.subCategories &&
          eProvider == other.eProvider;

  @override
  int get hashCode =>
      super.hashCode ^
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      rate.hashCode ^
      eProvider.hashCode ^
      categories.hashCode ^
      subCategories.hashCode ^
      isFavorite.hashCode ^
      enableBooking.hashCode;
}