// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../WOHColorConstants.dart';
import '../../../../WOHConstants.dart';
import '../../../../WOHConstants.dart';
import '../../../routes/WOHRoutes.dart';
import '../../global_widgets/WOHTravelCardWidget.dart';
import '../../global_widgets/WOHLoadingCardsWidget.dart';
import '../../home/controllers/WOHHomeController.dart';
import '../controllers/WOHCategoryController.dart';

class WOHCategoryView extends GetView<WOHCategoryController> {
  @override
  Widget build(BuildContext context) {

    Get.lazyPut<WOHHomeController>(
          () => WOHHomeController(),
    );

    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButton: Obx(() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              if(controller.currentPage.value != 1){
                controller.currentPage.value --;
                controller.refreshPage(controller.currentPage.value);
              }
            },
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 15,
              child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Icon(Icons.arrow_back_ios, color: controller.currentPage.value != 1 ? Colors.black : inactive)
              ),
            ),
          ),
          Card(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text('${controller.currentPage.value} / ${controller.totalPages.value}', textAlign: TextAlign.center, style: Get.textTheme.displayLarge!.merge(TextStyle(fontSize: 14, color: appColor)))
              )
          ),
          InkWell(
            onTap: () {
              if(controller.currentPage.value != controller.totalPages.value){
                controller.currentPage.value ++;
                controller.refreshPage(controller.currentPage.value);
              }
            },
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 15,
              child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Icon(Icons.arrow_forward_ios_sharp, color: controller.currentPage.value != controller.totalPages.value? Colors.black : inactive)
              ),
            ),
          )
        ],
      )),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.refreshPage(1);
        },
        child: CustomScrollView(
          controller: controller.scrollController,
          physics: AlwaysScrollableScrollPhysics(),
          shrinkWrap: false,
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: buttonColor,
              expandedHeight: 140,
              elevation: 0.5,
              primary: true,
              pinned: true,
              floating: false,
              iconTheme: IconThemeData(color: Get.theme.primaryColor),
              title: Container(
                padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                width: 120,
                decoration: BoxDecoration(
                    color: controller.travelType.value != "air" ? Colors.white.withAlpha((255 * 0.4).toInt()) : interfaceColor.withAlpha((255 * 0.4).toInt()),
                    border: Border.all(
                      color: controller.travelType.value != "air" ? Colors.white.withAlpha((255 * 0.2).toInt()) : interfaceColor.withAlpha((255 * 0.2).toInt()),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Text(controller.travelType.value.toUpperCase(), style: Get.textTheme.displayMedium!.merge(TextStyle(color: Colors.white))),
              ),
              centerTitle: true,
              automaticallyImplyLeading: false,
              leading: new IconButton(
                icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () => Get.back(),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20,
                    child: Obx(() => Center(
                      child: Text(controller.travelList.length.toString(),
                          style: Get.textTheme.headlineSmall!.merge(TextStyle(color: interfaceColor))),
                    )),
                  )
                )
              ],
              bottom: PreferredSize(
                  preferredSize: Size.fromHeight(50.0),
                  child: Padding(
                      padding: EdgeInsets.only(bottom: 10, left: 10),
                    child: Row(
                      children: [
                        SizedBox(
                            width: Get.width/1.8,
                            child: TextFormField(
                              //controller: controller.textEditingController,
                                style: Get.textTheme.bodyMedium,
                                onChanged: (value)=> controller.filterSearchResults(value),
                                autofocus: false,
                                cursorColor: Get.theme.focusColor,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 1, color: buttonColor),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    hintText: "Search here...",
                                    filled: true,
                                    fillColor: Colors.white,
                                    suffixIcon: Icon(Icons.search),
                                    hintStyle: Get.textTheme.labelSmall,
                                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10)
                                )
                            )
                        ),
                        Spacer(),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(backgroundColor: interfaceColor),
                          onPressed: ()=> Get.toNamed(WOHRoutes.ADD_TRAVEL_FORM),
                          icon: Icon(Icons.add, color: Colors.white),
                          label: Text('CREATE')
                        ),
                        SizedBox(width: 10)
                      ],
                    )
                  )),
              flexibleSpace: Row(
                children: [
                  Container(
                    width: Get.width,
                    child: FlexibleSpaceBar(
                      background: Container(
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(controller.imageUrl.value), fit: BoxFit.cover)
                        ),
                      ),
                    )
                  )
                ]
              )
            ),
            SliverToBoxAdapter(
              child: Wrap(
                children: [
                  Obx(() => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: controller.loading.value ?
                      WOHLoadingCardsWidget() :
                      ListView.builder(
                        padding: EdgeInsets.only(bottom: 10, top: 10),
                        primary: false,
                        shrinkWrap: true,
                        itemCount: controller.travelList.length,
                        itemBuilder: ((_, index) {
                          Future.delayed(Duration.zero, (){
                            controller.travelList.sort((a, b) => a["departure_date"].compareTo(b["departure_date"]));
                          });
                          return GestureDetector(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width/1.2,
                              child: WOHTravelCardWidget(
                                  isUser: false,
                                  homePage: false,
                                  travelBy: controller.travelList[index]['booking_type'],
                                  depDate: DateFormat("dd MMM yyyy", 'fr_CA').format(DateTime.parse(controller.travelList[index]['departure_date'])).toString().toUpperCase(),
                                  arrTown: controller.travelList[index]['arrival_city_id'][1],
                                  depTown: controller.travelList[index]['departure_city_id'][1],
                                  qty: controller.travelList[index]['kilo_qty'],
                                  price: controller.travelList[index]['price_per_kilo'],
                                  color: background,
                                  text: Text(""),
                                  user: controller.travelList[index]['partner_id'][1],
                                  rating: controller.travelList[index]['average_rating'].toStringAsFixed(1),
                                  imageUrl: '${WOHConstants.serverPort}/image/res.partner/${controller.travelList[index]['partner_id'][0]}/image_1920?unique=true&file_response=true'

                              ),
                            ),
                            onTap: ()=> Get.toNamed(WOHRoutes.TRAVEL_INSPECT, arguments: {'travelCard': controller.travelList[index], 'heroTag': 'services_carousel'}),
                            //Get.toNamed(WOHRoutes.E_SERVICE, arguments: {'eService': travel, 'heroTag': 'services_carousel'})
                          );
                        }),
                      ))
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildSearchBar(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 1.5;
    return Container(
      height: 40,
      width: width,
      margin: EdgeInsets.only(top: 30),
      padding: EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        //controller: controller.textEditingController,
        style: Get.textTheme.bodyMedium,
        onChanged: (value)=> controller.filterSearchResults(value),
        autofocus: false,
        cursorColor: Get.theme.focusColor,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: buttonColor),
              borderRadius: BorderRadius.circular(20.0),
            ),
            hintText: "Search here...",
            filled: true,
            fillColor: Colors.white,
            suffixIcon: Icon(Icons.search),
            hintStyle: Get.textTheme.labelSmall,
            contentPadding: EdgeInsets.all(10)
        ),
      ),
    );
  }
}