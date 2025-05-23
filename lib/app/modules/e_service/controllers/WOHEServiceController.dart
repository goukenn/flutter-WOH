// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:com_igkdev_new_app/WOHColorConstants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/WOHUi.dart';
import '../../../models/WOHEServiceModel.dart'; 
import '../../../models/WOHOptionGroupModel.dart';
import '../../../models/WOHOptionModel.dart';
import '../../../models/WOHReviewModel.dart';
import '../../../repositories/WOHEServiceRepository.dart';

class WOHEServiceController extends GetxController {
  final eService = WOHEServiceModel().obs;
  final reviews = <WOHReviewModel>[].obs;
  final optionGroups = <WOHOptionGroupModel>[].obs;
  final currentSlide = 0.obs;
  final quantity = 1.obs;
  final heroTag = ''.obs;
  late WOHEServiceRepository _eServiceRepository;

  WOHEServiceController() {
    _eServiceRepository = new WOHEServiceRepository();
  }

  @override
  void onInit() async {
    var arguments = Get.arguments as Map<String, dynamic>;
    eService.value = arguments['eService'] as WOHEServiceModel;
    heroTag.value = arguments['heroTag'] as String;
    super.onInit();
  }

  @override
  void onReady() async {
    await refreshEService();
    super.onReady();
  }

  Future refreshEService({bool showMessage = false}) async {
    /*await getEService();
    await getReviews();
    await getOptionGroups();*/
    if (showMessage) {
      Get.showSnackbar(WOHUi.SuccessSnackBar(message: eService.value.name! + " " + "page refreshed successfully".tr));
    }
  }

  /*Future getEService() async {
    try {
      eService.value = await _eServiceRepository.get(eService.value.id);
    } catch (e) {
      Get.showSnackbar(WOHUi.ErrorSnackBar(message: e.toString()));
    }
  }

  Future getReviews() async {
    try {
      reviews.assignAll(await _eServiceRepository.getReviews(eService.value.id));
    } catch (e) {
      Get.showSnackbar(WOHUi.ErrorSnackBar(message: e.toString()));
    }
  }

  Future getOptionGroups() async {
    try {
      var _optionGroups = await _eServiceRepository.getOptionGroups(eService.value.id);
      optionGroups.assignAll(_optionGroups.map((element) {
        element.options.removeWhere((option) => option.eServiceId != eService.value.id);
        return element;
      }));
    } catch (e) {
      Get.showSnackbar(WOHUi.ErrorSnackBar(message: e.toString()));
    }
  }

  Future addToFavorite() async {
    try {
      WOHFavoriteModel _favorite = new WOHFavoriteModel(
        eService: this.eService.value,
        userId: Get.find<WOHAuthService>().user.value.id,
        options: getCheckedOptions(),
      );
      await _eServiceRepository.addFavorite(_favorite);
      eService.update((val) {
        val.isFavorite = true;
      });
      if (Get.isRegistered<FavoritesController>()) {
        Get.find<FavoritesController>().refreshFavorites();
      }
      Get.showSnackbar(WOHUi.SuccessSnackBar(message: this.eService.value.name + " Added to favorite list".tr));
    } catch (e) {
      Get.showSnackbar(WOHUi.ErrorSnackBar(message: e.toString()));
    }
  }

  Future removeFromFavorite() async {
    try {
      WOHFavoriteModel _favorite = new WOHFavoriteModel(
        eService: this.eService.value,
        userId: Get.find<WOHAuthService>().user.value.id,
      );
      await _eServiceRepository.removeFavorite(_favorite);
      eService.update((val) {
        val.isFavorite = false;
      });
      if (Get.isRegistered<FavoritesController>()) {
        Get.find<FavoritesController>().refreshFavorites();
      }
      Get.showSnackbar(WOHUi.SuccessSnackBar(message: this.eService.value.name + " Removed from favorite list".tr));
    } catch (e) {
      Get.showSnackbar(WOHUi.ErrorSnackBar(message: e.toString()));
    }
  }*/

  void selectOption(WOHOptionGroupModel optionGroup, WOHOptionModel option) {
    optionGroup.options!.forEach((e) {
      if (!optionGroup.allowMultiple! && option != e) {
        e.checked = false;
        // e.checked! = false;
      }
    });
    option.checked = !option.checked!;
  }

  List getCheckedOptions() {
    if (optionGroups.isNotEmpty) {
      return optionGroups.map((element) => element.options).expand(
          (element) => element!
      ).toList().where((option) => option.checked!).toList();
      
      // !.expand(
      //   (element) => element).toList().where((option) => option.checked!).toList();
    }
    return [];
  }

  TextStyle getTitleTheme(WOHOptionModel option) {
    if (option.checked!) {
      return Get.textTheme.bodyMedium!.merge(TextStyle(color: Get.theme.colorScheme.secondary));
    }
    return Get.textTheme.bodyMedium!;
  }

  TextStyle getSubTitleTheme(WOHOptionModel option) {
    if (option.checked!) {
      return Get.textTheme.labelSmall!.merge(TextStyle(color: Get.theme.colorScheme.secondary));
    }
    return Get.textTheme.labelSmall!;
  }

  Color getColor(WOHOptionModel option) {
    if (option.checked!) {
      return Get.theme.colorScheme.secondary.withAlpha((255 * 0.1).toInt());
    }
    return primaryColor;
  }

  void incrementQuantity() {
    quantity.value < 1000 ? quantity.value++ : null;
  }

  void decrementQuantity() {
    quantity.value > 1 ? quantity.value-- : null;
  }
}