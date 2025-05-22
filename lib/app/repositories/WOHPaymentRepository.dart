// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
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

  Future<List<PaymentMethod>> getMethods() {
    return _laravelApiClient.getPaymentMethods();
  }

  Future<List<Wallet>> getWallets() {
    return _laravelApiClient.getWallets();
  }

  Future<List<WalletTransaction>> getWalletTransactions(Wallet? wallet) {
    return _laravelApiClient.getWalletTransactions(wallet);
  }

  Future<Wallet> createWallet(Wallet? wallet) {
    return _laravelApiClient.createWallet(wallet);
  }

  Future<Wallet> updateWallet(Wallet? wallet) {
    return _laravelApiClient.updateWallet(wallet);
  }

  Future<bool> deleteWallet(Wallet? wallet) {
    return _laravelApiClient.deleteWallet(wallet);
  }

  Future<Payment> create(WOHBookingModel booking) {
    return _laravelApiClient.createPayment(booking);
  }

  Future<Payment> createWalletPayment(WOHBookingModel booking, Wallet? wallet) {
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