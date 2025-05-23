// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
 

class WOHHomeView {
  WOHHomeView({
    this.imagePath = '',
    required this.title
  });

  String imagePath;
  String title;

  static List<WOHHomeView> homeList = [
    WOHHomeView(
        imagePath: 'assets/img/240_F_142999858_7EZ3JksoU3f4zly0MuY3uqoxhKdUwN5u.jpeg',
        title: 'Prendre \nRendez-Vous'
    ),
    WOHHomeView(
        imagePath: 'assets/img/supportIcon.png',
        title: "Nous Contacter"
    ),
    WOHHomeView(
        imagePath: 'assets/img/240_F_459165652_XG7N90pOALqtOIE6V4zC8bOkkXNGKpzv.jpeg',
        title: "Localisation"
    ),
    WOHHomeView(
        imagePath: 'assets/img/240_F_163774420_stB9uyuZEodwTdSBaJKiybxDyl2FfqIN.jpeg',
        title: "Carte de Fidélité"
    ),
    WOHHomeView(
        imagePath: 'assets/img/gallery2.jpeg',
        title: "WOHGalleryModel"
    ),
    WOHHomeView(
        imagePath: 'assets/img/240_F_480329143_udbywRAkIk8LObNgwFnLhWqbOyjenXca.jpeg',
        title: "Avis Clients"
    ),
  ];
}