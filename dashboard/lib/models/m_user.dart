import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class MUser {
  String name;
  String email;
  String imageUrl;
  String dob;
  String gender;
  List<String> intersts;
  String token;
  String uid;
  MUser({
    this.name,
    this.email,
    this.imageUrl,
    this.dob,
    this.gender,
    this.intersts,
    this.token,
    this.uid,
  });

  MUser copyWith({
    String name,
    String email,
    String imageUrl,
    String dob,
    String gender,
    List<String> intersts,
    String token,
    String uid,
  }) {
    return MUser(
      name: name ?? this.name,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      intersts: intersts ?? this.intersts,
      token: token ?? this.token,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
      'dob': dob,
      'gender': gender,
      'intersts': intersts,
      'token': token,
      'uid': uid,
    };
  }

  factory MUser.fromMap(
      Map<String, dynamic> map, QueryDocumentSnapshot elemnent) {
    if (map == null) return null;

    return MUser(
      name: map['name'],
      email: map['email'],
      imageUrl: map['imageUrl'],
      dob: map['dob'],
      gender: map['gender'],
      intersts: List<String>.from(map['intersts']),
      token: map['token'],
      uid: elemnent.id,
    );
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MUser &&
        o.name == name &&
        o.email == email &&
        o.imageUrl == imageUrl &&
        o.dob == dob &&
        o.gender == gender &&
        listEquals(o.intersts, intersts) &&
        o.token == token &&
        o.uid == uid;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        imageUrl.hashCode ^
        dob.hashCode ^
        gender.hashCode ^
        intersts.hashCode ^
        token.hashCode ^
        uid.hashCode;
  }
}
