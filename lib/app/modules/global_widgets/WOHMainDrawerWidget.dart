// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
 
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../WOHColorConstants.dart';
import '../../../WOHConstants.dart'; 
import '../../../WOHResponsive.dart';
import '../../routes/WOHRoutes.dart';
import '../../services/WOHAuthService.dart';
import '../auth/controllers/WOHAuthController.dart'; 
import '../custom_pages/views/WOHCustomPageDrawerLinkWidget.dart';
import '../fidelisation/controller/WOHValidationController.dart';
import '../home/controllers/WOHHomeController.dart';
import '../root/controllers/WOHRootController.dart' show WOHRootController;
import '../userBookings/controllers/WOHBookingsController.dart';
import 'WOHDrawerLinkWidget.dart';
import 'WOHPopUpWidget.dart';

class WOHMainDrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Get.lazyPut<WOHAuthController>(
          () => WOHAuthController(),
    );
    Get.lazyPut<WOHHomeController>(
          () => WOHHomeController(),
    );
    Get.lazyPut(() => WOHValidationController());
    Get.lazyPut(() => WOHBookingsController());

    var currentUser = Get.find<WOHAuthController>().currentUser;
    return Container(
      padding: EdgeInsets.only(left: 0, right: MediaQuery.of(context).size.width / 1.8),
      child: Drawer(
        child: ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Obx(() {
                      return GestureDetector(
                        onTap: () async {
                          await Get.find<WOHRootController>().changePage(3);
                        },
                        child: UserAccountsDrawerHeader(
                          decoration: BoxDecoration(
                            color: Theme.of(context).hintColor.withAlpha((255 * 0.1).toInt()),
                          ),
                          accountName: Text(
                            currentUser['name'],
                            style: Theme.of(context).textTheme.displayMedium!.merge(TextStyle(color: employeeInterfaceColor, fontSize: 15)),
                          ),
                          accountEmail: Text(""
                          ),
                          currentAccountPicture: Stack(
                            children: [
                              if(Get.find<WOHAuthController>().isEmployee.value)
                                ClipOval(
                                    child: FadeInImage(
                                      width: WOHResponsive.isMobile(context) ? 100 : 150,
                                      height: WOHResponsive.isMobile(context) ? 100 : 150,
                                      fit: BoxFit.cover,
                                      image: WOHConstants.googleUser ? NetworkImage(WOHConstants.googleImage) : NetworkImage('${WOHConstants.serverPort}/image/business.resource/${currentUser['id']}/image_1920?unique=true&file_response=true', headers: WOHConstants.getTokenHeaders()),
                                      placeholder: AssetImage(
                                          "assets/img/loading.gif"),
                                      imageErrorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                            'assets/img/téléchargement (3).png',
                                            width: WOHResponsive.isMobile(context) ? 100 : 150,
                                            height: WOHResponsive.isMobile(context) ? 100 : 150,
                                            fit: BoxFit.fitWidth);
                                      },
                                    )
                                ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Get.find<WOHAuthService>().user.value.verifiedPhone ?? false ? Icon(Icons.check_circle, color: Get.theme.colorScheme.secondary, size: 24) : SizedBox(),
                              )
                            ],
                          ),
                        ),
                      );
                    })
                ),
                IconButton(
                    onPressed: ()=> Navigator.pop(context),
                    icon: Icon(Icons.arrow_back_outlined, size: 30)
                )
              ]
            ),
            SizedBox(height: 40),
            WOHDrawerLinkWidget(
                special: false,
                drawer: false,
                icon: Icons.dashboard,
                text: "Tableau de bord",
                onTap: (e) async{
                  Navigator.pop(context);
                  await Get.find<WOHHomeController>().refreshPage();
                  Get.find<WOHHomeController>().currentPage.value = 0;
                }
            ),
            WOHDrawerLinkWidget(
                special: false,
                drawer: false,
                icon: Icons.note_alt_sharp,
                text: "Rendez-vous",
                onTap: (e) {
                  Navigator.pop(context);
                  Get.find<WOHBookingsController>().refreshEmployeeBookings();
                  //Get.find<WOHBookingsController>().filterAppointmentDates();
                  Get.find<WOHHomeController>().currentPage.value = 1;
                }
            ),
            WOHDrawerLinkWidget(
                special: false,
                drawer: false,
                icon: Icons.receipt_long,
                text: "Factures",
                onTap: (e) {
                  Navigator.pop(context);
                  Get.find<WOHBookingsController>().getReceipts();
                  //Get.find<WOHBookingsController>().filterDates();
                  Get.find<WOHHomeController>().currentPage.value = 2;
                }
            ),
            WOHDrawerLinkWidget(
                special: false,
                drawer: false,
                icon: Icons.settings,
                text: "Interface POS",
                onTap: (e) {
                  Navigator.pop(context);
                  Get.find<WOHBookingsController>().refreshEmployeeBookings();
                  Get.find<WOHHomeController>().currentPage.value = 3;
                }
            ),
            WOHDrawerLinkWidget(
              special: false,
              drawer: false,
              icon: Icons.qr_code,
              text: "Scanner le code",
              onTap: (e) async {
                Navigator.pop(context);
                Get.find<WOHValidationController>().refreshPage();
                Get.find<WOHHomeController>().currentPage.value = 4;
              },
            ),
            ListTile(
              dense: true,
              title: Text(
                "Help & Privacy",
                style: Get.textTheme.labelSmall,
              ),
              trailing: Icon(
                Icons.remove,
                color: Get.theme.focusColor.withAlpha((255 * 0.3).toInt()),
              ),
            ),
            WOHCustomPageDrawerLinkWidget(),
            WOHDrawerLinkWidget(
              special: true,
              drawer: false,
              icon: Icons.logout,
              text: "Déconnexion",
              onTap: (e) async {
                showDialog(
                    context: context,
                    builder: (_) => WOHPopUpWidget(
                      title: "Vous serez redirigé vers la page de connexion! Voulez-vous vraiment vous déconnecter?",
                      cancel: 'Annuler',
                      confirm: 'Déconnexion',
                      onTap: ()async{
                        var box = GetStorage();
                        Get.find<WOHHomeController>().currentPage.value = 0;
                        WOHConstants.googleUser = false;
                        box.remove("userData");
                        Navigator.pop(context);

                        Get.toNamed(WOHRoutes.LOGIN);

                      }, icon: Icon(FontAwesomeIcons.warning, size: 40,color: inactive),
                    ));
              },
            ),
            ListTile(
              dense: true,
              title: Text(
                "Version",
                style: Get.textTheme.headlineMedium,
              ),
              trailing: Text(
                Get.find<WOHRootController>().packageInfo.version.toString(),
                style: Get.textTheme.headlineMedium,
              ),
            )
          ],
        ),
      ),
    );
  }
}