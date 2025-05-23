// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
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