
// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/WOHUserModel.dart';
import '../repositories/WOHUserRepository.dart';
import 'WOHSettingsService.dart';

class WOHAuthService extends GetxService {
  final user = WOHUserModel().obs;
  late GetStorage _box;
  late WOHUserRepository _usersRepo;

  WOHAuthService() {
    _usersRepo = WOHUserRepository();
    _box = GetStorage();
  }

  Future<WOHAuthService> init() async {
    user.listen((WOHUserModel _user) {
      if (Get.isRegistered<WOHSettingsService>()) {
        Get.find<WOHSettingsService>().address.value.userId = _user.id;
      }
      _box.write('current_user', _user.toJson());
    });
    await getCurrentUser();
    return this;
  }

  Future getCurrentUser() async {
    if (user.value.auth == null && _box.hasData('current_user')) {
      user.value = WOHUserModel.fromJson(await _box.read('current_user'));
      user.value.auth = true;
    } else {
      user.value.auth = false;
    }
  }

  Future removeCurrentUser() async {
    user.value = WOHUserModel();
    await _usersRepo.signOut();
    await _box.remove('current_user');
  }

  bool? get isAuth => user.value.auth ?? false;

  String? get apiToken => (user.value.auth ?? false) ? user.value.apiToken : '';
}