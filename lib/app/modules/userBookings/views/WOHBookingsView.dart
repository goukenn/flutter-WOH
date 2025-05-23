// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../WOHPalette.dart';
import '../../../../common/WOHUi.dart';
import '../../../../WOHColorConstants.dart';
import '../../../../WOHConstants.dart';
import '../../../routes/WOHRoutes.dart';
import '../../auth/controllers/WOHAuthController.dart';
import '../../global_widgets/WOHCardWidget.dart';
import '../../root/controllers/WOHRootController.dart';
import '../controllers/WOHBookingsController.dart';
import '../widgets/WOHBookingsListLoaderWidget.dart';

class WOHBookingsView extends GetView<WOHBookingsController> {

  @override
  Widget build(BuildContext context) {

    Get.lazyPut<WOHRootController>(
          () => WOHRootController(),
    );
    Get.lazyPut(() => WOHAuthController());

    var firstDate = DateFormat("dd, MMMM", "fr_CA").format(DateTime.now()).toString().obs;
    var lastDate = DateFormat("dd, MMMM", "fr_CA").format(DateTime.now().add(Duration(days: 5))).toString().obs;
    controller.dateController.text = "$firstDate - $lastDate";

    return Scaffold(
        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: true,
        floatingActionButton: Obx(() =>
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            !Get.find<WOHAuthController>().isEmployee.value ?
            FloatingActionButton.extended(
                backgroundColor: interfaceColor,
                heroTag: null,
                //backgroundColor: interfaceColor,
                onPressed: ()=> Get.toNamed(WOHRoutes.ADD_SHIPPING_FORM),
                label: Text('Prendre rendez-vous'),
                icon: Icon(Icons.add, color: WOHPalette.background)
            ) : FloatingActionButton.extended(
                backgroundColor: employeeInterfaceColor,
                heroTag: null,
                //backgroundColor: interfaceColor,
                onPressed: ()=> Get.toNamed(WOHRoutes.ADD_SHIPPING_FORM),
                label: Text('Ajouter un rendez-vous'),
                icon: Icon(Icons.add, color: WOHPalette.background)
            ),
            if(Get.width > 500)
            SizedBox(width: 70)
          ],
        )),

        appBar: !Get.find<WOHAuthController>().isEmployee.value ? AppBar(
          backgroundColor: appBarColor,
          title: Obx(() => Text(
            "Mes rendez-vous, ${controller.items.length}",
            style: Get.textTheme.titleLarge!.merge(TextStyle(color: Colors.white)),
          )),
          centerTitle: true,
          leading: Obx(() =>
          controller.showBackButton.value ? IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => {
                controller.showBackButton.value = false,
                Navigator.pop(context)
              }
          ) : SizedBox()
          ),
        ) : null,
        body: RefreshIndicator(
            onRefresh: () async {
              controller.refreshBookings();
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(Get.find<WOHAuthController>().isEmployee.value)
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: SizedBox(
                              width: Get.width/2,
                              child: TextFormField(
                                //controller: controller.textEditingController,
                                  style: Get.textTheme.headlineMedium,
                                  onChanged: (value)=> controller.filterSearchAppointment(value),
                                  autofocus: false,
                                  cursorColor: Get.theme.focusColor,
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 1, color: buttonColor),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      hintText: "Search here...",
                                      filled: true,
                                      fillColor: Colors.white,
                                      suffixIcon: Icon(Icons.search),
                                      hintStyle: Get.textTheme.labelSmall,
                                      contentPadding: EdgeInsets.all(10)
                                  )
                              )
                          ),
                        ),
                        Spacer(),
                        Container(
                            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                            width: MediaQuery.of(context).size.width / 2.5,
                            height: 50,
                            child: TextFormField(
                              controller: controller.dateController,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0),
                                      borderSide: BorderSide(color: Colors.black)),
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  contentPadding: EdgeInsets.all(10),
                                  filled: true,
                                  fillColor: WOHPalette.background,
                                  suffixIcon: IconButton(
                                      icon: Icon(Icons.calendar_today),
                                      onPressed: () {
                                        controller.appointments.value = controller.items;
                                        controller.selectDate();
                                      }
                                  )
                              ),
                              readOnly: true,
                            )
                        )
                      ]
                    ),
                  Obx(() => Container(
                      height: Get.height,
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      decoration: WOHUi.getBoxDecoration(color: backgroundColor),
                      child:  controller.isLoading.value ? WOHBookingsListLoaderWidget() :
                      controller.items.isNotEmpty ?
                      Get.find<WOHAuthController>().isEmployee.value ? MyAppointments(context) : MyBookings(context)
                          : SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: MediaQuery.of(context).size.height/4),
                            FaIcon(FontAwesomeIcons.folderOpen, color: inactive.withAlpha((255 * 0.3).toInt()),size: 80),
                            Text('Aucun rendez-vous trouvé', style: Get.textTheme.headlineSmall!.merge(TextStyle(color: inactive.withAlpha((255 * 0.3).toInt())))),
                          ]
                        )
                      )
                  ))
                ]
              )
            )
        )
    );
  }

  Widget MyAppointments(BuildContext context){
    return Obx(() => Column(
      children: [
        Expanded(
            child: DataTable2(
              columnSpacing: defaultPadding,
              headingRowColor: MaterialStateColor.resolveWith((states) => appBarColor),
              minWidth: 800,
              headingRowHeight: 60,
              dataRowHeight: 80,
              showCheckboxColumn: false,
              columns: [
                DataColumn(
                  label: Text("Reference", style: Get.textTheme.displayMedium!.merge(TextStyle(fontSize: 20, color: Colors.white))),
                ),
                DataColumn(
                  label: Text("Service", style: Get.textTheme.displayMedium!.merge(TextStyle(fontSize: 20, color: Colors.white))),
                ),
                DataColumn(
                  label: Text("Client", style: Get.textTheme.displayMedium!.merge(TextStyle(fontSize: 20, color: Colors.white))),
                ),
                DataColumn(
                  label: Text("Date/heure", style: Get.textTheme.displayMedium!.merge(TextStyle(fontSize: 20, color: Colors.white))),
                ),
                DataColumn(
                  label: Text(""),
                ),
                DataColumn(
                  label: Text("Stage", style: Get.textTheme.displayMedium!.merge(TextStyle(fontSize: 20, color: Colors.white))),
                ),
              ],
              rows: List.generate(
                  controller.items.length,
                      (index){
                    var bookingState = controller.items[index]['state'];
                    var start = DateFormat("dd-MM-yyyy HH:mm").format(DateTime.parse(controller.items[index]['datetime_start'])).toString();
                    var end = DateFormat("HH:mm").format(DateTime.parse(controller.items[index]['datetime_end'])).toString();

                    return DataRow(
                      onSelectChanged: (value)async{
                        showDialog(
                            context: context,
                            builder: (_){
                              return SpinKitFadingCircle(color: Colors.white, size: 50);
                            });

                        await controller.getServiceDto(controller.items[index]['service_id'][0], controller.items[index], false);

                      },
                        cells: [
                          DataCell(Text(controller.items[index]["name"], style: Get.textTheme.headlineMedium)),
                          DataCell(Text(controller.items[index]['service_id'][1].split(">").first, style: Get.textTheme.headlineMedium)),
                          DataCell(Text(controller.items[index]['partner_id'][1], style: Get.textTheme.headlineMedium)),
                          DataCell(Text("$start - $end", style: Get.textTheme.headlineMedium)),
                          DataCell(SizedBox()),
                          DataCell(Text(controller.items[index]['state'].toUpperCase(), style: Get.textTheme.displayMedium!.merge(
                              TextStyle(color: bookingState == 'reserved' ? newStatus : bookingState == 'done' ? doneStatus : bookingState == 'cancel' ? specialColor : inactive)))
                          )
                        ]
                    );
                  }
              ),
            )
        )
      ],
    ));
  }

  Widget MyBookings(BuildContext context){

    Get.lazyPut(() => WOHAuthController());

    return Obx(() => Column(
      children: [
        Expanded(
            child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: controller.items.length+1 ,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (context, index) {
                  var employeeId = 0;
                  var data = Get.find<WOHAuthController>().resources;
                  if (index == controller.items.length) {
                    return SizedBox(height: Get.height/2);
                  } else {
                    for(var i in data){
                      if(i['id'] == controller.items[index]['resource_id'][0]){
                        employeeId = i['employee_id'][0];
                      }
                    }
                    return InkWell(
                      onTap: ()async{

                        /*ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Loading data..."),
                          duration: Duration(seconds: 2),
                        ));*/

                        showDialog(
                            context: context,
                            builder: (_){
                              return SpinKitFadingCircle(color: Colors.white, size: 50);
                            });
                        await controller.getServiceDto(controller.items[index]['service_id'][0], controller.items[index], true);

                      },
                      child: WOHCardWidget(
                        shippingDateStart: controller.items[index]['datetime_start'],
                        shippingDateEnd: controller.items[index]['datetime_end'],
                        imageUrl: "${WOHConstants.serverPort}/image/hr.employee/$employeeId/image_1920?unique=true&file_response=true",
                        code: controller.items[index]['name'],
                        bookingState: controller.items[index]['state'],
                        //price: controller.items[index]['shipping_price'],
                        agent: controller.items[index]['resource_id'][1],
                        service: controller.items[index]['service_id'][1],
                        onTap: ()async{
                          showDialog(
                              context: context,
                              builder: (_){
                                return SpinKitFadingCircle(color: Colors.white, size: 50);
                              });
                          await controller.getServiceDto(controller.items[index]['service_id'][0], controller.items[index], true);
                        }
                      )
                    );
                  }
                })
        )
      ],
    ));
  }

  Widget buildLoader() {
    return Container(
        width: 100,
        height: 100,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Image.asset(
            'assets/img/loading.gif',
            fit: BoxFit.cover,
            width: double.infinity,
            height: 100,
          ),
        ));
  }
}