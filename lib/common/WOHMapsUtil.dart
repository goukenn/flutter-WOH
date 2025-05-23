// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
//import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:map_launcher/map_launcher.dart' as launcher;

import '../app/models/WOHAddressModel.dart';
import '../app/providers/WOHLaravelApiClientProvider.dart';
import '../app/services/WOHSettingsService.dart';
// import 'WOHUi.dart';

class WOHMapsUtil {
  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  static Future<Marker> getMarker({WOHAddressModel? address, String id = '', String description = ''}) async {
    final Uint8List markerIcon = await getBytesFromAsset('assets/img/marker.png', 120);
    final Marker marker = Marker(
        markerId: MarkerId(id),
        icon: BitmapDescriptor.bytes(markerIcon),
//        onTap: () {
//          //print(res.name);
//        },
        anchor: Offset(0.5, 0.5),
        infoWindow: InfoWindow(
            title: description,
            //snippet: getDistance(res['distance'].toDouble(), setting.value.distanceUnit),
            onTap: () {
              //print(WOHCustomTrace(StackTrace.current, message: 'Info Window'));
            }),
        position: address!.getLatLng());

    return marker;
  }

  static Widget getStaticMaps(List<LatLng> latLngs, {double? height = 168, String size = '400x160', double zoom = 13}) {
    String _markers = '';

    latLngs.forEach((element) {
      _markers += 'markers=icon:${Get.find<WOHLaravelApiClientProvider>().getBaseUrl("images")}marker.png%7Cscale:5%7C'
          '${element.latitude},'
          '${element.longitude}&';
    });

    return CachedNetworkImage(
      height: height,
      width: double.infinity,
      fit: BoxFit.cover,
      imageUrl: 'https://maps.googleapis.com/maps/api/staticmap?'
          'zoom=$zoom&'
          'size=$size&'
          'language=${Get.locale?.languageCode}&'
          'maptype=roadmap&$_markers'
          'key=${Get.find<WOHSettingsService>().setting.value.googleMapsKey}',
      placeholder: (context, url) => Image.asset(
        'assets/img/loading.gif',
        fit: BoxFit.cover,
        width: double.infinity,
        height: height,
      ),
      errorWidget: (context, url, error) => Icon(Icons.error_outline),
    );
  }

  // static void openMapsSheet(context, LatLng latLng, String? _title) async {
  //   try {
  //     final coords = launcher.Coords(latLng.latitude, latLng.longitude);
  //     final title = _title ?? "";
  //     final availableMaps = await launcher.MapLauncher.installedMaps;
  //
  //     showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return SafeArea(
  //           child: SingleChildScrollView(
  //             child: Container(
  //               child: Wrap(
  //                 children: <Widget>[
  //                   for (var map in availableMaps)
  //                     ListTile(
  //                       onTap: () => map.showDirections(
  //                         directionsMode: launcher.DirectionsMode.driving,
  //                         destinationTitle: title,
  //                         destination: coords,
  //                       ),
  //                       title: Text(map.mapName, style: Get.textTheme.bodyMedium),
  //                       leading: SvgPicture.asset(
  //                         map.icon,
  //                         height: 30.0,
  //                         width: 30.0,
  //                       ),
  //                     ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //     );
  //   } catch (e) {
  //     //Get.showSnackbar(WOHUi.ErrorSnackBar(message: e.toString()));
  //   }
  // }
}