// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable, use_key_in_widget_constructors, library_private_types_in_public_api
import 'package:flutter/material.dart';


import 'WOHFadeInState.dart';

class WOHFadeIn extends StatefulWidget {
  final Widget? child;
  final int? delay;
  const WOHFadeIn({ this.delay, this.child});

  @override
  WOHFadeInState createState() => WOHFadeInState();
}
