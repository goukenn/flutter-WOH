// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/WOHUi.dart'; 
import '../../../models/WOHCategoryModel.dart';
import '../../../models/WOHEServiceModel.dart';
import '../../../repositories/WOHCategoryRepository.dart';
import '../../../repositories/WOHEServiceRepository.dart';

class WOHSearchController extends GetxController {
  final heroTag = "".obs;
  final categories = <WOHCategoryModel>[].obs;
  final selectedCategories = <String>[].obs;
  late TextEditingController textEditingController;
  var allTravels = [].obs;
  Rx<List<Map<String, dynamic>>> items =
  Rx<List<Map<String, dynamic>>>([]);
  final allPlayers = [
    {"name": "Rohit Sharma", "country": "India"},
    {"name": "Virat Kohli ", "country": "India"},
    {"name": "Glenn Maxwell", "country": "Australia"},
    {"name": "Aaron Finch", "country": "Australia"},
    {"name": "Martin Guptill", "country": "New Zealand"},
    {"name": "Trent Boult", "country": "New Zealand"},
    {"name": "David Miller", "country": "South Africa"},
    {"name": "Kagiso Rabada", "country": "South Africa"},
    {"name": "Chris Gayle", "country": "West Indies"},
    {"name": "Jason Holder", "country": "West Indies"},
  ].obs;

  final eServices = <WOHEServiceModel>[].obs;
  late WOHEServiceRepository _eServiceRepository;
  late WOHCategoryRepository _categoryRepository;

  WOHSearchController() {
    _eServiceRepository = new WOHEServiceRepository();
    _categoryRepository = new WOHCategoryRepository();
    textEditingController = new TextEditingController();
  }

  @override
  void onInit() async {
    await refreshSearch();
    items.value = allPlayers;
    super.onInit();
  }

  @override
  void onReady() {
    heroTag.value = Get.arguments.toString();
    super.onReady();
  }

  void filterSearchResults(String query) {
    List dummySearchList = [];
    dummySearchList = allPlayers;
    if(query.isNotEmpty) {
      List dummyListData = [];
      dummyListData = dummySearchList.where((element) => element['name']
          .toString().toLowerCase().contains(query.toLowerCase())).toList();
      items.value = dummyListData[0];
      return;
    } else {
      items.value = allPlayers;
    }
  }

  Future refreshSearch({bool showMessage = false}) async {
    await getCategories();
    await searchEServices();
    if (showMessage == true) {
      Get.showSnackbar(WOHUi.SuccessSnackBar(message: "List of services refreshed successfully".tr));
    }
  }

  Future searchEServices({String keywords=''}) async {
    try {
      if (selectedCategories.isEmpty) {
        eServices.assignAll(await _eServiceRepository.search(keywords, categories.map((element) => element.id!).toList()));
      } else {
        eServices.assignAll(await _eServiceRepository.search(keywords, selectedCategories.toList()));
      }
    } catch (e) {
      Get.showSnackbar(WOHUi.ErrorSnackBar(message: e.toString()));
    }
  }

  Future getCategories() async {
    try {
      categories.assignAll(await _categoryRepository.getAllParents());
    } catch (e) {
      Get.showSnackbar(WOHUi.ErrorSnackBar(message: e.toString()));
    }
  }

  bool isSelectedCategory(WOHCategoryModel category) {
    return selectedCategories.contains(category.id);
  }

  void toggleCategory(bool value, WOHCategoryModel category) {
    if (value) {
      selectedCategories.add(category.id!);
    } else {
      selectedCategories.removeWhere((element) => element == category.id);
    }
  }
}