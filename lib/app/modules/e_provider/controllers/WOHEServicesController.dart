// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/WOHEProviderModel.dart';
import '../../../models/WOHEServiceModel.dart';
import '../../../repositories/WOHEProviderRepository.dart';

enum CategoryFilter { ALL, AVAILABILITY, RATING, FEATURED, POPULAR }

class EServicesController extends GetxController {
  final eProvider = new EProvider().obs;
  final selected = Rx<CategoryFilter>(CategoryFilter.ALL);
  final eServices = <EService>[].obs;
  final page = 0.obs;
  final isLoading = true.obs;
  final isDone = false.obs;
  EProviderRepository _eProviderRepository;
  ScrollController scrollController = ScrollController();

  EServicesController() {
    _eProviderRepository = new EProviderRepository();
  }

  @override
  Future<void> onInit() async {
    eProvider.value = Get.arguments as EProvider;
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

  Future refreshEServices({bool showMessage}) async {
    toggleSelected(selected.value);
    await loadEServicesOfCategory(filter: selected.value);
    if (showMessage == true) {
      Get.showSnackbar(WOHUi.SuccessSnackBar(message: "List of services refreshed successfully".tr));
    }
  }

  bool isSelected(CategoryFilter filter) => selected == filter;

  void toggleSelected(CategoryFilter filter) {
    this.eServices.clear();
    this.page.value = 0;
    if (isSelected(filter)) {
      selected.value = CategoryFilter.ALL;
    } else {
      selected.value = filter;
    }
  }

  Future loadEServicesOfCategory({CategoryFilter filter}) async {
    try {
      isLoading.value = true;
      isDone.value = false;
      this.page.value++;
      List<EService> _eServices = [];
      switch (filter) {
        case CategoryFilter.ALL:
          _eServices = await _eProviderRepository.getEServices(eProvider.value.id, page: this.page.value);
          break;
        case CategoryFilter.FEATURED:
          _eServices = await _eProviderRepository.getFeaturedEServices(eProvider.value.id, page: this.page.value);
          break;
        case CategoryFilter.POPULAR:
          _eServices = await _eProviderRepository.getPopularEServices(eProvider.value.id, page: this.page.value);
          break;
        case CategoryFilter.RATING:
          _eServices = await _eProviderRepository.getMostRatedEServices(eProvider.value.id, page: this.page.value);
          break;
        case CategoryFilter.AVAILABILITY:
          _eServices = await _eProviderRepository.getAvailableEServices(eProvider.value.id, page: this.page.value);
          break;
        default:
          _eServices = await _eProviderRepository.getEServices(eProvider.value.id, page: this.page.value);
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