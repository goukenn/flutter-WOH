// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class WOHBookingsListLoaderWidget extends StatelessWidget {
  WOHBookingsListLoaderWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.only(bottom: 10, top: 10),
        primary: false,
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (_, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.withAlpha((255 * 0.1).toInt()),
            highlightColor: Colors.grey[200]!.withAlpha((255 * 0.1).toInt()),
            child: Container(
              width: double.maxFinite,
              height: 180,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
            ),
          );
        });
  }
}