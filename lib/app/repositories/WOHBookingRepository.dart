// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:get/get.dart';

import '../models/WOHBookingModel.dart';
import '../models/WOHBookingStatusModel.dart';
import '../models/WOHCouponModel.dart';
import '../models/WOHReviewModel.dart';
import '../providers/WOHLaravelApiClientProvider.dart';

class WOHBookingRepository {
  WOHLaravelApiClientProvider _laravelApiClient;

  WOHBookingRepository() {
    this._laravelApiClient = Get.find<WOHLaravelApiClientProvider>();
  }

  Future<List<WOHBookingModel>> all(String? statusId, {int? page}) {
    return _laravelApiClient.getBookings(statusId, page);
  }

  Future<List<BookingStatus>> getStatuses() {
    return _laravelApiClient.getBookingStatuses();
  }

  Future<WOHBookingModel> get(String? bookingId) {
    return _laravelApiClient.getBooking(bookingId);
  }

  Future<WOHBookingModel> add(WOHBookingModel booking) {
    return _laravelApiClient.addBooking(booking);
  }

  Future<WOHBookingModel> update(WOHBookingModel booking) {
    return _laravelApiClient.updateBooking(booking);
  }

  Future<Coupon> coupon(WOHBookingModel booking) {
    return _laravelApiClient.validateCoupon(booking);
  }

  Future<Review> addReview(Review review) {
    return _laravelApiClient.addReview(review);
  }
}