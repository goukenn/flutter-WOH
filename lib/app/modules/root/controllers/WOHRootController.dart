// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../models/WOHCustomPageModel.dart';
import '../../../providers/WOHOdooApiClientProvider.dart';
import '../../../repositories/WOHCustomPageRepository.dart';
import '../../../routes/WOHRoutes.dart';
import '../../../services/WOHAuthService.dart';
import '../../account/controllers/WOHAccountController.dart';
import '../../account/views/WOHAccountView.dart';
import '../../home/controllers/WOHHomeController.dart';
import '../../home/views/WOHHome2View.dart';
import '../../home/widgets/WOHFidelityCardView.dart';
import '../../notifications/controllers/WOHNotificationsController.dart';
import '../../userBookings/controllers/WOHBookingsController.dart';
import '../../userBookings/views/WOHBookingsView.dart';

class WOHRootController extends GetxController {
  final currentIndex = 0.obs;
  final notificationsCount = 0.obs;
  final customPages = <WOHCustomPageModel>[].obs;
  late WOHNotificationsController _notificationController;
  //WOHNotificationRepository _notificationRepository;
  late WOHCustomPageRepository _customPageRepository;
  late PackageInfo packageInfo;

  WOHRootController() {
    //_notificationRepository = new WOHNotificationRepository();
    _notificationController = new WOHNotificationsController();
    _customPageRepository = new WOHCustomPageRepository();
  }

  @override
  void onInit() async {
    getNotificationsCount();
    super.onInit();

    packageInfo = await PackageInfo.fromPlatform();
  }

  List<Widget> pages = [
    WOHHome2View(),
    WOHBookingsView(),
    WOHFidelityCardView(),
    WOHAccountView(),
  ];

  Widget get currentPage => pages[currentIndex.value];

  Future<void> changePageInRoot(int _index) async {
    Get.lazyPut<WOHAccountController>(()=>WOHAccountController());
    Get.lazyPut<WOHAuthService>(
          () => WOHAuthService(),
    );
    Get.lazyPut<WOHOdooApiClientProvider>(
          () => WOHOdooApiClientProvider(),
    );
    Get.lazyPut(()=> WOHHomeController());
    //print(Get.find<WOHMyAuthService>().myUser.value.name);
    currentIndex.value = _index;
    await refreshPage(_index);
  }

  Future<void> changePageOutRoot(int _index) async {
    Get.lazyPut<WOHAuthService>(
          () => WOHAuthService(),
    );
    Get.lazyPut<WOHOdooApiClientProvider>(
          () => WOHOdooApiClientProvider(),
    );
    currentIndex.value = _index;
    await refreshPage(_index);
    await Get.offNamedUntil(WOHRoutes.ROOT, (Route route) {
      if (route.settings.name == WOHRoutes.ROOT) {
        return true;
      }
      return false;
    }, arguments: _index);
  }

  Future<void> changePage(int _index) async {
    if (Get.currentRoute == WOHRoutes.ROOT) {
      await changePageInRoot(_index);
    } else {
      await changePageOutRoot(_index);
    }
  }

  Future<void> refreshPage(int _index) async {
    switch (_index) {
      case 0:
        {
          break;
        }
      case 1:
        {
          await Get.find<WOHBookingsController>().refreshBookings();
          break;
        }
      case 2:
        {
          ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
            content: Text("chargement des données..."),
            duration: Duration(seconds: 3),
          ));
          await Get.find<WOHHomeController>().getUserDto();
          break;
        }

      case 3:
        {
          Get.lazyPut(()=>WOHAccountController());
          await Get.find<WOHAccountController>().onRefresh();
          break;
        }
    }
  }

  void getNotificationsCount() async {
    var count = 0;
    var list = await _notificationController.getNotifications();
    for(int i =0; i<list.length; i++ ){
        if(list[i].isSeen == false){
          count = count +1;
        }


    }
    notificationsCount.value =count;
    print('Notification: '+notificationsCount.toString());
  }
}