// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable
import 'package:flutter/widgets.dart';

import '../widgets/WOHContactView.dart';

class HomeList {
  HomeList({
    this.imagePath = '',
    this.title
  });

  String imagePath;
  String title;

  static List<HomeList> homeList = [
    HomeList(
        imagePath: 'assets/img/240_F_142999858_7EZ3JksoU3f4zly0MuY3uqoxhKdUwN5u.jpeg',
        title: 'Prendre \nRendez-Vous'
    ),
    HomeList(
        imagePath: 'assets/img/supportIcon.png',
        title: "Nous Contacter"
    ),
    HomeList(
        imagePath: 'assets/img/240_F_459165652_XG7N90pOALqtOIE6V4zC8bOkkXNGKpzv.jpeg',
        title: "Localisation"
    ),
    HomeList(
        imagePath: 'assets/img/240_F_163774420_stB9uyuZEodwTdSBaJKiybxDyl2FfqIN.jpeg',
        title: "Carte de Fidélité"
    ),
    HomeList(
        imagePath: 'assets/img/gallery2.jpeg',
        title: "Gallery"
    ),
    HomeList(
        imagePath: 'assets/img/240_F_480329143_udbywRAkIk8LObNgwFnLhWqbOyjenXca.jpeg',
        title: "Avis Clients"
    ),
  ];
}