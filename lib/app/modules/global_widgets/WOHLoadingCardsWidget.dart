// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:flutter/material.dart';

class WOHLoadingCardsWidget extends StatelessWidget {
  const WOHLoadingCardsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: 3,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          mainAxisExtent: 220.0,
        ),
        shrinkWrap: true,
        primary: false,
        itemBuilder: (context, index) {
          return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              width: double.infinity,
              height: 30,
              child: Image.asset(
                'assets/img/loading.gif',
                fit: BoxFit.cover,
                width: double.infinity,
              )
          );
        });
  }
}