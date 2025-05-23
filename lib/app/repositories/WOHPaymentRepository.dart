// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:get/get.dart';

import '../models/WOHBookingModel.dart';
import '../models/WOHPaymentMethodModel.dart';
import '../models/WOHPaymentModel.dart';
import '../models/WOHWalletModel.dart'; 
import '../models/WOHWalletTransactionModel.dart';
import '../providers/WOHLaravelApiClientProvider.dart';

class WOHPaymentRepository {
  late WOHLaravelApiClientProvider _laravelApiClient;

  WOHPaymentRepository() {
    _laravelApiClient = Get.find<WOHLaravelApiClientProvider>();
  }

  Future<List<WOHPaymentMethodModel>> getMethods() {
    return _laravelApiClient.getPaymentMethods();
  }

  Future<List<WOHWalletModel>> getWallets() {
    return _laravelApiClient.getWallets();
  }

  Future<List<WOHWalletTransactionModel>> getWalletTransactions(WOHWalletModel wallet) {
    return _laravelApiClient.getWalletTransactions(wallet);
  }

  Future<WOHWalletModel> createWallet(WOHWalletModel wallet) {
    return _laravelApiClient.createWallet(wallet);
  }

  Future<WOHWalletModel> updateWallet(WOHWalletModel wallet) {
    return _laravelApiClient.updateWallet(wallet);
  }

  Future<bool> deleteWallet(WOHWalletModel wallet) {
    return _laravelApiClient.deleteWallet(wallet);
  }

  Future<WOHPaymentModel> create(WOHBookingModel booking) {
    return _laravelApiClient.createPayment(booking);
  }

  Future<WOHPaymentModel> createWalletPayment(WOHBookingModel booking, WOHWalletModel wallet) {
    return _laravelApiClient.createWalletPayment(booking, wallet);
  }

  String? getPayPalUrl(WOHBookingModel booking) {
    return _laravelApiClient.getPayPalUrl(booking);
  }

  String? getRazorPayUrl(WOHBookingModel booking) {
    return _laravelApiClient.getRazorPayUrl(booking);
  }

  String? getStripeUrl(WOHBookingModel booking) {
    return _laravelApiClient.getStripeUrl(booking);
  }

  String? getPayStackUrl(WOHBookingModel booking) {
    return _laravelApiClient.getPayStackUrl(booking);
  }

  String? getPayMongoUrl(WOHBookingModel booking) {
    return _laravelApiClient.getPayMongoUrl(booking);
  }

  String? getFlutterWaveUrl(WOHBookingModel booking) {
    return _laravelApiClient.getFlutterWaveUrl(booking);
  }

  String? getStripeFPXUrl(WOHBookingModel booking) {
    return _laravelApiClient.getStripeFPXUrl(booking);
  }
}