// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
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