// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../WOHColorConstants.dart';
import '../../../../WOHPalette.dart';
import '../../../../common/WOHUi.dart';
import '../../userBookings/controllers/WOHBookingsController.dart';
import '../widgets/WOHBookingsListLoaderWidget.dart';

class WOHFacturationView extends GetView<WOHBookingsController> {

  @override
  Widget build(BuildContext context) {

    var firstDate = DateFormat("dd, MMMM", "fr_CA").format(DateTime.now()).toString().obs;
    var lastDate = DateFormat("dd, MMMM", "fr_CA").format(DateTime.now().add(Duration(days: 5))).toString().obs;
    controller.dateController.text = "$firstDate - $lastDate";

    return Scaffold(
        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: true,
        floatingActionButton: Padding(
            padding: EdgeInsets.only(bottom: 70),
          child: Obx(() =>
              FloatingActionButton.extended(
                  backgroundColor: employeeInterfaceColor,
                  heroTag: null,
                  onPressed: ()=> {},
                  label: Text(controller.totalInvoice.value.toString()),
                  icon: Icon(Icons.attach_money, color: WOHPalette.background)
              )
          )
        ),
        appBar: null,
        body: RefreshIndicator(
            onRefresh: () async {
              controller.refreshBookings();
            },
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: SizedBox(
                                  width: Get.width/2,
                                  child: TextFormField(
                                    //controller: controller.textEditingController,
                                      style: Get.textTheme.headlineMedium,
                                      onChanged: (value)=> controller.filterSearchInvoice(value),
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
                                            controller.selectDateInterval();
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
                          controller.receipts.isNotEmpty ?
                          MyAppointments(context)
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
                  label: Text("Client", style: Get.textTheme.displayMedium!.merge(TextStyle(fontSize: 20, color: Colors.white))),
                ),
                DataColumn(
                  label: Text("Facturation", style: Get.textTheme.displayMedium!.merge(TextStyle(fontSize: 20, color: Colors.white))),
                ),
                DataColumn(
                  label: Text("Total", style: Get.textTheme.displayMedium!.merge(TextStyle(fontSize: 20, color: Colors.white))),
                ),
                DataColumn(
                  label: Text("état du paiement", style: Get.textTheme.displayMedium!.merge(TextStyle(fontSize: 20, color: Colors.white))),
                ),
              ],
              rows: List.generate(
                  controller.receipts.length,
                      (index){

                    var bookingState = controller.receipts[index]['payment_state'];
                    var start = DateTime.parse(controller.receipts[index]['invoice_date']);
                    var end = DateTime.now();

                    var difference = daysBetween(start, end);

                    return DataRow(
                        onSelectChanged: (value)async{
                          var invoiceLine = [];
                          invoiceLine = await controller.getInvoiceLine(controller.receipts[index]['invoice_line_ids']);

                          if(invoiceLine.isNotEmpty){
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) {
                                return Card(
                                    color: background,
                                    margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width / 2),
                                  child: Container(
                                    height: Get.height/2,
                                    padding: EdgeInsets.all(10),
                                    child: Banner(
                                        location: BannerLocation.topEnd,
                                        message: bookingState,
                                        color: bookingState == "paid" ? validateColor : specialColor,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: IconButton(
                                                onPressed: ()=> Navigator.pop(context),
                                                icon: Icon(Icons.arrow_back_outlined, size: 30),
                                              ),
                                            ),
                                            SizedBox(height: 30),
                                            RichText(
                                                text: TextSpan(
                                                    children: [
                                                      TextSpan(text: "Facture Client\n", style: Get.textTheme.headlineMedium),
                                                      TextSpan(text: controller.receipts[index]["display_name"], style: Get.textTheme.displayMedium!.merge(TextStyle(fontSize: 30)))
                                                    ]
                                                )
                                            ),
                                            SizedBox(height: 20),
                                            Row(
                                              children: [
                                                RichText(
                                                    text: TextSpan(
                                                        children: [
                                                          TextSpan(text: "Client    ", style: Get.textTheme.headlineMedium),
                                                          TextSpan(text: controller.receipts[index]["invoice_partner_display_name"], style: Get.textTheme.displayMedium!.merge(TextStyle(color: employeeInterfaceColor)))
                                                        ]
                                                    )
                                                ),
                                                Spacer(),
                                                RichText(
                                                    text: TextSpan(
                                                        children: [
                                                          TextSpan(text: "Date de WOHFacturation   ", style: Get.textTheme.headlineMedium),
                                                          TextSpan(text: controller.receipts[index]["invoice_date"], style: Get.textTheme.displayMedium)
                                                        ]
                                                    )
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 20),
                                            RichText(
                                                text: TextSpan(
                                                    children: [
                                                      TextSpan(text: "Référence du paiement   ", style: Get.textTheme.headlineMedium),
                                                      TextSpan(text: controller.receipts[index]["payment_reference"], style: Get.textTheme.displayMedium)
                                                    ]
                                                )
                                            ),
                                            SizedBox(height: 30),
                                            Expanded(
                                                child: DataTable2(
                                                  columnSpacing: defaultPadding,
                                                  headingRowColor: MaterialStateColor.resolveWith((states) => inactive),
                                                  minWidth: 800,
                                                  headingRowHeight: 60,
                                                  dataRowHeight: 80,
                                                  showCheckboxColumn: false,
                                                  columns: [
                                                    DataColumn(
                                                      label: Text("Article", style: Get.textTheme.displayMedium!.merge(TextStyle(fontSize: 20, color: Colors.white))),
                                                    ),
                                                    DataColumn(
                                                      label: Text("Quantité", style: Get.textTheme.displayMedium!.merge(TextStyle(fontSize: 20, color: Colors.white))),
                                                    ),
                                                    DataColumn(
                                                      label: Text("Prix", style: Get.textTheme.displayMedium!.merge(TextStyle(fontSize: 20, color: Colors.white))),
                                                    ),
                                                    DataColumn(
                                                      label: Text("DISCOUNT(FIXED)", style: Get.textTheme.displayMedium!.merge(TextStyle(fontSize: 20, color: Colors.white))),
                                                    ),
                                                    DataColumn(
                                                      label: Text("SOUS-TOTAL", style: Get.textTheme.displayMedium!.merge(TextStyle(fontSize: 20, color: Colors.white))),
                                                    ),
                                                  ],
                                                  rows: List.generate(controller.invoiceArticles.length,
                                                          (index) =>
                                                          DataRow(
                                                              cells: [
                                                                DataCell(Text(controller.invoiceArticles[index]["product_id"][1].split(">").first, style: Get.textTheme.headlineMedium)),
                                                                DataCell(Text(controller.invoiceArticles[index]["quantity"].toString(), style: Get.textTheme.headlineMedium)),
                                                                DataCell(Text(controller.invoiceArticles[index]['price_unit'].toString(), style: Get.textTheme.headlineMedium)),
                                                                DataCell(Text(controller.invoiceArticles[index]['discount_fixed'].toString(), style: Get.textTheme.headlineMedium)),
                                                                DataCell(Text(controller.invoiceArticles[index]['price_subtotal'].toString(), style: Get.textTheme.headlineMedium)),
                                                              ]
                                                          )
                                                  ),
                                                )
                                            ),
                                            SizedBox(height: 15),
                                            /*Align(
                                        alignment: Alignment.bottomRight,
                                        child: SizedBox(
                                          width: 100,
                                          child: Row(
                                            children: [
                                              Column(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Text("Montant HT:", style: Get.textTheme.headlineMedium),
                                                    Text("TVA 0%:", style: Get.textTheme.headlineMedium),
                                                    Text("Total:", style: Get.textTheme.headlineMedium)
                                                  ]
                                              ),
                                              Column(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Text(controller.invoiceArticles[index]['discount_fixed'].toString(), style: Get.textTheme.headlineMedium),
                                                    Text("0.00", style: Get.textTheme.headlineMedium),
                                                    Text(controller.invoiceArticles[index]['discount_fixed'].toString(), style: Get.textTheme.headlineMedium)
                                                  ]
                                              )
                                            ],
                                          )
                                        )
                                      )*/
                                          ],
                                        )
                                    ),
                                  )
                                );
                              },
                            );
                          }else{
                            print("Empty");
                          }
                        },
                        cells: [
                          DataCell(Text(controller.receipts[index]["display_name"], style: Get.textTheme.headlineMedium)),
                          DataCell(Text(controller.receipts[index]['invoice_partner_display_name'], style: Get.textTheme.headlineMedium)),
                          DataCell(Text(controller.receipts[index]['invoice_date'], style: Get.textTheme.headlineMedium)),
                          DataCell(Text(controller.receipts[index]['amount_total_signed'].toString(), style: Get.textTheme.headlineMedium)),
                          DataCell(
                              Text(controller.receipts[index]['payment_state'].toUpperCase(), style: Get.textTheme.displayMedium!.merge(
                                  TextStyle(color: bookingState == 'paid' ? validateColor : specialColor)))
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

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

}