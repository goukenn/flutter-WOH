// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../../../../WOHColorConstants.dart';
import '../../../../WOHPalette.dart';
import '../../../../common/animation_controllers/WOHDelayedAnimation.dart';
import '../../../../WOHConstants.dart';
import '../controllers/WOHBookingsController.dart';

class WOHBookingsListItemWidget extends GetView<WOHBookingsController> {

  @override
  Widget build(BuildContext context) {

    var data = [];
    for(var a in controller.items){
      if(a['state'] == "reserved"){
        data.add(a);
      }
    }
    controller.drawerAppointments.value = data;
    controller.drawerAppointmentsOrigin.value = data;
    return WOHDelayedAnimation(
        delay: 50,
        child: Container(
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 3, right: 0),
            child: Drawer(
                backgroundColor: WOHPalette.background,
                child: Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Row(
                      children: [
                        IconButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back_ios_rounded)
                        ),
                        Text(" Tous les Rendez-Vous", style: TextStyle(color: appColor, fontSize: 17, fontWeight: FontWeight.bold)),
                        Spacer(),
                        Container(
                            width: MediaQuery.of(context).size.width / 4,
                            height: 40,
                            child: TextFormField(
                              //controller: dateController,
                              decoration: InputDecoration(
                                filled: true,
                                contentPadding: EdgeInsets.only(top: 10),
                                fillColor: background,
                                prefixIcon: Icon(Icons.search),
                                hintText: "Rechercher...",
                                hintStyle: TextStyle(
                                  fontSize: 12,
                                  color: Theme
                                      .of(context)
                                      .hintColor,
                                ),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0)),
                              ),
                              onChanged: (value) {
                                controller.filterSearchResults(value);
                              },
                            )
                        ),
                        SizedBox(width: 10)
                      ],
                    ),
                    Divider(color: Colors.grey),
                    controller.isLoading.value ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.width / 4),
                          SpinKitFadingCircle(color: employeeInterfaceColor, size: 40),
                        ]
                    ) : controller.drawerAppointments.isNotEmpty ?
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.drawerAppointments.length,
                        itemBuilder: (BuildContext context, int index) {
                          var list = [];
                          list = controller.drawerAppointments;
                          String formatted = DateFormat("yyyy-MM-dd à HH:mm").format(DateTime.parse(list[index]['datetime_start']).add(Duration(hours: 2))).toString();

                          return Column(
                            children: [
                              Material(
                                  child: InkWell(
                                    onTap: ()async{

                                      controller.selectedAppointment.value = list[index];
                                      controller.getAppointmentOrder(list[index]['order_id'][0]);
                                      Navigator.pop(context);
                                      //getOrder(controller.items[index]['order_id'][0]['id'], );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(top: 5, bottom: 10, left: 15, right: 15),
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(color: appColor),
                                          )
                                      ),
                                      child: Row(
                                        children: [
                                          ClipOval(
                                              child: FadeInImage(
                                                width: 50,
                                                height: 50,
                                                fit: BoxFit.cover,
                                                image: WOHConstants.googleUser ? NetworkImage(WOHConstants.googleImage) : NetworkImage('${WOHConstants.serverPort}/image/res.partner/${list[index]['partner_id'][0]}/image_1920?unique=true&file_response=true', headers: WOHConstants.getTokenHeaders()),
                                                placeholder: AssetImage(
                                                    "assets/img/loading.gif"),
                                                imageErrorBuilder:
                                                    (context, error, stackTrace) {
                                                  return Image.asset(
                                                      'assets/img/téléchargement (3).png',
                                                      width: 50,
                                                      height: 50,
                                                      fit: BoxFit.fitWidth);
                                                },
                                              )
                                          ),
                                          SizedBox(width: 10),
                                          RichText(
                                            text: TextSpan(
                                                children: [
                                                  TextSpan(text: list[index]['partner_id'][1],
                                                      style: TextStyle(fontSize: 18, color: appColor)),
                                                  TextSpan(text: "\n$formatted",
                                                      style: TextStyle(fontSize: 15, color: CupertinoColors.systemGrey)),
                                                  TextSpan(text: "\n${list[index]['name']}",
                                                      style: TextStyle(fontSize: 13, color: CupertinoColors.systemGrey)),
                                                ]
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                              width: 200,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                                color: employeeInterfaceColor.withAlpha((255 * 0.3).toInt()),
                                              ),
                                              padding: EdgeInsets.all(5),
                                              child: Center(
                                                child: Text(list[index]['service_id'][1].split(">").first, style: TextStyle(fontSize: 15, color: employeeInterfaceColor)),
                                              )
                                          )
                                        ]
                                      )
                                    )
                                  )
                              )
                            ]
                          );
                        }
                      )
                    ) : Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.width / 4),
                          Text("Page vide", style: TextStyle(color: inactive))
                        ]
                    )
                  ]
                ))
            )
        )
    );
  }
}