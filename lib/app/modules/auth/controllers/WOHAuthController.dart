// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'dart:async';
import 'dart:convert'; 
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import '../../../../WOHColorConstants.dart';
import '../../../../WOHConstants.dart';
import '../../../../common/WOHUi.dart'; 
import '../../../../WOHResponsive.dart';
import '../../../routes/WOHRoutes.dart';
import '../../../services/WOHMyAuthService.dart';

class WOHAuthController extends GetxController {
  //final Rx<M>

  final hidePassword = true.obs;
  final loading = false.obs;
  var onClick = false.obs;
  var birthDateSet = false.obs;
  final smsSent = ''.obs;
  var confirmPassword = ''.obs;
  var name = ''.obs;
  var password = ''.obs;
  var email = ''.obs;
  var phone = ''.obs;
  var userId = 0.obs;
  var isChecked = false.obs;
  var isEmployee = false.obs;
  var verifyClicked = false.obs;
  var loginClickable = false.obs;
  var accepted = false.obs;
  var code = ''.obs;
  // GoogleSignIn googleAuth = GoogleSignIn();
  // GoogleSignInAccount googleAccount;
  var users = [].obs;
  var auth;
  var authUserId = 0.obs;
  var resources = [].obs;
  var currentUser = {}.obs;

  PackageInfo? packageInfo;

  @override
  void onInit() async {

    var box = (await GetStorage());
    if(box.read('userEmail')!=null){
      email.value = box.read('userEmail');
    }
    if(box.read('password')!=null){
      password.value = box.read('password');
    }
    if(box.read('checkBox') != null){
      isChecked.value = box.read('checkBox');
    }
    super.onInit();
    packageInfo = await PackageInfo.fromPlatform();

  }

  onTokenReceived(String token) {
    print("FINAL TOKEN===> $token");
  }

 /* Future<void> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    final user = userCredential.user;

    if (user != null) {
      for (final providerProfile in user.providerData) {
        // ID of the provider (google.com, apple.com, etc.)
        final provider = providerProfile.providerId;

        // UID specific to the provider
        final uid = providerProfile.uid;

        // Name, email address, and profile photo URL
        final name = providerProfile.displayName;
        final emailAddress = providerProfile.email;
        //final profilePhoto = providerProfile.photoURL;
        final phone = providerProfile.phoneNumber;
        final photo = providerProfile.photoURL;
        print(photo);

        var found = await getUserByEmail(emailAddress, "");
        if (found){
          //Get.find<WOHMyAuthService>().myUser.value = await _userRepository.get(users[index]['partner_id'][0]['id']);
          //Get.find<WOHMyAuthService>().myUser.value.image = photo;
          WOHConstants.googleUser = true;
          WOHConstants.googleImage = photo;

          var foundDeviceToken= false;
          if(Get.find<WOHMyAuthService>().myUser.value.deviceTokenIds.isNotEmpty)
          {
            var tokensList = await getUserDeviceTokens(Get.find<WOHMyAuthService>().myUser.value.deviceTokenIds);
            for(int i = 0; i<tokensList.length;i++){
              if(WOHConstants.deviceToken==tokensList[i]['token']){
                foundDeviceToken = true;
              }
            }
          }

          loading.value = false;
          *//*if(!foundDeviceToken){
            await saveDeviceToken(WOHConstants.deviceToken, Get.find<WOHMyAuthService>().myUser.value.id);
          }*//*
          Get.showSnackbar(WOHUi.SuccessSnackBar(message: "You signed in successfully " ));
          await Get.toNamed(WOHRoutes.ROOT);

        }
        else{
          await createGoogleUser(name, emailAddress, phone);
          //Get.find<WOHMyAuthService>().myUser.value.image = photo;
          WOHConstants.googleUser = true;
          WOHConstants.googleImage = photo;

          //await saveDeviceToken(WOHConstants.deviceToken, Get.find<WOHMyAuthService>().myUser.value.id);
          Get.showSnackbar(WOHUi.SuccessSnackBar(message: "You signed in successfully " ));
          await Get.toNamed(WOHRoutes.ROOT);

        }
      }
    }
  }*/

  createGoogleUser(String name, String email, String phone ) async {
    this.email.value = email;
    this.name.value = name;
    print(name);
    print(email);
    print(phone);

    var headers = {
      'Accept': 'application/json',
      'Authorization': WOHConstants.authorization,
      'Cookie': 'session_id=dc69145b99f377c902d29e0b11e6ea9bb1a6a1ba'
    };
    var request = http.Request('POST',Uri.parse('${WOHConstants.serverPort}/create/res.users?values={ '
        '"name": "$name",'
        '"login": "$email",'
        //'"email": "$email",'
        '"phone": "$phone",'
        '"sel_groups_1_9_10": 1}'

    ));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200)  {
      var result = await response.stream.bytesToString();
      print(result);
      await login();
    }
    else {
      var data = await response.stream.bytesToString();
      Get.showSnackbar(WOHUi.ErrorSnackBar(message: json.decode(data)['message']));
      //existingPartner = ['testname','https://stock.adobe.com/search?k=admin'];
      //existingPartnerVisible.value = true;
    }
  }

  // googleSignOut() async {
  //   googleAccount = await googleAuth.signOut();
  //
  // }

  getAllUsers()async{
    var headers = {
      'api-key': WOHConstants.apiKey
    };
    var request = http.Request('GET', Uri.parse('${WOHConstants.serverPort2}/res.users/search'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      List list = json.decode(data)['data'];
      users.value = list;
      print("ok");
    }
    else {
      print(response.reasonPhrase);
    }
  }

  void sendResetLink(int userId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': WOHConstants.authorization
    };
    var request = http.Request('POST', Uri.parse('${WOHConstants.serverPort}/call/res.users/action_reset_password?ids=$userId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Get.showSnackbar(WOHUi.SuccessSnackBar(message: "An email has been sent to ${email.value}, please follow the instructions to reset your password".tr ));
      onClick.value = false;
    }
    else {
      onClick.value = false;
      Get.showSnackbar(WOHUi.ErrorSnackBar(message: "User not found!!!" ));
      print(response.reasonPhrase);
    }
  }

  getUserVerification(int id)async{
    print(id);
    var headers = {
      'api-key': WOHConstants.apiKey
    };
    var request = http.Request('GET', Uri.parse('${WOHConstants.serverPort2}/res.users/$id'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var data = json.decode(result)['data'][0];

      if(data['sh_user_from_signup']){

        var foundDeviceToken= false;
        loading.value = false;

        if(Get.find<WOHMyAuthService>().myUser.value.deviceTokenIds.isNotEmpty)
        {
          var tokensList = await getUserDeviceTokens(Get.find<WOHMyAuthService>().myUser.value.deviceTokenIds);
          for(int i = 0; i<tokensList.length;i++){
            if(WOHConstants.deviceToken==tokensList[i]['token']){
              foundDeviceToken = true;
            }
          }

        }
/*
        if(!foundDeviceToken){
          await saveDeviceToken(WOHConstants.deviceToken, Get.find<WOHMyAuthService>().myUser.value.id);
        }
*/
        Get.showSnackbar(WOHUi.SuccessSnackBar(message: "You logged in successfully " ));

        verifyClicked.value = false;

        await Get.toNamed(WOHRoutes.ROOT);

      }else{
        code.value = data['verification_code'].toString();
        loading.value = false;
        Get.toNamed(WOHRoutes.VERIFICATION);
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }

  Future login() async {

    var box = GetStorage();
    isEmployee.value = false;
    loading.value = true;
    print("email: ${email.value} and password: ${password.value}");

    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://willonhair.shintheo.com/web/session/authenticate'));
    request.body = json.encode({
      "jsonrpc": "2.0",
      "params": {
        "db": "willonhair",
        "login": email.value,
        "password": password.value
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var data = json.decode(result)['result'];
      print(data);
      if(data != null){

        currentUser.value = data;
        if(WOHResponsive.isMobile(Get.context!)){

          box.write("userData", data);
          Get.showSnackbar(WOHUi.SuccessSnackBar(message: "connexion réussi, bon retour M/Mme ${data['name']}"));
          loading.value = false;
          Get.toNamed(WOHRoutes.ROOT);

        }else{

          print(data['partner_id']);

          var partnerData = await getSpecificPartner(data['partner_id']);
          print(partnerData);
          var foundDeviceToken= false;

          if(partnerData[0]['fcm_token_ids'].isNotEmpty) {
            var tokensList = await getUserDeviceTokens(partnerData[0]['fcm_token_ids']);
            for(int i = 0; i<tokensList.length;i++){
              if(WOHConstants.deviceToken==tokensList[i]['token']){
                foundDeviceToken = true;
              }
            }
          }

          /*if(!foundDeviceToken){
          await saveDeviceToken(WOHConstants.deviceToken, partnerData[0]['id']);
        }*/

          ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
            content: Text("Verification des information..."),
            backgroundColor: validateColor.withAlpha((255 * 0.4).toInt()),
            duration: Duration(seconds: 3),
          ));

          await getEmployees(data);
        }


      }
      else{
        Get.showSnackbar(WOHUi.ErrorSnackBar(message: "User credentials not matching or existing"));
        loading.value = false;
        return 0;
        //throw new Exception(response.reasonPhrase);
      }
    }
    else {Get.showSnackbar(WOHUi.ErrorSnackBar(message: "An error occurred, please try to login again"));
    loading.value = false;
    }
  }

  Future getSpecificPartner(var id) async{
    var headers = {
      'Accept': 'application/json',
      'Authorization': WOHConstants.authorization
    };
    var request = http.Request('GET', Uri.parse('${WOHConstants.serverPort}/read/res.partner?ids=$id'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      return json.decode(data);
    }
    else {
    print(response.reasonPhrase);
    }
  }

  Future getUserByEmail(var email, String reason)async{
    var headers = {
      'Cookie': 'frontend_lang=fr_FR; session_id=6d065737e3cc1153d3a20eaf7fadf96f0f58b31e; visitor_uuid=fcef730c94854dfc991dcde26c242a3e'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://willonhair.shintheo.com/will/get_user_by_email'));
    request.fields.addAll({
      'email': email
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      if(reason == "signup"){
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("Mise a jour des information..."),
          duration: Duration(seconds: 2),
        ));
        updateUser(json.decode(data)['partner_id']);
      }else{
        if(json.decode(data)['user_id'] != null){
          return true;
        }else{
          return false;
        }
      }
    }
    else {
      var data = await response.stream.bytesToString();
      print(response.reasonPhrase);
      Get.showSnackbar(WOHUi.ErrorSnackBar(message: json.decode(data)['message']));
    }
  }

  updateUser(var id)async{
    var headers = {
      'Accept': 'application/json',
      'Authorization': WOHConstants.authorization
    };
    var request = http.Request('PUT', Uri.parse('${WOHConstants.serverPort}/write/res.partner?ids=$id&values={'
        '"email": "${email.value}",'
        '"phone": "${phone.value}",'
        '"mobile": "${phone.value}",'
        '}'
    ));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      await login();
    }
    else {
      print(response.reasonPhrase);
    }
  }

  resetPassword(var email)async{

    var headers = {
      'Cookie': 'frontend_lang=fr_FR; session_id=6d065737e3cc1153d3a20eaf7fadf96f0f58b31e; visitor_uuid=fcef730c94854dfc991dcde26c242a3e'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://willonhair.shintheo.com/will/get_user_by_email'));
    request.fields.addAll({
      'email': email
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      print(data);
      if(json.decode(data)['user_id'] != null){
        sendEmail(json.decode(data)['user_id'], email);
      }else{
        onClick.value = false;
        Get.showSnackbar(WOHUi.warningSnackBar(message: json.decode(data)['error']));
      }
    }
    else {
      var data = await response.stream.bytesToString();
      onClick.value = false;
      Get.showSnackbar(WOHUi.ErrorSnackBar(message: json.decode(data)['message']));
      print(response.reasonPhrase);
    }
  }

  Future getEmployees(var user)async{

    var box = GetStorage();
    var employee;

    var headers = {
      'Accept': 'application/json',
      'Authorization': WOHConstants.authorization,
    };
    var request = http.Request('GET', Uri.parse('${WOHConstants.serverPort}/search_read/business.resource'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var data = json.decode(result);
      resources.value = data;
      for(var i=0; i< data.length; i++){
        if(data[i]['user_id'][0] == user['uid']){
          employee = data[i];
        }
      }
      if(employee != null){
        currentUser.value = employee;
        showDialog(
            context: (Get.context!),
            builder: (_){
              return AlertDialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  title: Text("Connexion réussi", style: Get.textTheme.displayLarge),
                  content: Text("Voulez-vous vous connecter en tant qu'employee ou client?\n", style: Get.textTheme.headlineMedium),
                  actions: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(onPressed: () {
                            box.write("userData", user);
                            Navigator.pop(Get.context!);
                            Get.showSnackbar(WOHUi.SuccessSnackBar(message: "connexion réussi, bon retour M/Mme ${user['name']}"));
                            Get.toNamed(WOHRoutes.ROOT);
                          },
                              child: Text("Client", style: Get.textTheme.displayMedium)),
                          SizedBox(width: 10),
                          TextButton(onPressed: () {
                            isEmployee.value = true;
                            box.write("userData", employee);
                            Navigator.pop(Get.context!);
                            Get.showSnackbar(WOHUi.SuccessSnackBar(message: "connexion réussi, bon retour M/Mme ${employee['display_name']}"));
                            Get.toNamed(WOHRoutes.EMPLOYEE_HOME);
                          },
                              child: Text("employee", style: Get.textTheme.displayMedium)),
                        ]
                    )
                  ]
              );
            });

      }else{
        box.write("userData", user);
        Get.showSnackbar(WOHUi.SuccessSnackBar(message: "connexion réussi, bon retour M/Mme ${user['name']}"));
        Get.toNamed(WOHRoutes.ROOT);
      }
      loading.value = false;

    }
    else {
      print(response.reasonPhrase);
    }
  }

  Future register() async {
    loading.value = true;
    var headers = {
      'Accept': 'application/json',
      'Authorization': WOHConstants.authorization
    };
    var request = http.Request('POST',Uri.parse('${WOHConstants.serverPort}/create/res.users?values={ '
        '"name": "${name.value}",'
        '"login": "${email.value}",'
        '"password": "${password.value}",'
        '"sel_groups_1_9_10": 1}'
    ));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200)  {
      getUserByEmail(email.value, "signup");
    }
    else {
      print(response.reasonPhrase);
      var data = await response.stream.bytesToString();
      Get.showSnackbar(WOHUi.ErrorSnackBar(message: json.decode(data)['message']));
      loading.value = false;
    }
  }

  /*saveDeviceToken(String token, var id)async{
    print("token is: $token");
    print(id.toString());

    var headers = {
      'Accept': 'application/json',
      'Authorization': WOHConstants.authorization
    };
    var request = http.Request('POST', Uri.parse('${WOHConstants.serverPort}/create/fcm.device.token?values={'
        '"token": "$token",'
        '"partner_id": $id}'));


    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      print('Device token already exist, Again ');
    }
    else {
      print(response.reasonPhrase);
    }
  }*/


  getUserDeviceTokens(List tokensList)async{
    var headers = {
      'Accept': 'application/json',
      'Authorization': WOHConstants.authorization
    };
    var request = http.Request('GET', Uri.parse('${WOHConstants.serverPort}/read/fcm.device.token?ids=$tokensList'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      var result = json.decode(data);
      return result;

    }
    else {
      print(response.reasonPhrase);
    }
  }

  void sendEmail(var id, var email)async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': WOHConstants.authorization
    };
    var request = http.Request('POST', Uri.parse('${WOHConstants.serverPort}/call/res.users/action_reset_password?ids=$id'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Get.showSnackbar(WOHUi.InfoSnackBar(message: "Un mail a été envoyé à l'adresse $email"));
      onClick.value = false;
      Navigator.pop(Get.context!);
    }
    else {
      var data = await response.stream.bytesToString();
      var result = json.decode(data);
      Get.showSnackbar(WOHUi.ErrorSnackBar(message: result['message']));
      print(response.reasonPhrase);
    }
  }
}