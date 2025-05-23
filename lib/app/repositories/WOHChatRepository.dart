// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/WOHChatModel.dart';
import '../models/WOHMessageModel.dart';

class WOHChatRepository {
  Future<void> addUserInfo(userData) async {
    FirebaseFirestore.instance.collection("users").add(userData).catchError((e) {
      print(e.toString());
    });
  }

  getUserInfo(String token) async {
    return FirebaseFirestore.instance.collection("users").where("token", isEqualTo: token).get().catchError((e) {
      print(e.toString());
    });
  }

  searchByName(String searchField) {
    return FirebaseFirestore.instance.collection("users").where('userName', isEqualTo: searchField).get();
  }

  // Create WOHMessageModel
  Future<void> createMessage(WOHMessageModel message) {
    return FirebaseFirestore.instance.collection("messages").doc(message.id).set(message.toJson()).catchError((e) {
      print(e);
    });
  }

  // to remove message from firebase
  Future<void> deleteMessage(WOHMessageModel message) {
    return FirebaseFirestore.instance.collection("messages").doc(message.id).delete().catchError((e) {
      print(e);
    });
  }

  Stream<QuerySnapshot> getUserMessages(String userId, {perPage = 10}) {
    return FirebaseFirestore.instance.collection("messages").where('visible_to_users', arrayContains: userId).orderBy('time', descending: true).limit(perPage).snapshots();
  }

  Future<WOHMessageModel> getMessage(WOHMessageModel message) {
    return FirebaseFirestore.instance.collection("messages").doc(message.id).get().then((value) {
      return WOHMessageModel.fromDocumentSnapshot(value);
    });
  }

  Stream<QuerySnapshot> getUserMessagesStartAt(String userId, DocumentSnapshot lastDocument, {perPage = 10}) {
    return FirebaseFirestore.instance
        .collection("messages")
        .where('visible_to_users', arrayContains: userId)
        .orderBy('time', descending: true)
        .startAfterDocument(lastDocument)
        .limit(perPage)
        .snapshots();
  }

  Stream<List<WOHChatModel>> getChats(WOHMessageModel message) {
    updateMessage(message.id!, {'read_by_users': message.readByUsers});
    return FirebaseFirestore.instance.collection("messages").doc(message.id).collection("chats").orderBy('time', descending: true).snapshots().map((QuerySnapshot query) {
      List<WOHChatModel> retVal = [];
      query.docs.forEach((element) {
        retVal.add(WOHChatModel.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }

  Future<void> addMessage(WOHMessageModel message, WOHChatModel chat) {
    return FirebaseFirestore.instance.collection("messages").doc(message.id).collection("chats").add(chat.toJson()).whenComplete(() {
      updateMessage(message.id!, message.toUpdatedMap());
    }).catchError((e){
      print(e.toString());
    });
  }

  Future<void> updateMessage(String messageId, Map<String, dynamic> message) {
    return FirebaseFirestore.instance.collection("messages").doc(messageId).update(message).catchError((e) {
      print(e.toString());
    });
  }

  Future<String> uploadFile(File _imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = reference.putFile(_imageFile);
    return uploadTask.then((TaskSnapshot storageTaskSnapshot) {
      return storageTaskSnapshot.ref.getDownloadURL();
    }, onError: (e) {
      throw Exception(e.toString());
    });
  }
}