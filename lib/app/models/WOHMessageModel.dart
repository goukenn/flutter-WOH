// ignore_for_file:avoid_function_literals_in_foreach_calls,avoid_init_to_null,avoid_print,avoid_unnecessary_containers,constant_identifier_names,empty_catches,empty_constructor_bodies,file_names,library_private_types_in_public_api,no_leading_underscores_for_local_identifiers,non_constant_identifier_names,overridden_fields,prefer_collection_literals,prefer_const_constructors_in_immutables,prefer_final_fields,prefer_interpolation_to_compose_strings,sized_box_for_whitespace,sort_child_properties_last,unnecessary_new,unnecessary_null_comparison,unnecessary_this,unused_field,unused_local_variable,use_key_in_widget_constructors
import 'package:cloud_firestore/cloud_firestore.dart';

import 'parents/WOHModel.dart';
import 'WOHUserModel.dart';

class WOHMessageModel extends WOHModel {
  @override
  String? id;

  // conversation name for example chat with market name
  String? name;

  // Chats messages
  late String lastMessage;

  late int lastMessageTime;

  // Ids of users that read the chat message
  late List<String> readByUsers;

  // Ids of users in this conversation
  late List<String> visibleToUsers;

  // users in the conversation
  List<WOHUserModel>? users;

  WOHMessageModel(this.users, {this.id = null, this.name = '', this.lastMessageTime=0}) {
    visibleToUsers = this.users!.map((user) => user.id!).toList();
    readByUsers = [];
  }

  WOHMessageModel.fromDocumentSnapshot(DocumentSnapshot jsonMap) {
    try {
      id = jsonMap.id;
      name = jsonMap.get('name') != null ? jsonMap.get('name').toString() : '';
      readByUsers = jsonMap.get('read_by_users') != null ? List.from(jsonMap.get('read_by_users')) : [];
      visibleToUsers = jsonMap.get('visible_to_users') != null ? List.from(jsonMap.get('visible_to_users')) : [];
      lastMessage = jsonMap.get('message') != null ? jsonMap.get('message').toString() : '';
      lastMessageTime = jsonMap.get('time') != null ? jsonMap.get('time')! : 0;
      users = jsonMap.get('users') != null
          ? List.from(jsonMap.get('users')).map((element) {
              element['media'] = [
                {'thumb': element['thumb']}
              ];
              return WOHUserModel.fromJson(element);
            }).toList()
          : [];
    } catch (e) {
      id = '';
      name = '';
      readByUsers = [];
      users = [];
      lastMessage = '';
      lastMessageTime = 0;
    }
  }

  @override
  Map<String, dynamic> toJson() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    map["users"] = users!.map((element) => element.toRestrictMap()).toSet().toList();
    map["visible_to_users"] = users!.map((element) => element.id).toSet().toList();
    map["read_by_users"] = readByUsers;
    map["message"] = lastMessage;
    map["time"] = lastMessageTime;
    return map;
  }

  Map<String, dynamic> toUpdatedMap() {
    var map = new Map<String, dynamic>();
    map["message"] = lastMessage;
    map["time"] = lastMessageTime;
    map["read_by_users"] = readByUsers;
    return map;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is WOHMessageModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          lastMessage == other.lastMessage &&
          lastMessageTime == other.lastMessageTime &&
          readByUsers == other.readByUsers &&
          visibleToUsers == other.visibleToUsers &&
          users == other.users;

  @override
  int get hashCode =>
      super.hashCode ^ id.hashCode ^ name.hashCode ^ lastMessage.hashCode ^ lastMessageTime.hashCode ^ readByUsers.hashCode ^ visibleToUsers.hashCode ^ users.hashCode;
}