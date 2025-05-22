// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable, library_private_types_in_public_api
import 'package:flutter/material.dart'; 
import 'WOHDelayedAnimationState.dart';

class WOHDelayedAnimation extends StatefulWidget {
  final Widget? child;
  final int? delay;
  const WOHDelayedAnimation({super.key, this.delay, this.child });

  @override
  WOHDelayedAnimationState createState() => WOHDelayedAnimationState();
}
