// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../../WOHColorConstants.dart'; 
import '../../../../common/WOHUi.dart';
import '../../../../WOHConstants.dart';
import '../../../../WOHResponsive.dart';
import '../../../routes/WOHRoutes.dart';
import '../../global_widgets/WOHBlockButtonWidget.dart';
import '../../global_widgets/WOHTextFieldWidget.dart';
import '../../root/controllers/WOHRootController.dart';
import '../controllers/WOHAuthController.dart';

class WOHLoginView extends GetView<WOHAuthController> {

  final box = Hive.box("myBox");

  @override
  Widget build(BuildContext context) {

    Get.lazyPut(() => WOHRootController());

    return /*WillPopScope*/ PopScope(
      //onWillPop: WOHHelper().onWillPop,
      child: Scaffold(
        body: ListView(
          primary: true,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Container(
                  height: Get.height/5,
                  width: Get.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/img/240_F_142999858_7EZ3JksoU3f4zly0MuY3uqoxhKdUwN5u.jpeg")),
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(color: Get.theme.focusColor.withAlpha((255 * 0.2).toInt()), blurRadius: 10, offset: Offset(0, 5)),
                      ]
                  ),
                  margin: EdgeInsets.only(bottom: 50),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      "\nConnexion".tr,
                      style: Get.textTheme.displayMedium!.merge(TextStyle(fontSize: 20, color: Get.theme.primaryColor)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  decoration: WOHUi.getBoxDecoration(
                    radius: 14,
                    border: Border.all(width: 5, color: Get.theme.primaryColor),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Image.asset(
                      'assets/img/photo_2022-11-25_01-12-07.jpg',
                      fit: BoxFit.cover,
                      width: WOHResponsive.isMobile(context) ? 100 : Get.width/4,
                      height: WOHResponsive.isMobile(context) ? 100 : Get.width/4,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: WOHResponsive.isMobile(context) ? 5 : 40),
              Obx(() {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: WOHResponsive.isMobile(context) ? 10 : 70),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      WOHTextFieldWidget(
                        readOnly: false,
                        labelText: "Adresse mail",
                        hintText: "johndoe@gmail.com",
                        initialValue: controller.email.value,
                        keyboardType: TextInputType.emailAddress,
                        //onSaved: (input) => controller.currentUser.value.email = input,
                        onChanged: (value) => {
                          controller.email.value = value
                        },
                        validator: (input) => input!.length < 3 ? "Should be a valid email" : null,
                        iconData: Icons.alternate_email,
                      ),
                      Obx(() {
                        return WOHTextFieldWidget(
                          labelText: "Mot de pass",
                          hintText: "••••••••••••",
                          readOnly: false,
                          initialValue: controller.password.value,
                          //onSaved: (input) => controller.currentUser.value.password = input,
                          onChanged: (value) => {
                            controller.password.value = value
                          },
                          validator: (input) => input!.length < 3 ? "Should be more than 3 characters" : null,
                          obscureText: controller.hidePassword.value,
                          iconData: Icons.lock_outline,
                          keyboardType: TextInputType.visiblePassword,
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.hidePassword.value = !controller.hidePassword.value;
                            },
                            color: Theme.of(context).focusColor,
                            icon: Icon(controller.hidePassword.value ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                          ),
                        );
                      }),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Obx(() => Checkbox(
                              value: controller.isChecked.value,
                              onChanged: (value)async{
                                var box = GetStorage();
                                controller.isChecked.value = !controller.isChecked.value;
                                if(controller.isChecked.value){
                                  box.write("userEmail", controller.email.value);
                                  box.write("password", controller.password.value);
                                  box.write("checkBox", controller.isChecked.value);
                                }else{
                                  box.remove("userEmail");
                                  box.remove("password");
                                  box.remove("checkBox");
                                  box.write("checkBox", false);
                                }
                                print(box.read('userEmail'));
                                print(box.read('password'));
                                print(box.read('checkBox'));
                              }
                          )),
                          Text("Se souvenir de moi",style: TextStyle(fontFamily: "poppins",fontSize: 12, color: buttonColor)),
                          //if(WOHResponsive.isMobile(context))...[
                          Spacer(),
                          TextButton(
                            onPressed: () {
                              Get.toNamed(WOHRoutes.FORGOT_PASSWORD);
                            },
                            child: Text("Mot de pass oublé?",style: TextStyle(fontFamily: "poppins",fontSize: 12, color: buttonColor)),
                          )
                          //]
                        ],
                      ).paddingSymmetric(horizontal: 30),

                      SizedBox(height: WOHResponsive.isMobile(context) ? 20 : 50),
                      Obx(() => WOHBlockButtonWidget(
                        disabled: false,
                        onPressed: ()async{
                          if(controller.email.value.isNotEmpty && controller.password.value.isNotEmpty){
                            await controller.login();

                            if(WOHConstants.myBoxStorage.value.length>30){
                              var i =WOHConstants.myBoxStorage.value.length-1;
                              while(i>=30){
                                WOHConstants.myBoxStorage.value.deleteAt(0);
                                i--;

                              }
                            }


                            if (box.get('userEmail') != null) {
                              if (controller.email.value
                                  .compareTo(box.get('userEmail')) !=
                                  0) {
                                box.put("userEmail", controller.email.value);
                                WOHConstants.myBoxStorage.value.clear();
                              }
                            }

                          }
                        },
                        text: !controller.loading.value? Text(
                          "Connexion",
                          style: Get.textTheme.headlineMedium!.merge(TextStyle(color: Get.theme.primaryColor)),
                        ): SizedBox(height: 30,
                            child: SpinKitFadingCircle(color: Colors.white, size: 30)),
                        loginPage: true,
                        color: controller.email.value.isNotEmpty && controller.password.value.isNotEmpty ?
                        WOHResponsive.isTablet(context) ? employeeInterfaceColor : interfaceColor : WOHResponsive.isTablet(context)
                            ? employeeInterfaceColor.withAlpha((255 * 0.3).toInt()) : interfaceColor.withAlpha((255 * 0.3).toInt()),
                      ).paddingSymmetric(vertical: 10, horizontal: 20),),

                      SizedBox(height: WOHResponsive.isMobile(context) ? 5 : 20),
                      /*Row(
                        children: const [
                          Expanded(
                            child: Divider(
                              height: 30,
                              //color: Colors.grey,
                              thickness: 1,
                            ),
                          ),
                          Text(
                            " Ou  ",
                            style: TextStyle(
                              fontSize: 16,
                              //fontFamily:'Roboto',
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Expanded(
                            child: Divider(
                              height: 30,
                              //color: Colors.grey,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: WOHResponsive.isMobile(context) ? 5 : 20),
                      InkWell(
                        onTap: ()=> controller.signInWithGoogle(),
                        child: Container(
                          width: Get.width,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          height: 45,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              border: Border.all()
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/img/search.png", width: 20,height: 20),
                              SizedBox(width: 10),
                              Text('Connecter avec Google',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: buttonColor)),
                            ],
                          ),
                        ),
                      ),*/
                      //if(WOHResponsive.isMobile(context))
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Vous n'avez pas encore de compte?",style: Get.textTheme.headlineMedium),
                          TextButton(
                            onPressed: () {
                              Get.toNamed(WOHRoutes.REGISTER);
                            },
                            child: Text("Créer",style: TextStyle(fontFamily: "poppins",fontSize: 15, color: Colors.blueAccent)),
                          ),
                        ],
                      ).paddingSymmetric(vertical: 20),
                      /*SizedBox(height: 50),
                      ListTile(
                        dense: true,
                        title: Text(
                          "Version",
                          style: Get.textTheme.labelSmall,
                        ),
                        trailing: Text(
                          'controller.packageInfo.version.toString()',
                          style: Get.textTheme.labelSmall,
                        )
                      )*/
                    ]
                  )
                );
              }
            )
          ]
        )
      )
    );
  }
}