// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/WOHUi.dart';
import '../../../../WOHConstants.dart';
import '../../../repositories/WOHBookingRepository.dart';
import '../../../services/WOHMyAuthService.dart';
import 'package:http/http.dart' as http;

class WOHRatingController extends GetxController {

  var shippingDto = {}.obs;
  var travellerId = 0.obs;
  var clicked = false.obs;
  var comment = "".obs;
  var rate = 0.obs;
  late WOHBookingRepository _bookingRepository;

  WOHRatingController() {
    _bookingRepository = new WOHBookingRepository();
  }

  @override
  void onInit() {
    var arguments = Get.arguments as Map<String, dynamic>;
    shippingDto.value = arguments['shippingDetails'];
    travellerId.value = arguments['travellerId'];

    //review.value.eService = booking.value.eService;
    super.onInit();
  }

  rateTraveller(int shipping_id)async{

    print("$comment, ${Get.find<WOHMyAuthService>().myUser.value.id}");

    var headers = {
      'Accept': 'application/json',
      'Authorization': WOHConstants.authorization
    };
    var request = http.Request('POST', Uri.parse('${WOHConstants.serverPort}/create/res.partner.rating?values=%7B%0A%20%20%22'
        'rater_id%22%3A%20${Get.find<WOHMyAuthService>().myUser.value.id}%2C%0A%20%20%22'
        'rated_id%22%3A%20${travellerId.value}%2C%0A%20%20%22'
        'shipping_id%22%3A%20$shipping_id%2C%0A%20%20%22'
        'rating%22%3A%20%22${rate.value}%22%2C%0A%20%20%22'
        'comment%22%3A%20%22${comment.value}%22%0A%7D&'
        'with_context=%7B%7D&with_company=1'
    ));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      clicked.value = false;
      print(data);
      Get.showSnackbar(WOHUi.SuccessSnackBar(message: "Rating made successfully "));
      Navigator.pop(Get.context!);
    }
    else {
      var data = await response.stream.bytesToString();
      print(data);
      Get.showSnackbar(WOHUi.ErrorSnackBar(message: json.decode(data)['message']));
    }
  }
}