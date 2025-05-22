// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'dart:async';

class WOHDelayedAnimation extends StatefulWidget {
  final Widget? child;
  final int? delay;
  const WOHDelayedAnimation({super.key, this.delay, this.child });

  @override
  _DelayedAnimationState createState() => _DelayedAnimationState();
}

class _DelayedAnimationState extends State<WOHDelayedAnimation>
    with SingleTickerProviderStateMixin {
   late AnimationController _controller;
   late Animation<Offset> _animOffset;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    final curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
    );

    _animOffset = Tween<Offset>(
      begin: Offset(2.0, 0.0),
      end: Offset(0, 0),
    ).animate(curve);

    Timer(Duration(milliseconds: widget.delay!), () {
      _controller.forward();
    });
  }

  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
    );
  }
}