// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../WOHColorConstants.dart';
import '../../../../common/animation_controllers/WOHDelayedAnimation.dart';
import '../../../../WOHConstants.dart';
import '../../../routes/WOHRoutes.dart';
import '../../../services/WOHAuthService.dart'; 
import '../../fidelisation/controller/WOHValidationController.dart';
import '../../global_widgets/WOHNotificationsButtonWidget.dart';
import '../../global_widgets/WOHPopUpWidget.dart';
import '../controllers/WOHHomeController.dart';

class WOHHome2View extends GetView<WOHHomeController> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut<WOHAuthService>(
          () => WOHAuthService(),
    );
    Get.lazyPut(() => WOHValidationController());

    return Scaffold(
        backgroundColor: background,
      appBar: AppBar(
        backgroundColor: appBarColor,
        leading: Obx(() => IconButton(onPressed: ()=> controller.multiple.value = !controller.multiple.value,
            icon: Icon(controller.multiple.value ? Icons.dashboard : Icons.view_agenda, color: Colors.white,))
        ),
        title: Text(
               WOHConstants.AppName,
               style: Get.textTheme.titleLarge!.merge(TextStyle(color: Colors.white)),
             ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          Row(
            children: [
              WOHNotificationsButtonWidget(),
              Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: IconButton(
                      onPressed: (){
                        showDialog(
                            context: context,
                            builder: (_)=>  WOHPopUpWidget(
                              title: "Voulez vous vraiment vous déconnecter? veillez confirmer votre choix",
                              cancel: 'Annuler',
                              confirm: 'Confirmer',
                              onTap: ()async{
                                var box = GetStorage();
                                WOHConstants.googleUser = false;
                                box.remove("userDto");

                                Get.toNamed(WOHRoutes.LOGIN);

                              }, icon: Icon(FontAwesomeIcons.triangleExclamation, size: 40,color: inactive),
                            ));
                      },
                      icon: Icon(FontAwesomeIcons.arrowRightFromBracket,
                          color: Colors.white
                      )
                  )
              )
            ],
          ),
        ],
      ),
        /*floatingActionButton: InkWell(
            onTap: ()=>{
              Get.find<WOHValidationController>().scan()
            },
            child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage('assets/img/qr-code.png'))
                )
            )
        ),*/
      body: RefreshIndicator(

        onRefresh: ()=> controller.getUserDto(),

        child: FutureBuilder<bool>(
          future: controller.getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 15),
                  Expanded(
                    child: FutureBuilder<bool>(
                      future: controller.getData(),
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        if (!snapshot.hasData) {
                          return const SizedBox();
                        } else {
                          return Obx(() => GridView(
                            padding: const EdgeInsets.only(
                                top: 0, left: 12, right: 12),
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: controller.multiple.value ? 2 : 1,
                              mainAxisSpacing: 12.0,
                              crossAxisSpacing: 12.0,
                              childAspectRatio: 1.5,
                            ),
                            children: List<Widget>.generate(
                              controller.homeList.length,
                                  (int index) {
                                return WOHDelayedAnimation(
                                    delay: index == 0 ? 30 : 30 * index,
                                    child: AspectRatio(
                                      aspectRatio: 1.5,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(4.0)),
                                        child: Stack(
                                          alignment:
                                          AlignmentDirectional.center,
                                          children: <Widget>[
                                            Positioned.fill(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    boxShadow: <BoxShadow>[
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withAlpha((255 * 0.6).toInt()),
                                                        offset:
                                                        const Offset(4, 4),
                                                        blurRadius: 16,
                                                      ),
                                                    ],
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                          controller.homeList[index]
                                                              .imagePath),
                                                      fit: BoxFit.cover,
                                                      colorFilter:
                                                      ColorFilter.mode(
                                                          Colors
                                                              .black
                                                              .withAlpha((255 * 0.2).toInt()),
                                                          BlendMode.darken),
                                                    ),
                                                    borderRadius:
                                                    BorderRadius.circular(15),

                                                    //border: Border.all(width: 3, color: Colors.grey)
                                                  ),
                                                )),
                                            Center(
                                              child: !controller.multiple.value
                                                  ? Text(
                                                controller.homeList[index].title,
                                                style: TextStyle(
                                                    fontSize: 40,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    color:
                                                    Colors.white),
                                              )
                                                  : Text(
                                                controller.homeList[index].title,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    color:
                                                    Colors.white),
                                              ),
                                            ),
                                            Material(
                                              color: Colors.transparent,
                                              child: InkWell(
                                                splashColor: Colors.grey
                                                    .withAlpha((255 * 0.2).toInt()),
                                                borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(4.0)),
                                                onTap: ()async => await controller.changePage(index)
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                );
                              },
                            ),
                          ));
                        }
                      },
                    ),
                  ),
                ],
              );
            }
          },
        )
      )
    );
  }
}