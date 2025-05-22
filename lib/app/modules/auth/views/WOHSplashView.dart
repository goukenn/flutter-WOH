// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/WOHAuthController.dart';
import 'WOHLoginView.dart';

class SplashView extends GetView<AuthController>{

  @override
  Widget build(BuildContext context) {

    return AnimatedSplashScreen.withScreenFunction(
      splash: Image.asset("assets/img/photo_2022-11-25_01-12-07.jpg"),
      duration: 5000,
      splashIconSize: double.infinity,
      screenFunction: () async{
        return LoginView();
      },
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: Colors.white,
      //pageTransitionType: PageTransitionType.scale,
    );
  }
}