// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:flutter/material.dart';

import '../../../WOHColorConstants.dart';

const Color PRIMARY_COLOR = inactive;
const Color BACKGROUND_COLOR = Color(0xffE2E7F2);

class WOHCustomBottomNavigationBar extends StatefulWidget {
  final Color backgroundColor;
  final Color itemColor;
  final List<WOHCustomBottomNavigationItem> children;
  final Function(int) onChange;
  final int currentIndex;

  WOHCustomBottomNavigationBar({this.backgroundColor = BACKGROUND_COLOR, this.itemColor = PRIMARY_COLOR, this.currentIndex = 0, required this.children, this.onChange});

  @override
  WOHCustomBottomNavigationBarState createState() => WOHCustomBottomNavigationBarState();
}

class WOHCustomBottomNavigationBarState extends State<WOHCustomBottomNavigationBar> {
  void _changeIndex(int index) {
    widget.onChange(index);
    }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: widget.backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widget.children.map((item) {
          var color = item.color;
          var icon = item.icon;
          var label = item.label;
          int index = widget.children.indexOf(item);
          return GestureDetector(
            onTap: () {
              _changeIndex(index);
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              width: widget.currentIndex == index ? MediaQuery.of(context).size.width / widget.children.length + 20 : 50,
              padding: EdgeInsets.only(left: 10, right: 10),
              margin: EdgeInsets.only(top: 10, bottom: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(color: widget.currentIndex == index ? color.withAlpha((255 * 0.2).toInt()) : Colors.transparent, borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Icon(
                    icon,
                    size: 20,
                    color: widget.currentIndex == index ? color : inactive,
                  ),
                  widget.currentIndex == index
                      ? Expanded(
                          flex: 2,
                          child: Text(
                            label,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: widget.currentIndex == index ? color : color.withAlpha((255 * 0.5).toInt())),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class WOHCustomBottomNavigationItem {
  final IconData icon;
  final String label;
  final Color color;

  WOHCustomBottomNavigationItem({required this.icon, required this.label, this.color});
}