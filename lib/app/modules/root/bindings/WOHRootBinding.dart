// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:get/get.dart';

import '../../../providers/WOHOdooApiClientProvider.dart';
import '../../../services/WOHMyAuthService.dart';
import '../../account/controllers/WOHAccountController.dart';
import '../../home/controllers/WOHHomeController.dart';
import '../../userBookings/controllers/WOHBookingsController.dart';
import '../controllers/WOHRootController.dart';

class WOHRootBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WOHRootController>(
      () => WOHRootController(),
    );
    Get.put(WOHHomeController(), permanent: true);
    Get.put(WOHBookingsController(), permanent: true);
    Get.lazyPut<WOHBookingsController>(
      () => WOHBookingsController(),
    );
    Get.lazyPut<AccountController>(
      () => AccountController(),
    );
    Get.lazyPut<MyAuthService>(
          () => MyAuthService(),
    );
    Get.lazyPut<WOHOdooApiClientProvider>(
          () => WOHOdooApiClientProvider(),
    );
  }
}