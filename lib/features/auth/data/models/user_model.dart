import 'dart:convert';
import 'dart:developer';

import 'package:flutter_block_firebase_carapp/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    String? uid,
    String? name,
    String? email,
    String? imageUrl,
    String? role,
    Map<String, dynamic>? lastMessage,
    int? unreadCounter,
  }) : super(
          uid: uid,
          name: name,
          email: email,
          role:role,
          imageUrl: imageUrl,
          lastMessage: lastMessage,
          unreadCounter: unreadCounter,
        );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'role':role,
      'imageUrl': imageUrl,
      'lastMessage': lastMessage,
      'unreadCounter': unreadCounter,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    log(map.toString());
    return UserModel(
      uid: map['uid'] != null ? map['uid'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      role: map['role'] != null ? map['role'] as String : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      lastMessage: map['lastMessage'] != null
          ? Map<String, dynamic>.from(map['lastMessage'] as Map<String, dynamic>)
          : null,
      unreadCounter: map['unreadCounter'] != null ? map['unreadCounter'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? imageUrl,
    Map<String, dynamic>? lastMessage,
    int? unreadCounter,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      imageUrl: imageUrl ?? this.imageUrl,
      lastMessage: lastMessage ?? this.lastMessage,
      unreadCounter: unreadCounter ?? this.unreadCounter,
    );
  }

  @override
  String toString() {
    return 'UserModel(uid: $uid, name: $name, role:$role,email: $email, imageUrl: $imageUrl, lastMessage: $lastMessage, unreadCounter: $unreadCounter)';
  }
}