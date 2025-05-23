// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:get/get.dart';

import '../../../../common/WOHUi.dart';
import '../../../models/WOHCustomPageModel.dart';
import '../../../repositories/WOHCustomPageRepository.dart';

class WOHCustomPagesController extends GetxController {
  final customPage = WOHCustomPageModel().obs;
  late WOHCustomPageRepository _customPageRepository;

  WOHCustomPagesController() {
    _customPageRepository = WOHCustomPageRepository();
  }

  @override
  void onInit() {
    customPage.value = Get.arguments as WOHCustomPageModel;
    super.onInit();
  }

  @override
  void onReady() async {
    await refreshCustomPage();
    super.onReady();
  }

  @override
  void onClose() {}

  Future<void> refreshCustomPage({bool showMessage = false}) async {
    await getCustomPage();
    if (showMessage) {
      Get.showSnackbar(WOHUi.SuccessSnackBar(message: "Page refreshed successfully".tr));
    }
  }

  Future<void> getCustomPage() async {
    try {
      customPage.value = await _customPageRepository.get(customPage.value.id!);
    } catch (e) {
      print(e.toString());
      //Get.showSnackbar(WOHUi.ErrorSnackBar(message: e.toString()));
    }
  }
}