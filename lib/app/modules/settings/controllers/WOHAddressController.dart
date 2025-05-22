// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:get/get.dart';

import '../../../../common/WOHUi.dart';
import '../../../models/WOHAddressModel.dart';
import '../../../repositories/WOHSettingRepository.dart';
import '../../../services/WOHAuthService.dart';
import '../../../services/WOHMyAuthService.dart';

class WOHAddressController extends GetxController {
  WOHSettingRepository _settingRepository;
  final addresses = <WOHAddressModel>[].obs;

  WOHAddressController() {
    _settingRepository = new WOHSettingRepository();
  }

  @override
  void onInit() async {
    //await refreshAddresses();
    super.onInit();
  }

/*Future refreshAddresses({bool showMessage}) async {
    await getAddresses();
    if (showMessage == true) {
      Get.showSnackbar(WOHUi.SuccessSnackBar(message: "List of addresses refreshed successfully".tr));
    }
  }

  Future getAddresses() async {
    try {
      if (Get.find<MyAuthService>().myUser.value.email == null) {
        addresses.assignAll(await _settingRepository.getAddresses());
      }
    } catch (e) {
      Get.showSnackbar(WOHUi.ErrorSnackBar(message: e.toString()));
    }
  }*/
}