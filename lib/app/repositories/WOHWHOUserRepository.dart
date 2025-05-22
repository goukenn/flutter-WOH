// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable, empty_constructor_bodies
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/WOHMyUserModel.dart';
import '../models/WOHUserModel.dart';
import '../providers/WOHFirebaseProviderProvider.dart';
import '../providers/WOHLaravelApiClientProvider.dart';
import '../providers/WOHOdooApiClientProvider.dart';
import '../services/WOHAuthService.dart';
import '../services/WOHMyAuthService.dart';

class WOHWHOUserRepository {
  // late WOHLaravelApiClientProvider _laravelApiClient;
  late WOHOdooApiClientProvider _odooApiClient;
  late WOHFirebaseProviderProvider _firebaseProvider;

  WOHWHOUserRepository(){}

  Future login<int>(MyUser myUser) async {
    _odooApiClient = Get.find<WOHOdooApiClientProvider>();
    // return _odooApiClient.login(myUser);
    return 0;
  }

  Future<MyUser?> get(int id) async {
    _odooApiClient = Get.find<WOHOdooApiClientProvider>();
    // return _odooApiClient.getUser(id);
    return null;
  }

  update(MyUser myUser) {
    //print("Nath");
    _odooApiClient = Get.find<WOHOdooApiClientProvider>();
    //print("Nathalie");
    return _odooApiClient.updateUser(myUser);
  }

  Future<bool> register(MyUser myUser) async {
    // _laravelApiClient = Get.find<WOHLaravelApiClientProvider>();
    // return _laravelApiClient.register(user);
    _odooApiClient = Get.find<WOHOdooApiClientProvider>();

    // return _odooApiClient.register(myUser);
    return false;
  }

  Future signOut() async {
    _firebaseProvider = Get.find<WOHFirebaseProviderProvider>();
    return await _firebaseProvider.signOut();
  }
}
