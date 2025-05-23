// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../../../../common/WOHUi.dart';
import '../../../../WOHConstants.dart';
import '../../../models/WOHMyUserModel.dart';
import '../../../repositories/WOHUserRepository.dart';
import '../../../routes/WOHRoutes.dart';
import '../../../services/WOHMyAuthService.dart';
import '../../../services/WOHSettingsService.dart';
import '../../global_widgets/WOHPhoneVerificationBottomSheetWidget.dart';

class WOHProfileController extends GetxController {
  final user = new WOHMyUserModel().obs;
  var url = ''.obs;
  //final Rx<WOHMyUserModel> currentUser = Get.find<WOHMyAuthService>().myUser;
  final hidePassword = true.obs;
  final oldPassword = "".obs;
  final newPassword = "".obs;
  final userName = "".obs;
  final email = "".obs;
  final gender = "".obs;
  var editNumber = false.obs;
  final confirmPassword = "".obs;
  final smsSent = "".obs;
  final buttonPressed = false.obs;
  var birthDate = ''.obs;
  final birthPlace = "".obs;
  final phone = "".obs;
  var selectedGender = "".obs;
  final editProfile = false.obs;
  final editPassword = false.obs;
  var birthDateSet = false.obs;
  var genderList = [
    "MALE".tr,
    "FEMALE".tr
  ].obs;

  var departureId = 0.obs;
  var arrivalId = 0.obs;


  var predict1 = false.obs;
  var predict2 = false.obs;
  //File passport;
  var countries = [].obs;
  var list = [];

  ScrollController scrollController = ScrollController();
  final formStep = 0.obs;
  TextEditingController depTown = TextEditingController();
  TextEditingController arrTown = TextEditingController();



  GlobalKey<FormState> profileForm;
  WOHUserRepository _userRepository;

  WOHProfileController() {
    _userRepository = new WOHUserRepository();
  }

  @override
  void onInit() {
    final box = GetStorage();
    list = box.read("allCountries");
    countries.value = list;

    print('List is sssssss:   '+countries.value.toString());
    profileForm = new GlobalKey<FormState>();



    user.value = Get.find<WOHMyAuthService>().myUser.value;
    selectedGender.value = genderList.elementAt(0);
    user.value?.birthday = user.value.birthday;
    //user.value.phone = user.value.phone;
    birthDate.value = user.value.birthday;
    super.onInit();
  }

  Future refreshProfile({bool showMessage}) async {
    await getUser();
    if (showMessage == true) {
      Get.showSnackbar(WOHUi.SuccessSnackBar(message: "List of faqs refreshed successfully".tr));
    }
  }

  void saveProfileForm() async {
    Get.focusScope.unfocus();
    if (profileForm.currentState.validate()) {
      //try {
      profileForm.currentState.save();

       await _userRepository.update(user.value);
      user.value = await _userRepository.get(user.value.id);
      Get.find<WOHMyAuthService>().myUser.value = user.value;
      buttonPressed.value = false;
      Get.showSnackbar(WOHUi.SuccessSnackBar(message: "Profile updated successfully".tr));
      await Get.toNamed(WOHRoutes.ROOT);
      //}
      // } catch (e) {
      //   Get.showSnackbar(WOHUi.ErrorSnackBar(message: e.toString()));
      // } finally {}
    } else {
      Get.showSnackbar(WOHUi.ErrorSnackBar(message: "There are errors in some fields please correct them!".tr));
    }
  }

  void filterSearchResults(String query) {
    List dummySearchList = [];
    dummySearchList = list;
    if(query.isNotEmpty) {
      List dummyListData = [];
      dummyListData = dummySearchList.where((element) => element['display_name']
          .toString().toLowerCase().contains(query.toLowerCase()) ).toList();
      countries.value = dummyListData;
      for(var i in countries){
        print(i['display_name']);
      }
      return;
    } else {
      countries.value = list;
    }
  }


  chooseBirthDate() async {
    DateTime pickedDate = await showRoundedDatePicker(

        context: Get.context!,

        imageHeader: AssetImage("assets/img/istockphoto-1421193265-612x612.jpg"),
        initialDate: DateTime.now().subtract(Duration(days: 1)),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        styleDatePicker: MaterialRoundedDatePickerStyle(
            textStyleYearButton: TextStyle(
              fontSize: 52,
              color: Colors.white,
            )
        ),
        borderRadius: 16,
        selectableDayPredicate: disableDate
    );
    if (pickedDate != null && pickedDate != birthDate.value) {
      birthDate.value = DateFormat('dd/MM/yy').format(pickedDate);
      user.value.birthday = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }

  bool disableDate(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(Duration(days: 1))))) {
      return false;
    }
    return true;
  }

  void resetProfileForm() {
    //avatar.value = new WOHMediaModel(thumb: user.value.avatar.thumb);
    profileForm.currentState.reset();
  }

  Future getUser() async {
    try {
      user.value = await _userRepository.get(user.value.userId);
    } catch (e) {
      Get.showSnackbar(WOHUi.ErrorSnackBar(message: e.toString()));
    }
  }

  Future<void> deleteUser() async {
    try {
      //await _userRepository.deleteCurrentUser();
    } catch (e) {
      Get.showSnackbar(WOHUi.ErrorSnackBar(message: e.toString()));
    }
  }
}