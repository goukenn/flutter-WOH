// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:get/get.dart';

import '../../../providers/WOHOdooApiClientProvider.dart';
import '../../../services/WOHAuthService.dart';
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
    Get.lazyPut<WOHAccountController>(
      () => WOHAccountController(),
    );
    Get.lazyPut<WOHAuthService>(
          () => WOHAuthService(),
    );
    Get.lazyPut<WOHOdooApiClientProvider>(
          () => WOHOdooApiClientProvider(),
    );
  }
}