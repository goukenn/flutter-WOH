// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
 
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../WOHColorConstants.dart';
import '../../../WOHConstants.dart'; 

class WOHTravelCardWidget extends StatelessWidget {
   WOHTravelCardWidget({super.key,
    this.user= '',
    this.isUser= false,
    this.travelState='',
    this.action,
    this.qty = 0.0,
    this.rating = '',
    required this.depTown,
    required this.homePage,
    required this.color,
    required this.arrTown,
    required this.imageUrl,
    required this.depDate,
    required this.travelBy,
    required this.price,
    required this.text});

  final Color color;
  final String user;
  final String rating;
  final Widget text;
  final String depTown;
  final String arrTown;
  final String depDate;
  final String travelState;
  final double qty;
  final String travelBy;
  final bool isUser;
  final bool homePage;
  final double price;
  final String imageUrl;
  final Function? action;

  @override
  Widget build(BuildContext context) {
    double width = homePage ? MediaQuery.of(context).size.width/3.8 : MediaQuery.of(context).size.width/3.6;
    String departureCity = depTown.split('(').first;
    String a = depTown.split('(').last;
    String departureCountry = a.split(')').first;

    String arrivalCity = arrTown.split('(').first;
    String b = arrTown.split('(').last;
    String arrivalCountry = b.split(')').first;

    return Card(
        shape: RoundedRectangleBorder(
          side:  !isUser ? BorderSide(
              color: inactive, width: 0
            //travelState != 'accepted' && isUser ? inactive : interfaceColor.withAlpha((255 * 0.4).toInt()), width: 2
          ) : BorderSide(
              color: travelState != 'accepted' && isUser ? inactive : interfaceColor.withAlpha((255 * 0.4).toInt()), width: 0
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Container(
            height: travelState == 'pending' ? 220 : 150,
            padding: EdgeInsets.all(10),
            child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                      color: Get.theme.primaryColor,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            if(travelBy == "air")
                              Icon(FontAwesomeIcons.planeCircleCheck, size: 30, color: background),
                            if(travelBy == "road")
                              Icon(FontAwesomeIcons.bus, size: 30, color: background),
                            if(travelBy == "sea")
                              Icon(FontAwesomeIcons.ship, size: 30, color: background) ,
                            SizedBox(width: 10),
                            Container(
                                alignment: Alignment.topLeft,
                                //margin: EdgeInsets.only(right: 10),
                                width: width,
                                height: 40,
                                child: RichText(
                                    text: TextSpan(
                                        children: [
                                          TextSpan(text: departureCity, style: Get.textTheme.displayMedium!.merge(TextStyle(fontSize: 12, color: interfaceColor))),
                                          TextSpan(text: "\n$departureCountry".toUpperCase(), style: Get.textTheme.displayLarge!.merge(TextStyle(fontSize: 12, color: appColor)))
                                        ]
                                    ))
                            ),
                            FaIcon(FontAwesomeIcons.arrowRight),
                            Container(
                                alignment: Alignment.topCenter,
                                //margin: EdgeInsets.symmetric(horizontal: 10),
                                width: width,
                                height: 40,
                                child: RichText(
                                    text: TextSpan(
                                        children: [
                                          TextSpan(text: arrivalCity, style: Get.textTheme.displayMedium!.merge(TextStyle(fontSize: 12, color: interfaceColor))),
                                          TextSpan(text: "\n$arrivalCountry".toUpperCase(), style: Get.textTheme.displayLarge!.merge(TextStyle(fontSize: 12, color: appColor)))
                                        ]
                                    ))
                              //Text(arrTown, style: Get.textTheme.displayLarge!.merge(TextStyle(fontSize: 18)))
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              if(travelBy != "road")...[
                                Row(
                                  children: [
                                    Icon(FontAwesomeIcons.bagShopping, size: 25, color: appColor),
                                    Text(' /kg:   $qty', style: Get.textTheme.headlineSmall!.merge(TextStyle(color: appColor))),
                                  ]
                                ),
                                SizedBox(height: 5),
                                Text('$price EUR', style: Get.textTheme.displaySmall!.merge(TextStyle(color: specialColor))),
                              ],
                              SizedBox(height: 10),
                              if(isUser)
                                SizedBox(
                                  width: Get.width/1.2,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: Text(this.depDate, style: Get.textTheme.displayLarge!.merge(TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: appColor))
                                          )
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        alignment: Alignment.center,
                                        child: Text(travelState == "negotiating" ? "PUBLISHED" : travelState.toUpperCase(), style: Get.textTheme.displayLarge!.merge(TextStyle(color: travelState == 'accepted' ? interfaceColor : travelState == 'negotiating' ? validateColor : travelState == "pending" ? inactive : travelState == "completed" ? doneStatus : specialColor, fontSize: 12))),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: travelState == 'accepted' ? interfaceColor : travelState == 'negotiating' ? validateColor : travelState == "pending" ? inactive : travelState == "completed" ? doneStatus : specialColor,
                                            ),
                                            borderRadius: BorderRadius.all(Radius.circular(7))),
                                      )
                                    ],
                                  )
                                )
                            ]
                        )
                      ]
                  ),
                  Spacer(),
                  if(isUser && travelState == 'pending')
                    ElevatedButton.icon(
                        onPressed: (){
                          if(action !=null){
                              action!();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: validateColor
                        ),
                        icon: Icon(Icons.publish_rounded),
                        label: Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "Publier",
                              style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
                            )
                        )
                    ).paddingSymmetric(vertical: 10, horizontal: 20),
                  if(!isUser)
                    SizedBox(
                      width: homePage ? Get.width/1.3 : Get.width/1.2,
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
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                    image: NetworkImage(this.imageUrl, headers: WOHConstants.getTokenHeaders()),
                                    placeholder: AssetImage(
                                        "assets/img/loading.gif"),
                                    imageErrorBuilder:
                                        (context, error, stackTrace) {
                                      return Image.asset(
                                          "assets/img/téléchargement (1).png",
                                          width: 40,
                                          height: 40,
                                          fit: BoxFit.fitWidth);
                                    },
                                  )
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(this.user, style: TextStyle(fontSize: 12, color: appColor, overflow: TextOverflow.ellipsis)),
                                    Text("⭐️ ${this.rating}", style: TextStyle(fontSize: 13, color: appColor))
                                  ]
                                )
                            ),
                            Text(this.depDate, style: Get.textTheme.displayLarge!.merge(TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: appColor)))
                          ]
                      )
                    )
                ]
            )
        )
    );
  }
}