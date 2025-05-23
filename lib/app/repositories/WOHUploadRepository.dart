// ignore_for_file:avoid_init_to_null,avoid_print,constant_identifier_names,file_names,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_interpolation_to_compose_strings,unnecessary_new,unnecessary_this,unused_local_variable, prefer_final_fields
import 'dart:io'; 
import '../models/WOHMyUserModel.dart';
import '../providers/WOHOdooApiClientProvider.dart';

class WOHUploadRepository {
  WOHOdooApiClientProvider _odooApiClient;

  // .ctr default constructor
  WOHUploadRepository(this._odooApiClient);

  Future image(File image, WOHMyUserModel myser) {
    print('Nathalie');
    return _odooApiClient.uploadImage(image, myser);

  }

  Future<String> airImagePacket(List imageFiles, bookingId) {

    return _odooApiClient.uploadAirPacketImage(imageFiles, bookingId);

  }

  Future<String> roadImagePacket(List imageFiles, bookingId) {
    print('Nathalie');
    return _odooApiClient.uploadRoadPacketImage(imageFiles, bookingId);

  }

  Future<bool> delete(String uuid) {
    return _odooApiClient.deleteUploaded(uuid);
  }

  Future<bool> deleteAll(List<String> uuids) {
    return _odooApiClient.deleteAllUploaded(uuids);
  }
}