// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../WOHColorConstants.dart';
import '../../../../WOHConstants.dart';
import '../../../../common/WOHUi.dart'; 
import '../../../routes/WOHRoutes.dart';
import '../../e_service/widgets/WOHEServiceTilWidget.dart';
import '../../global_widgets/WOHPopUpWidget.dart';
import '../../root/controllers/WOHRootController.dart';
import '../controllers/WOHAccountController.dart';
import '../widgets/WOHAccountLinkWidget.dart';
import '../widgets/WOHAccountWidget.dart';

class WOHAccountView extends GetView<WOHAccountController> {
  const WOHAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    //var _currentUser = Get.find<WOHMyAuthService>().myUser;
    Get.lazyPut(() => WOHRootController());
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          controller.onRefresh();
        },
        child: SingleChildScrollView(
          primary: true,
          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Container(
                    height: 300,
                    width: Get.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          "assets/img/240_F_142999858_7EZ3JksoU3f4zly0MuY3uqoxhKdUwN5u.jpeg",
                        ),
                      ),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Get.theme.focusColor.withAlpha((255 * 0.2).toInt()),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    margin: EdgeInsets.only(bottom: 50),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        "\nMon Profile".tr,
                        style: Get.textTheme.displayMedium!.merge(
                          TextStyle(
                            fontSize: 20,
                            color: Get.theme.primaryColor,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        decoration: WOHUi.getBoxDecoration(
                          //radius: 14,
                          border: Border.all(
                            width: 5,
                            color: Get.theme.primaryColor,
                          ),
                        ),
                        child: InkWell(
                          onTap: () => {
                            showDialog(
                              context: context,
                              builder: (_) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Material(
                                      child: IconButton(
                                        onPressed: () => Navigator.pop(context),
                                        icon: Icon(Icons.close, size: 20),
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      child: FadeInImage(
                                        width: Get.width,
                                        height: Get.height / 2,
                                        fit: BoxFit.cover,
                                        image: WOHConstants.googleUser
                                            ? NetworkImage(WOHConstants.googleImage)
                                            : NetworkImage(
                                                '${WOHConstants.serverPort}/image/res.partner/${controller.currentUser['id']}/image_1920?unique=true&file_response=true',
                                                headers:
                                                    WOHConstants.getTokenHeaders(),
                                              ),
                                        placeholder: AssetImage(
                                          "assets/img/loading.gif",
                                        ),
                                        imageErrorBuilder:
                                            (context, error, stackTrace) {
                                              return Center(
                                                child: Container(
                                                  width: Get.width / 1.5,
                                                  height: Get.height / 3,
                                                  color: Colors.white,
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.person,
                                                      size: 150,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          },
                          child: Obx(
                            () => !controller.pictureUpdated.value
                                ? Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: FadeInImage(
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                      image: WOHConstants.googleUser
                                          ? NetworkImage(WOHConstants.googleImage)
                                          : NetworkImage(
                                              '${WOHConstants.serverPort}/image/res.partner/${controller.currentUser['id']}/image_1920?unique=true&file_response=true',
                                              headers: WOHConstants.getTokenHeaders(),
                                            ),
                                      placeholder: AssetImage(
                                        "assets/img/loading.gif",
                                      ),
                                      imageErrorBuilder:
                                          (context, error, stackTrace) {
                                            return Image.asset(
                                              'assets/img/man.png',
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.contain,
                                            );
                                          },
                                    ),
                                  )
                                : Image.file(
                                    controller.image,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: interfaceColor,
                        radius: 20,
                        child: IconButton(
                          onPressed: () => {controller.selectCameraOrGallery()},
                          icon: Icon(
                            Icons.camera_alt,
                            color: Get.theme.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Obx(
                () => controller.currentUser['name'] == null
                    ? SpinKitFadingCircle(color: Colors.blue, size: 30)
                    : WOHEServiceTilWidget(
                        title: Text(
                          "Mes Information",
                          style: Get.textTheme.bodySmall!.merge(
                            TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                        actions: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: controller.edit.value
                                ? inactive
                                : interfaceColor,
                          ),
                          child: Text(
                            !controller.edit.value
                                ? "Modifier profile"
                                : "Annuler",
                          ),
                          onPressed: () => {
                            controller.edit.value = !controller.edit.value,
                          },
                        ),
                        content: SingleChildScrollView(
                          child: Column(
                            children: [
                              Obx(
                                () => WOHAccountLinkWidget(
                                  icon: Icons.person,
                                  text: "Nom complet",
                                  label: controller.currentUser['name'],
                                  edit: controller.edit.value,
                                  onChange: (value) =>
                                      controller.userName.value = value,
                                ),
                              ),
                              Divider(color: background),
                              Obx(
                                () => WOHAccountLinkWidget(
                                  icon: Icons.alternate_email_outlined,
                                  text: "Email",
                                  label: controller.currentUser['email']
                                      .toString(),
                                  edit: controller.edit.value,
                                  onChange: (value) =>
                                      controller.email.value = value,
                                ),
                              ),
                              Divider(color: background),
                              Obx(
                                () => WOHAccountLinkWidget(
                                  icon: Icons.phone_android,
                                  text: "Mobile",
                                  label: controller.currentUser['phone']
                                      .toString(),
                                  edit: controller.edit.value,
                                  onChange: (value) =>
                                      controller.phone.value = value,
                                ),
                              ),
                              Divider(color: background),
                              Obx(
                                () => controller.edit.value
                                    ? ElevatedButton(
                                        child: Text("Soumetre"),
                                        onPressed: () => {
                                          controller.updateProfile(),
                                        },
                                      )
                                    : SizedBox(),
                              ),
                              WOHAccountLinkWidget(
                                icon: Icons.star,
                                text: "Nombre de points",
                                label: controller.currentUser['client_points']
                                    .toString(),
                                edit: false,
                                onChange: (value) => {},
                              ),
                              Divider(color: background),
                              WOHAccountLinkWidget(
                                icon: Icons.wine_bar,
                                text: "Nombre de bonus",
                                label: controller.currentUser['client_bonus']
                                    .toString(),
                                edit: false,
                                onChange: (value) => {},
                              ),
                              Divider(color: background),
                              Obx(
                                () => SwitchListTile(
                                  //switch at right side of label
                                  value: controller.enableNotification.value,
                                  onChanged: (bool value) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("Loading data..."),
                                        duration: Duration(seconds: 3),
                                      ),
                                    );

                                    print(WOHConstants.deviceToken);
                                    if (controller.enableNotification.value) {
                                      //controller.getDeviceTokens();
                                    } else {
                                      //controller.enableNotify();
                                    }
                                  }, //luggageSelected
                                  title: Text(
                                    "Enable Notifications on this device",
                                    style: Get.textTheme.displayMedium!.merge(
                                      TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                              ),

                              InkWell(
                                onTap: () => {
                                  Get.toNamed(WOHRoutes.NOTIFICATIONS),
                                },
                                child: WOHAccountWidget(
                                  icon: Icons.notifications,
                                  text: "Notifications",
                                  label: "",
                                  labelColor: Colors.black,
                                  textColor: Colors.black,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => WOHPopUpWidget(
                                      title:
                                          "Voulez vous vraiment Suprimer votre compte? Vous allez perdre tous vos données et points dde fidélté... veillez confirmer votre choix",
                                      cancel: 'Annuler',
                                      confirm: 'Confirmer',
                                      onTap: () async {
                                        var box = GetStorage();
                                        WOHConstants.googleUser = false;
                                        controller.deleteAccount();
                                      },
                                      icon: Icon(
                                        FontAwesomeIcons.triangleExclamation,
                                        size: 40,
                                        color: inactive,
                                      ),
                                    ),
                                  );
                                },
                                child: WOHAccountWidget(
                                  icon: Icons.delete,
                                  text: "Suprimer mon compte",
                                  label: "",
                                  labelColor: interfaceColor,
                                  textColor: specialColor,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => WOHPopUpWidget(
                                      title:
                                          "Voulez vous vraiment vous déconnecter? veillez confirmer votre choix",
                                      cancel: 'Annuler',
                                      confirm: 'Confirmer',
                                      onTap: () async {
                                        var box = GetStorage();
                                        WOHConstants.googleUser = false;
                                        box.remove("userDto");

                                        Get.toNamed(WOHRoutes.LOGIN);
                                      },
                                      icon: Icon(
                                        FontAwesomeIcons.triangleExclamation,
                                        size: 40,
                                        color: inactive,
                                      ),
                                    ),
                                  );
                                },
                                child: WOHAccountWidget(
                                  icon: Icons.logout,
                                  text: "Déconnexion",
                                  label: "",
                                  labelColor: interfaceColor,
                                  textColor: specialColor,
                                ),
                              ),
                              /*ListTile(
                                    dense: true,
                                    title: Text(
                                      "Version",
                                      style: Get.textTheme.labelSmall,
                                    ),
                                    trailing: Text(
                                      'Get.find<WOHRootController>().packageInfo.version.toString()',
                                      style: Get.textTheme.labelSmall,
                                    ),
                                  )*/
                            ],
                          ),
                        ), key: null,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLoader() {
    return Container(
      width: Get.width,
      height: 40,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Image.asset(
          'assets/img/loading.gif',
          fit: BoxFit.cover,
          width: double.infinity,
          height: 100,
        ),
      ),
    );
  }
}