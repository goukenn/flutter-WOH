// ignore_for_file: unnecessary_new

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/WOHMyUserModel.dart'; 
import '../repositories/WOHUserRepository.dart'; 
import 'WOHSettingsService.dart'; 

class WOHMyAuthService extends GetxService {
  final myUser = WOHMyUserModel().obs;
  late GetStorage _box; 
  late WOHUserRepository _usersRepo;

  WOHMyAuthService() {
    _usersRepo = new WOHUserRepository();
    _box = new GetStorage();
  }

  Future<WOHMyAuthService> init() async {
    myUser.listen((WOHMyUserModel _user) {
      if (Get.isRegistered<WOHSettingsService>()) {
        //Get.find<SettingsService>().address.value.userId = _user.id;
      }
      _box.write('current_user', _user.toJson());
    });
    await getCurrentUser();
    return this;
  }

  Future getCurrentUser() async {

    myUser.value = WOHMyUserModel.fromJson(await _box.read('current_user'));
    if (_box.hasData('current_user')) {
      myUser.value = WOHMyUserModel.fromJson(await _box.read('current_user'));
      //myUser.value.auth = true;
    } else {
      //myUser.value.auth = false;
    }

    // if (myUser.value.auth == null && _box.hasData('current_user')) {
    //   myUser.value = WOHMyUserModel.fromJson(await _box.read('current_user'));
    //   myUser.value.auth = true;
    // } else {
    //   myUser.value.auth = false;
    // }
  }

  Future removeCurrentUser() async {
    myUser.value = new WOHMyUserModel();
    await _usersRepo.signOut();
    await _box.remove('current_user');
  }

  //bool get isAuth => myUser.value.auth ?? false;

  //String get apiToken => (myUser.value.auth ?? false) ? myUser.value.apiToken : '';
}
