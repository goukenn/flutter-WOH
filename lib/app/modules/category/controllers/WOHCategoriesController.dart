// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable, unused_field
import 'package:get/get.dart';
 
import '../../../models/WOHCategoryModel.dart';
import '../../../repositories/WOHCategoryRepository.dart';

enum CategoriesLayout { GRID, LIST }

class WOHCategoriesController extends GetxController {
  late WOHCategoryRepository _categoryRepository;

  final categories = <WOHCategoryModel>[].obs;
  final layout = CategoriesLayout.LIST.obs;

  WOHCategoriesController() {
    this._categoryRepository = new WOHCategoryRepository();
  }

/*@override
  Future<void> onInit() async {
    await refreshCategories();
    super.onInit();
  }

  Future refreshCategories({bool showMessage}) async {
    await getCategories();
    if (showMessage == true) {
      Get.showSnackbar(WOHUi.SuccessSnackBar(message: "List of categories refreshed successfully".tr));
    }
  }

  Future getCategories() async {
    try {
      categories.assignAll(await _categoryRepository.getAllWithSubCategories());
    } catch (e) {
      Get.showSnackbar(WOHUi.ErrorSnackBar(message: e.toString()));
    }
  }*/
}