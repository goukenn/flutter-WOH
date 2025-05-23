// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:get/get.dart';

import '../../../../common/WOHUi.dart';
import '../../../models/WOHAwardModel.dart';
import '../../../models/WOHEProviderModel.dart';
import '../../../models/WOHEServiceModel.dart';
import '../../../models/WOHExperienceModel.dart';
import '../../../models/WOHMediaModel.dart';
import '../../../models/WOHMessageModel.dart';
import '../../../models/WOHReviewModel.dart';
import '../../../models/WOHUserModel.dart'; 
import '../../../repositories/WOHEProviderRepository.dart';
import '../../../routes/WOHRoutes.dart';

class WOHEProviderController extends GetxController {
  final eProvider = WOHEProviderModel().obs;
  final reviews = <WOHReviewModel>[].obs;
  final awards = <WOHAwardModel>[].obs;
  final galleries = <WOHMediaModel>[].obs;
  final experiences = <WOHExperienceModel>[].obs;
  final featuredEServices = <WOHEServiceModel>[].obs;
  final currentSlide = 0.obs;
  late String heroTag = "";
  late WOHEProviderRepository _eProviderRepository;

  WOHEProviderController() {
    _eProviderRepository = new WOHEProviderRepository();
  }

  @override
  void onInit() {
    var arguments = Get.arguments as Map<String, dynamic>;
    eProvider.value = arguments['eProvider'] as WOHEProviderModel;
    heroTag = arguments['heroTag'] as String;
    super.onInit();
  }

  @override
  void onReady() async {
    await refreshEProvider();
    super.onReady();
  }

  Future refreshEProvider({bool showMessage = false}) async {
    await getEProvider();
    await getFeaturedEServices();
    await getAwards();
    await getExperiences();
    await getGalleries();
    await getReviews();
    if (showMessage) {
      Get.showSnackbar(WOHUi.SuccessSnackBar(message: eProvider.value.name! + " " + "page refreshed successfully".tr));
    }
  }

  Future getEProvider() async {
    try {
      eProvider.value = await _eProviderRepository.get(getEProviderId());
    } catch (e) {
      Get.showSnackbar(WOHUi.ErrorSnackBar(message: e.toString()));
    }
  }

  Future getFeaturedEServices() async {
    try {
      featuredEServices.assignAll(await _eProviderRepository.getFeaturedEServices(getEProviderId(), page: 1));
    } catch (e) {
      Get.showSnackbar(WOHUi.ErrorSnackBar(message: e.toString()));
    }
  }

  Future getReviews() async {
    try {
      reviews.assignAll(await _eProviderRepository.getReviews(eProvider.value.id!));
    } catch (e) {
      Get.showSnackbar(WOHUi.ErrorSnackBar(message: e.toString()));
    }
  }

  Future getAwards() async {
    try {
      awards.assignAll(await _eProviderRepository.getAwards(getEProviderId()));
    } catch (e) {
      Get.showSnackbar(WOHUi.ErrorSnackBar(message: e.toString()));
    }
  }

  Future getExperiences() async {
    try {
      experiences.assignAll(await _eProviderRepository.getExperiences(getEProviderId()));
    } catch (e) {
      Get.showSnackbar(WOHUi.ErrorSnackBar(message: e.toString()));
    }
  }

  Future getGalleries() async {
    try {
      final _galleries = await _eProviderRepository.getGalleries(getEProviderId());
      galleries.assignAll(_galleries.map((e) {
        e.image!.name = e.description;
        return e.image!;
      }));
    } catch (e) {
      Get.showSnackbar(WOHUi.ErrorSnackBar(message: e.toString()));
    }
  }
  String getEProviderId(){
    return eProvider.value.id!;
  }

  void startChat() {
    List<WOHUserModel> _employees = eProvider.value.employees!.map((e) {
      e.avatar = eProvider.value.images![0];
      return e;
    }).toList();
    WOHMessageModel _message = new WOHMessageModel(_employees, name: eProvider.value.name);
    Get.toNamed(WOHRoutes.CHAT, arguments: _message);
  }
}