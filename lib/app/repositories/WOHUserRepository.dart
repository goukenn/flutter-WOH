// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable, empty_constructor_bodies
import 'package:get/get.dart';

import '../models/WOHMyUserModel.dart';
import '../providers/WOHFirebaseProviderProvider.dart';
import '../providers/WOHOdooApiClientProvider.dart';

class WOHUserRepository {
  // late WOHLaravelApiClientProvider _laravelApiClient;
  late WOHOdooApiClientProvider _odooApiClient;
  late WOHFirebaseProviderProvider _firebaseProvider;

  WOHUserRepository(){}

  Future login<int>(WOHMyUserModel myUser) async {
    _odooApiClient = Get.find<WOHOdooApiClientProvider>();
    // return _odooApiClient.login(myUser);
    return 0;
  }

  Future<WOHMyUserModel?> get(int id) async {
    _odooApiClient = Get.find<WOHOdooApiClientProvider>();
    // return _odooApiClient.getUser(id);
    return null;
  }

  update(WOHMyUserModel myUser) {
    //print("Nath");
    _odooApiClient = Get.find<WOHOdooApiClientProvider>();
    //print("Nathalie");
    return _odooApiClient.updateUser(myUser);
  }

  Future<bool> register(WOHMyUserModel myUser) async {
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
