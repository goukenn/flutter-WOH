// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:get/get.dart';

import '../../../providers/WOHOdooApiClientProvider.dart';
import '../../../services/WOHMyAuthService.dart';
import '../controllers/WOHInspectController.dart';

class WOHInspectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WOHInspectController>(
          () => WOHInspectController(),
    );
    Get.lazyPut<WOHAuthService>(
          () => WOHAuthService(),
    );
    Get.lazyPut<WOHOdooApiClientProvider>(
          () => WOHOdooApiClientProvider(),
    );
  }
}