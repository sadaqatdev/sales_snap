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
  Timestamp createdDate;
  MUser({
    this.name,
    this.email,
    this.imageUrl,
    this.dob,
    this.gender,
    this.intersts,
    this.token,
    this.createdDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
      'dob': dob,
      'gender': gender,
      'intersts': intersts,
      'token': token,
      'createdDate': createdDate,
    };
  }

  factory MUser.fromMap(Map<String, dynamic> map) {
    return MUser(
      name: map['name'],
      email: map['email'],
      imageUrl: map['imageUrl'],
      dob: map['dob'],
      gender: map['gender'],
      intersts: List<String>.from(map['intersts']),
      token: map['token'],
      createdDate: map['createdDate'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MUser.fromJson(String source) => MUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MUser(name: $name, email: $email, imageUrl: $imageUrl, dob: $dob, gender: $gender, intersts: $intersts, token: $token, createdDate: $createdDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MUser &&
        other.name == name &&
        other.email == email &&
        other.imageUrl == imageUrl &&
        other.dob == dob &&
        other.gender == gender &&
        listEquals(other.intersts, intersts) &&
        other.token == token &&
        other.createdDate == createdDate;
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
        createdDate.hashCode;
  }
}
