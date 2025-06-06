// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:com_igkdev_new_app/WOHConstants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/WOHUi.dart'; 
import '../../../common/WOHUuid.dart';
import '../../models/WOHMediaModel.dart';
import '../../repositories/WOHUploadRepository.dart';

class WOHImagesFieldController extends GetxController {
  final images = <File>[].obs;
  List<String> uuids = <String>[];
  final uploading = false.obs;
  late WOHUploadRepository _uploadRepository;

  WOHImagesFieldController() {
    _uploadRepository = new WOHUploadRepository( WOHConstants.getClientProvider('odoo'));
  }

 

  void reset() {
    images.clear();
    uploading.value = false;
  }

  Future pickImage(ImageSource source, String field, ValueChanged<String> uploadCompleted) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile = await imagePicker.pickImage(source: source, imageQuality: 80);
    File imageFile = File(pickedFile!.path);
    print(imageFile);
    try {
      uploading.value = true;
      //var _uuid = await _uploadRepository.image(imageFile);
      //uuids.add(_uuid);
      //images.add(imageFile);
      //uploadCompleted(_uuid);
      uploading.value = false;
    } catch (e) {
      uploading.value = false;
      Get.showSnackbar(WOHUi.ErrorSnackBar(message: e.toString()));
    }
    }

  Future<void> deleteUploaded() async {
    if (uuids.isNotEmpty) {
      final done = await _uploadRepository.deleteAll(uuids);
      if (done) {
        uuids = <String>[];
        images.clear();
      }
    }
  }
}

class WOHImagesFieldWidget extends StatelessWidget {
  WOHImagesFieldWidget({
    super.key,
    required this.label,
    required this.tag,
    required this.field,
    this.placeholder = '',
    this.buttonText = '',
    required this.uploadCompleted,
    this.initialImages,
    required this.reset,
  });

  final String label;
  final String placeholder;
  final String buttonText;
  final String tag;
  final String field;
  final List<WOHMediaModel>? initialImages;
  final ValueChanged<String> uploadCompleted;
  final ValueChanged<List<String>> reset;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WOHImagesFieldController(), tag: tag);
    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 10, left: 20, right: 20),
      margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
      decoration: BoxDecoration(
          color: Get.theme.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(color: Get.theme.focusColor.withAlpha((255 * 0.1).toInt()), blurRadius: 10, offset: Offset(0, 5)),
          ],
          border: Border.all(color: Get.theme.focusColor.withAlpha((255 * 0.05).toInt()))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 60,
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    label,
                    style: Get.textTheme.bodyLarge,
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () async {
                  await controller.deleteUploaded();
                  reset(controller.uuids);
                },
                shape: StadiumBorder(),
                color: Get.theme.focusColor.withAlpha((255 * 0.1).toInt()),
                child: Text(buttonText, style: Get.textTheme.bodyLarge),
                elevation: 0,
                hoverElevation: 0,
                focusElevation: 0,
                highlightElevation: 0,
              ),
            ],
          ),
          Obx(() {
            return buildImages(initialImages!, controller.images);
          })
        ],
      ),
    );
  }

  Widget buildLoader() {
    return Container(
        width: 100,
        height: 100,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Image.asset(
            'assets/img/loading.gif',
            fit: BoxFit.cover,
            width: double.infinity,
            height: 100,
          ),
        ));
  }

  Widget buildImages(List<WOHMediaModel> initialImages, List<File> images) {
    final controller = Get.put(WOHImagesFieldController(), tag: tag);
    List<Widget> thumbs = [];
    thumbs.addAll(
      (initialImages
              .where((image) {
                return !WOHUuid.isUuid(image.id!);
              })
              .map((image) => ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: CachedNetworkImage(
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                      imageUrl: image.thumb ?? '',
                      placeholder: (context, url) => Image.asset(
                        'assets/img/loading.gif',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 100,
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error_outline),
                    ),
                  ))
              .toList()),
    );
    thumbs.addAll(images
            .map((image) => ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Image.file(
                    image,
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                ))
            .toList());

    thumbs.add(
      Obx(() {
        if (controller.uploading.isTrue) {
          return buildLoader();
        } else {
          return GestureDetector(
            onTap: () async {
              await controller.pickImage(ImageSource.gallery, field, uploadCompleted);
            },
            child: Container(
              width: 100,
              height: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: Get.theme.focusColor.withAlpha((255 * 0.1).toInt()), borderRadius: BorderRadius.circular(10)),
              child: Icon(Icons.add_photo_alternate_outlined, size: 42, color: Get.theme.focusColor.withAlpha((255 * 0.4).toInt())),
            ),
          );
        }
      }),
    );
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: 5,
        runSpacing: 8,
        children: thumbs,
      ),
    );
  }
}