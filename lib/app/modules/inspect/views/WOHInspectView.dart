// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../../WOHColorConstants.dart';
import '../../../providers/WOHOdooApiClientProvider.dart';
// ignore: unused_import
import '../../../services/WOHAuthService.dart';
import '../../../services/WOHMyAuthService.dart';
import '../controllers/WOHInspectController.dart';

class WOHInspectView extends GetView<WOHInspectController> {

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<WOHAuthService>(
          () => WOHAuthService(),
    );
    Get.lazyPut<WOHOdooApiClientProvider>(
          () => WOHOdooApiClientProvider(),
    );
    
    return Obx(() {

      return Scaffold(
          body: RefreshIndicator(
              onRefresh: () async {
                controller.refreshEService();
              },
              child: CustomScrollView(
                primary: true,
                shrinkWrap: false,
                slivers: <Widget>[
                  SliverAppBar(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    expandedHeight: 310,
                    elevation: 0,
                    floating: true,
                    iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
                    centerTitle: true,
                    automaticallyImplyLeading: false,
                    leading: new IconButton(
                      icon: Container(
                        decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                          BoxShadow(
                            color: Get.theme.primaryColor.withAlpha((255 * 0.5).toInt()),
                            blurRadius: 20,
                          ),
                        ]),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: FaIcon(FontAwesomeIcons.arrowLeft, color: buttonColor)
                        )
                      ),
                      onPressed: () => {
                        Get.back()
                      },
                    ),
                    actions: [
                      SizedBox()
                    ],
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      background: Obx(() {
                        return Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: <Widget>[
                          ],
                        );
                      }),
                    ).marginOnly(bottom: 10),
                  ),
                  // WelcomeWidget(),
                  SliverToBoxAdapter(
                    child: SizedBox()
                  )
                ]
              )
          )
        );
    });
  }
}