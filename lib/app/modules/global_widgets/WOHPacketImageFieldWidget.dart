// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_function_declarations_over_variables,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../repositories/WOHUploadRepository.dart';

class WOHPacketImageFieldController extends GetxController {
  Rx<File> image = Rx<File>(null);
  String uuid;
  final uploading = false.obs;
  var url = ''.obs;
  WOHUploadRepository _uploadRepository;

  WOHPacketImageFieldController() {
    _uploadRepository = new WOHUploadRepository();
  }

  @override
  void onInit() {
    super.onInit();
  }

  void reset() {
    image.value = null;
    uploading.value = false;
  }

  Future <File> pickImage(ImageSource source, String field, ValueChanged<String> uploadCompleted) async {
    //image.value = null;
    ImagePicker imagePicker = ImagePicker();
    uploading.value = true;
    await deleteUploaded();
    XFile pickedFile = await imagePicker.pickImage(source: source, imageQuality: 80);
    File imageFile = File(pickedFile.path);
    image.value = imageFile;
    uploading.value = false;
    print(imageFile);
    return imageFile;

  }

  Future<void> deleteUploaded() async {
    final done = await _uploadRepository.delete(uuid);
    if (done) {
      uuid = null;
      image = Rx<File>(null);
    }
    }
}

class WOHPacketImageFieldWidget extends StatelessWidget {
  WOHPacketImageFieldWidget({
    super.key,
    required this.label,
    required this.tag,
    required this.field,
    this.placeholder,
    this.buttonText,
    required this.uploadCompleted,
    this.initialImage,
    required this.reset,
  });

  final String label;
  final String placeholder;
  final String buttonText;
  final String tag;
  final String field;
  final String initialImage;
  final ValueChanged<String> uploadCompleted;
  final ValueChanged<String> reset;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WOHPacketImageFieldController(), tag: tag);
    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 10, left: 20, right: 20),
      margin: EdgeInsets.only( top: 20, bottom: 20),
      decoration: BoxDecoration(
          color: Get.theme.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(color: Get.theme.focusColor.withAlpha((255 * 0.1).toInt()), blurRadius: 10, offset: Offset(0, 5)),
          ],
          border: Border.all(color: Get.theme.focusColor.withAlpha((255 * 0.05).toInt()))),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 60,
                  width: 60,
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    label,
                    style: Get.textTheme.bodyLarge,
                    textAlign: TextAlign.start,
                  ),
                ),
              ),

            ],
          ),
          Obx(() {
            return buildImage(initialImage, controller.image.value);
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
            width: 60,
            height: 100,
          ),
        ));
  }
  Widget buildImage(String initialImage, File image) {
    final controller = Get.put(WOHPacketImageFieldController(), tag: tag);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: 5,
        runSpacing: 8,
        children: [
          if (image == null)
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: CachedNetworkImage(
                height: 100,
                width: 100,
                fit: BoxFit.cover,
                imageUrl: initialImage,
                placeholder: (context, url) => Image.asset(
                  'assets/img/loading.gif',
                  fit: BoxFit.cover,
                  width: 60,
                  height: 100,
                ),
                errorWidget: (context, url, error) => Icon(Icons.error_outline),
              ),
            ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Image.file(
              image,
              fit: BoxFit.cover,
              width: 100,
              height: 100,
            ),
          ),
          Obx(() {
            if (controller.uploading.isTrue)
              return buildLoader();
            else
              return GestureDetector(
                  onTap: () {
                    showDialog(
                        context: Get.context!,
                        builder: (_){
                          return AlertDialog(
                            content: Container(
                                height: 170,
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    ListTile(
                                      onTap: ()async{
                                        await controller.pickImage(ImageSource.camera, field, uploadCompleted);
                                        Navigator.pop(Get.context!);
                                      },
                                      leading: Icon(FontAwesomeIcons.camera),
                                      title: Text('Take a picture', style: Get.textTheme.displayLarge!.merge(TextStyle(fontSize: 15))),
                                    ),
                                    ListTile(
                                      onTap: ()async{
                                        await controller.pickImage(ImageSource.gallery, field, uploadCompleted);
                                        Navigator.pop(Get.context!);
                                      },
                                      leading: Icon(FontAwesomeIcons.image),
                                      title: Text('Upload an image', style: Get.textTheme.displayLarge!.merge(TextStyle(fontSize: 15))),
                                    )
                                  ],
                                )
                            ),
                          );
                        });
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Get.theme.focusColor.withAlpha((255 * 0.1).toInt()), borderRadius: BorderRadius.circular(10)),
                    child: Icon(Icons.add_photo_alternate_outlined, size: 42, color: Get.theme.focusColor.withAlpha((255 * 0.4).toInt())),
                  )
              );
          }),
        ],
      ),
    );
  }
}