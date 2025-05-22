// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/WOHUi.dart';
import '../../../../main.dart';
import '../../../models/WOHBookingModel.dart';
import '../../../models/WOHReviewModel.dart';
import '../../../repositories/WOHBookingRepository.dart';
import '../../../services/WOHAuthService.dart';
import '../../../services/WOHMyAuthService.dart';
import '../../root/controllers/WOHRootController.dart';
import 'package:http/http.dart' as http;

class WOHRatingController extends GetxController {

  var shippingDto = {}.obs;
  var travellerId = 0.obs;
  var clicked = false.obs;
  var comment = "".obs;
  var rate = 0.obs;
  BookingRepository _bookingRepository;

  WOHRatingController() {
    _bookingRepository = new BookingRepository();
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

    print("$comment, ${Get.find<MyAuthService>().myUser.value.id}");

    var headers = {
      'Accept': 'application/json',
      'Authorization': WOHConstants.authorization
    };
    var request = http.Request('POST', Uri.parse('${WOHConstants.serverPort}/create/res.partner.rating?values=%7B%0A%20%20%22'
        'rater_id%22%3A%20${Get.find<MyAuthService>().myUser.value.id}%2C%0A%20%20%22'
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
      Navigator.pop(Get.context);
    }
    else {
      var data = await response.stream.bytesToString();
      print(data);
      Get.showSnackbar(WOHUi.ErrorSnackBar(message: json.decode(data)['message']));
    }
  }
}