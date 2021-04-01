import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class BuyButtonClick {
  String uid;
  Timestamp timestamp;
  String location;

  BuyButtonClick({
    this.uid,
    this.timestamp,
    this.location,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'timestamp': timestamp,
      'location': location,
    };
  }

  factory BuyButtonClick.fromMap(Map<String, dynamic> map) {
    return BuyButtonClick(
      uid: map['uid'],
      timestamp: map['timestamp'],
      location: map['location'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BuyButtonClick.fromJson(String source) =>
      BuyButtonClick.fromMap(json.decode(source));

  @override
  String toString() =>
      'BuyButtonClick(uid: $uid, timestamp: $timestamp, location: $location)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BuyButtonClick &&
        other.uid == uid &&
        other.timestamp == timestamp &&
        other.location == location;
  }

  @override
  int get hashCode => uid.hashCode ^ timestamp.hashCode ^ location.hashCode;
}
