import 'dart:convert';

import 'package:flutter/foundation.dart';

class MUser {
  String name;
  String email;
  String imageUrl;
  String dob;
  String gender;
  List<String> intersts;
  MUser({
    this.name,
    this.email,
    this.imageUrl,
    this.dob,
    this.gender,
    this.intersts,
  });

  MUser copyWith({
    String name,
    String email,
    String imageUrl,
    String dob,
    String gender,
    List<String> intersts,
  }) {
    return MUser(
      name: name ?? this.name,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      intersts: intersts ?? this.intersts,
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
    };
  }

  factory MUser.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return MUser(
      name: map['name'],
      email: map['email'],
      imageUrl: map['imageUrl'],
      dob: map['dob'],
      gender: map['gender'],
      intersts: List<String>.from(map['intersts']),
    );
  }

  String toJson() => json.encode(toMap());

  factory MUser.fromJson(String source) => MUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MUser(name: $name, email: $email, imageUrl: $imageUrl, dob: $dob, gender: $gender, intersts: $intersts)';
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
        listEquals(o.intersts, intersts);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        imageUrl.hashCode ^
        dob.hashCode ^
        gender.hashCode ^
        intersts.hashCode;
  }
}
