// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';

import '../../../models/WOHAddressModel.dart';
import '../../../services/WOHAuthService.dart';
import '../../../services/WOHSettingsService.dart';
import '../../global_widgets/WOHBlockButtonWidget.dart';
import '../../global_widgets/WOHTextFieldWidget.dart';
import '../../root/controllers/WOHRootController.dart';

class WOHAddressPickerView extends StatelessWidget {
  WOHAddressPickerView();

  @override
  Widget build(BuildContext context) {
    return PlacePicker(
      apiKey: Get.find<WOHSettingsService>().setting.value.googleMapsKey,
      initialPosition: Get.find<WOHSettingsService>().address.value.getLatLng(),
      useCurrentLocation: true,
      selectInitialPosition: true,
      usePlaceDetailSearch: true,
      forceSearchOnZoomChanged: true,
      selectedPlaceWidgetBuilder: (_, selectedPlace, state, isSearchBarFocused) {
        if (isSearchBarFocused) {
          return SizedBox();
        }
        WOHAddressModel _address = WOHAddressModel(address: selectedPlace?.formattedAddress ?? '');
        return FloatingCard(
          height: 300,
          elevation: 0,
          bottomPosition: 0.0,
          leftPosition: 0.0,
          rightPosition: 0.0,
          color: Colors.transparent,
          child: state == SearchingState.Searching
              ? Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    WOHTextFieldWidget(
                      labelText: "Description".tr,
                      hintText: "My Home".tr,
                      //initialValue: _address.description,
                      onChanged: (input) => _address.description = input,
                      iconData: Icons.description_outlined,
                      isFirst: true,
                      isLast: false,
                    ),
                    WOHTextFieldWidget(
                      labelText: "Full WOHAddressModel".tr,
                      hintText: "123 Street, City 136, State, Country".tr,
                      //initialValue: _address.address,
                      onChanged: (input) => _address.address = input,
                      iconData: Icons.place_outlined,
                      isFirst: false,
                      isLast: true,                     
                    ),
                    WOHBlockButtonWidget(
                      onPressed: () async {
                        Get.find<WOHSettingsService>().address.update((val) {
                          if (val == null)return;
                          val.description = _address.description;
                          val.address = _address.address;
                          val.latitude = selectedPlace.geometry.location.lat;
                          val.longitude = selectedPlace.geometry.location.lng;
                          val.userId = Get.find<WOHAuthService>().user.value.id;
                        });
                        /*if (Get.isRegistered<BookEServiceController>()) {
                          await Get.find<BookEServiceController>().getAddresses();
                        }*/
                        if (Get.isRegistered<WOHRootController>()) {
                          await Get.find<WOHRootController>().refreshPage(0);
                        }
                        Get.back();
                      },
                      text: Text(
                        "Pick Here".tr,
                        style: Get.textTheme.titleLarge!.merge(TextStyle(color: Get.theme.primaryColor)),
                      ),
                    ).paddingSymmetric(horizontal: 20),
                    SizedBox(height: 10),
                  ],
                ),
        );
      },
    );
  }
}