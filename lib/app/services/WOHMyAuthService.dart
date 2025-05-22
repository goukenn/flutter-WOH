// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import '../models/WOHMyUserModel.dart';
// import '../repositories/user_repository.dart';
// import 'WOHSettingsService.dart';

// class MyAuthService extends GetxService {
//   final myUser? = WOHMyUserModel().obs;
//   GetStorage _box;

//   WOHUserRepository _usersRepo;

//   MyAuthService() {
//     _usersRepo = new WOHUserRepository();
//     _box = new GetStorage();
//   }

//   Future<MyAuthService> init() async {
//     myUser.listen((WOHMyUserModel? _user) {
//       if (Get.isRegistered<WOHSettingsService>()) {
//         //Get.find<WOHSettingsService>().address.value.userId = _user.id;
//       }
//       _box.write('current_user', _user.toJson());
//     });
//     await getCurrentUser();
//     return this;
//   }

//   Future getCurrentUser() async {

//     myUser.value = WOHMyUserModel.fromJson(await _box.read('current_user'));
//     if (_box.hasData('current_user')) {
//       myUser.value = WOHMyUserModel.fromJson(await _box.read('current_user'));
//       //myUser.value.auth = true;
//     } else {
//       //myUser.value.auth = false;
//     }

//     // if (myUser.value.auth == null && _box.hasData('current_user')) {
//     //   myUser.value = WOHMyUserModel.fromJson(await _box.read('current_user'));
//     //   myUser.value.auth = true;
//     // } else {
//     //   myUser.value.auth = false;
//     // }
//   }

//   Future removeCurrentUser() async {
//     myUser.value = new WOHMyUserModel();
//     await _usersRepo.signOut();
//     await _box.remove('current_user');
//   }

//   //bool? get isAuth => myUser.value.auth ?? false;

//   //String? get apiToken => (myUser.value.auth ?? false) ? myUser.value.apiToken : '';
// }