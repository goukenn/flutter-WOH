// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../WOHColorConstants.dart';
import '../../../main.dart';
import '../userBookings/controllers/WOHBookingsController.dart';

class WOHCardWidget extends StatelessWidget {
  const WOHCardWidget({super.key, 
    this.agent='',
    this.service='',
    this.price=0,
    this.imageUrl,
    this.onTap,
    required this.shippingDateStart,
    required this.shippingDateEnd,
    required this.code,
    required this.bookingState
  });

  final String code;
  final String? imageUrl;
  final String agent;
  final String service;
  final String shippingDateStart;
  final String shippingDateEnd;
  final String bookingState;
  final double price;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<WOHBookingsController>(
          () => WOHBookingsController(),
    );
    //var selected = Get.find<WOHBookingsController>().currentState.value ;
    return ClipRRect(
      child: Banner(
        location: BannerLocation.topEnd,
        message: bookingState == "reserved" ? "Planifié" : bookingState == "done" ? "Fait" : bookingState == 'cancel' ? "Annulé" : bookingState,
        color: bookingState == 'reserved' ? newStatus : bookingState == 'done' ? doneStatus : bookingState == 'cancel' ?  specialColor : inactive,
        child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              //side: BorderSide(color: interfaceColor.withAlpha((255 * 0.4).toInt()), width: 2),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                //alignment: AlignmentDirectional.topStart,
                children: [
                  SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Expanded(
                          child: Text(code, overflow: TextOverflow.ellipsis,style: Get.textTheme.displayLarge.
                         !.merge(TextStyle(color: appColor, fontSize: 12))
                          )
                      ),
                      Text("${DateFormat("dd MMM yyyy, HH:mm").format(DateTime.parse(shippingDateStart))} - ${DateFormat(" HH:mm").format(DateTime.parse(shippingDateEnd))}",
                          style: Get.textTheme.displayLarge!.merge(TextStyle(fontSize: 12, color: Colors.black))),
                      SizedBox(width: 20)
                    ]
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                      width: Get.width,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () => showDialog(
                                  context: context, builder: (_){
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Material(
                                        child: IconButton(onPressed: ()=> Navigator.pop(context), icon: Icon(Icons.close, size: 20))
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      child: FadeInImage(
                                        width: Get.width,
                                        height: Get.height/2,
                                        fit: BoxFit.cover,
                                        image: NetworkImage(this.imageUrl, headers: WOHConstants.getTokenHeaders()),
                                        placeholder: AssetImage(
                                            "assets/img/loading.gif"),
                                        imageErrorBuilder:
                                            (context, error, stackTrace) {
                                          return Center(
                                              child: Container(
                                                  width: Get.width/1.5,
                                                  height: Get.height/3,
                                                  color: Colors.white,
                                                  child: Center(
                                                      child: Icon(Icons.person, size: 150)
                                                  )
                                              )
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                );
                              }),
                              child: ClipOval(
                                  child: FadeInImage(
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                    image: NetworkImage(this.imageUrl, headers: WOHConstants.getTokenHeaders()),
                                    placeholder: AssetImage(
                                        "assets/img/loading.gif"),
                                    imageErrorBuilder:
                                        (context, error, stackTrace) {
                                      return Image.asset(
                                          "assets/img/téléchargement (1).png",
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.fitWidth);
                                    },
                                  )
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                                child: Text(this.agent, style: TextStyle(fontSize: 12, color: appColor, overflow: TextOverflow.ellipsis)),
                            ),
                            TextButton(
                                onPressed: onTap,
                                child: Text("Voir plus", style: Get.textTheme.displayMedium!.merge(TextStyle(color: Colors.blueAccent)))
                            ),
                            SizedBox(width: 10)
                          ]
                      )
                  )
                ]
              )
            )
        )
      ),
    );
  }
}