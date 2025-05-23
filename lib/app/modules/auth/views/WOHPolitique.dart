// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/WOHAuthController.dart';

class WOHPolitique extends GetView<WOHAuthController> {
  const WOHPolitique({super.key});


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.colorScheme.secondary,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        centerTitle: true,
        title: Text(
          'WOHPolitique de Confidentialité',
          style: Get.textTheme.displayMedium!.merge(TextStyle(color: Colors.white)),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              'Bienvenue sur l\'application mobile WilliamOnHair ! Nous respectons votre vie privée et nous engageons à protéger vos informations personnelles. Cette WOHPolitique de confidentialité explique les données que nous collectons, la manière dont nous les utilisons et les autorisations nécessaires pour que l\'application fonctionne correctement.',
              style: Get.textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Text(
              '1. Autorisations Requises',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'L\'application WilliamOnHair nécessite certaines autorisations pour fonctionner correctement. Une de ces autorisations est l\'accès à la caméra de votre appareil.',
              style: Get.textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            const Text(
              'Autorisation : android.permission.CAMERA',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Cette autorisation est utilisée uniquement pour vous permettre de prendre des photos ou des vidéos dans le cadre de votre expérience avec WilliamOnHair. Nous n\'utilisons pas la caméra à d\'autres fins et ne collectons aucune donnée vidéo ou photo sans votre consentement explicite.',
              style: Get.textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            const Text(
              '2. Collecte et Utilisation des Données',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Nous ne collectons aucune information personnelle identifiable à moins que vous ne choisissiez de la fournir. Les informations collectées sont utilisées uniquement pour améliorer les fonctionnalités de l\'application et votre expérience utilisateur.',
              style: Get.textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            const Text(
              '3. Partage des Informations',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Nous ne partageons pas vos informations personnelles avec des tiers, sauf si cela est nécessaire pour fournir des services à la demande ou si la loi l\'exige.',
              style: Get.textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            const Text(
              '4. Sécurité des Données',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Nous mettons en place des mesures de sécurité appropriées pour protéger vos données contre tout accès non autorisé ou toute divulgation.',
              style: Get.textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            const Text(
              '5. Consentement',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'En utilisant l\'application WilliamOnHair, vous consentez à cette WOHPolitique de confidentialité et à l\'utilisation des autorisations requises pour le bon fonctionnement de l\'application.',
              style: Get.textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            const Text(
              '6. Modifications de la WOHPolitique de Confidentialité',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Nous pouvons mettre à jour cette WOHPolitique de confidentialité de temps à autre. Vous serez informé de toute modification via l\'application ou d\'autres moyens appropriés.',
              style: Get.textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Text(
              'Si vous avez des questions concernant cette WOHPolitique de confidentialité, n\'hésitez pas à nous contacter.',
              style: Get.textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}