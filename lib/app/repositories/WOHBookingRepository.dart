// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:get/get.dart';

import '../models/WOHBookingModel.dart'; 
// import '../models/WOHBookingStatusModel.dart';
import '../models/WOHCouponModel.dart';
import '../models/WOHReviewModel.dart';
import '../providers/WOHLaravelApiClientProvider.dart';

class WOHBookingRepository {
  late WOHLaravelApiClientProvider _laravelApiClient;

  WOHBookingRepository() {
    this._laravelApiClient = Get.find<WOHLaravelApiClientProvider>();
  }

  Future<List<WOHBookingModel>> all(String statusId, {int? page}) {
    return _laravelApiClient.getBookings(statusId, page);
  }

  // Future<List<WOHBookingStatusModel>> getStatuses() async {
  //   return _laravelApiClient.getBookingStatuses();
  // }
  Future<Future> getStatuses() async {
    return _laravelApiClient.getBookingStatuses();
  }

  Future<WOHBookingModel> get(String bookingId) {
    return _laravelApiClient.getBooking(bookingId);
  }

  Future<WOHBookingModel> add(WOHBookingModel booking) {
    return _laravelApiClient.addBooking(booking);
  }

  Future<WOHBookingModel> update(WOHBookingModel booking) {
    return _laravelApiClient.updateBooking(booking);
  }

  Future<WOHCouponModel> coupon(WOHBookingModel booking) {
    return _laravelApiClient.validateCoupon(booking);
  }

  Future<WOHReviewModel> addReview(WOHReviewModel review) {
    return _laravelApiClient.addReview(review);
  }
}