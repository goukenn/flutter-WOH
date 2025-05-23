// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors

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

  bool get isAuth => user.value.auth ?? false;

  String get apiToken => (user.value.auth ?? false) ? user.value.apiToken! : '';
}