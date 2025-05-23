// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:get/get.dart';

import '../services/WOHAuthService.dart';

class WOHFirebaseProviderProvider extends GetxService {
  fba.FirebaseAuth _auth = fba.FirebaseAuth.instance;

  Future<WOHFirebaseProviderProvider> init() async {
    return this;
  }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      fba.UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (result.user != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return await signUpWithEmailAndPassword(email, password);
    }
  }

  Future<bool> signUpWithEmailAndPassword(String email, String password) async {
    fba.UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    if (result.user != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> verifyPhone(String smsCode) async {
    try {
      final fba.AuthCredential credential = fba.PhoneAuthProvider.credential(verificationId: Get.find<WOHAuthService>().user.value.verificationId!, smsCode: smsCode);
      await fba.FirebaseAuth.instance.signInWithCredential(credential);
      Get.find<WOHAuthService>().user.value.verifiedPhone = true;
    } catch (e) {
      Get.find<WOHAuthService>().user.value.verifiedPhone = false;
      throw Exception(e.toString());
    }
  }

  Future<void> sendCodeToPhone() async {
    Get.find<WOHAuthService>().user.value.verificationId = '';
    final fba.PhoneCodeAutoRetrievalTimeout autoRetrieve = (String? verId) {};
    final fba.PhoneCodeSent smsCodeSent = (String? verId, [int? forceCodeResent]) {
      Get.find<WOHAuthService>().user.value.verificationId = verId;
    };
    final fba.PhoneVerificationCompleted _verifiedSuccess = (fba.AuthCredential auth) async {};
    final fba.PhoneVerificationFailed _verifyFailed = (fba.FirebaseAuthException e) {
      throw Exception(e.message);
    };
    await _auth.verifyPhoneNumber(
      phoneNumber: Get.find<WOHAuthService>().user.value.phoneNumber,
      timeout: const Duration(seconds: 30),
      verificationCompleted: _verifiedSuccess,
      verificationFailed: _verifyFailed,
      codeSent: smsCodeSent,
      codeAutoRetrievalTimeout: autoRetrieve,
    );
  }

  Future signOut() async {
    return await _auth.signOut();
  }

  Future<void> deleteCurrentUser() async {
    return await _auth.currentUser?.delete();
  }
}