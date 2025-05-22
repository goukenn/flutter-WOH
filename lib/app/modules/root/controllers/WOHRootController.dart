// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../models/WOHCustomPageModel.dart';
import '../../../providers/WOHOdooApiClientProvider.dart';
import '../../../repositories/WOHCustomPageRepository.dart';
import '../../../routes/WOHRoutes.dart';
import '../../../services/WOHMyAuthService.dart';
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
  final customPages = <CustomPage>[].obs;
  WOHNotificationsController _notificationController;
  //WOHNotificationRepository _notificationRepository;
  CustomPageRepository _customPageRepository;
  PackageInfo packageInfo;

  WOHRootController() {
    //_notificationRepository = new WOHNotificationRepository();
    _notificationController = new WOHNotificationsController();
    _customPageRepository = new CustomPageRepository();
  }

  @override
  void onInit() async {
    await getNotificationsCount();
    super.onInit();

    packageInfo = await PackageInfo.fromPlatform();
  }

  List<Widget> pages = [
    Home2View(),
    BookingsView(),
    FidelityCardWidget(),
    WOHAccountView(),
  ];

  Widget get currentPage => pages[currentIndex.value];

  Future<void> changePageInRoot(int _index) async {
    Get.lazyPut<AccountController>(()=>AccountController());
    Get.lazyPut<MyAuthService>(
          () => MyAuthService(),
    );
    Get.lazyPut<WOHOdooApiClientProvider>(
          () => WOHOdooApiClientProvider(),
    );
    Get.lazyPut(()=> HomeController());
    //print(Get.find<MyAuthService>().myUser.value.name);
    currentIndex.value = _index;
    await refreshPage(_index);
  }

  Future<void> changePageOutRoot(int _index) async {
    Get.lazyPut<MyAuthService>(
          () => MyAuthService(),
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
          await Get.find<BookingsController>().refreshBookings();
          break;
        }
      case 2:
        {
          ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
            content: Text("chargement des données..."),
            duration: Duration(seconds: 3),
          ));
          await Get.find<HomeController>().getUserDto();
          break;
        }

      case 3:
        {
          Get.lazyPut(()=>AccountController());
          await Get.find<AccountController>().onRefresh();
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