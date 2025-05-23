// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/WOHUi.dart';
import '../../../models/WOHEProviderModel.dart';
import '../../../models/WOHEServiceModel.dart';
import '../../../repositories/WOHEProviderRepository.dart';

enum CategoryFilter { ALL, AVAILABILITY, RATING, FEATURED, POPULAR }

class WOHEServicesController extends GetxController {
  final eProvider = new WOHEProviderModel().obs;
  final selected = Rx<CategoryFilter>(CategoryFilter.ALL);
  final eServices = <WOHEServiceModel>[].obs;
  final page = 0.obs;
  final isLoading = true.obs;
  final isDone = false.obs;
  late WOHEProviderRepository _eProviderRepository;
  late ScrollController scrollController = ScrollController();

  WOHEServicesController() {
    _eProviderRepository = new WOHEProviderRepository();
  }

  @override
  Future<void> onInit() async {
    eProvider.value = Get.arguments as WOHEProviderModel;
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !isDone.value) {
        loadEServicesOfCategory(filter: selected.value);
      }
    });
    await refreshEServices();
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
  }

  Future refreshEServices({bool showMessage=true}) async {
    toggleSelected(selected.value);
    await loadEServicesOfCategory(filter: selected.value);
    if (showMessage == true) {
      Get.showSnackbar(WOHUi.SuccessSnackBar(message: "List of services refreshed successfully".tr));
    }
  }

  bool isSelected(CategoryFilter filter) => selected.value == filter;

  void toggleSelected(CategoryFilter filter) {
    this.eServices.clear();
    this.page.value = 0;
    if (isSelected(filter)) {
      selected.value = CategoryFilter.ALL;
    } else {
      selected.value = filter;
    }
  }

  Future loadEServicesOfCategory({required CategoryFilter filter}) async {
    try {
      isLoading.value = true;
      isDone.value = false;
      this.page.value++;
      List<WOHEServiceModel> _eServices = [];
      var l = eProvider.value.id!;
      switch (filter) {
        case CategoryFilter.ALL:
          _eServices = await _eProviderRepository.getEServices(l, page: this.page.value);
          break;
        case CategoryFilter.FEATURED:
          _eServices = await _eProviderRepository.getFeaturedEServices(l, page: this.page.value);
          break;
        case CategoryFilter.POPULAR:
          _eServices = await _eProviderRepository.getPopularEServices(l, page: this.page.value);
          break;
        case CategoryFilter.RATING:
          _eServices = await _eProviderRepository.getMostRatedEServices(l, page: this.page.value);
          break;
        case CategoryFilter.AVAILABILITY:
          _eServices = await _eProviderRepository.getAvailableEServices(l, page: this.page.value);
          break;
        // default:
        //   _eServices = await _eProviderRepository.getEServices(l, page: this.page.value);
        //   break;
      }
      if (_eServices.isNotEmpty) {
        this.eServices.addAll(_eServices);
      } else {
        isDone.value = true;
      }
    } catch (e) {
      this.isDone.value = true;
      Get.showSnackbar(WOHUi.ErrorSnackBar(message: e.toString()));
    } finally {
      isLoading.value = false;
    }
  }
}