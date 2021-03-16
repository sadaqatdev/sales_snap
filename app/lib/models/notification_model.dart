import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String title;
  String desc;
  String cuponCode;
  String price;
  String webUrl;
  String avatarUrl;
  Timestamp timestamp;
  String docId;
  NotificationModel({
    this.title,
    this.desc,
    this.cuponCode,
    this.price,
    this.webUrl,
    this.avatarUrl,
    this.timestamp,
    this.docId,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'desc': desc,
      'cuponCode': cuponCode,
      'price': price,
      'webUrl': webUrl,
      'avatarUrl': avatarUrl,
      'timestamp': timestamp,
      'docId': docId,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map, id) {
    return NotificationModel(
      title: map['title'],
      desc: map['desc'],
      cuponCode: map['cuponCode'],
      price: map['price'],
      webUrl: map['webUrl'],
      avatarUrl: map['avatarUrl'],
      timestamp: map['timestamp'],
      docId: id,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'NotificationModel(title: $title, desc: $desc, cuponCode: $cuponCode, price: $price, webUrl: $webUrl, avatarUrl: $avatarUrl, timestamp: $timestamp, docId: $docId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotificationModel &&
        other.title == title &&
        other.desc == desc &&
        other.cuponCode == cuponCode &&
        other.price == price &&
        other.webUrl == webUrl &&
        other.avatarUrl == avatarUrl &&
        other.timestamp == timestamp &&
        other.docId == docId;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        desc.hashCode ^
        cuponCode.hashCode ^
        price.hashCode ^
        webUrl.hashCode ^
        avatarUrl.hashCode ^
        timestamp.hashCode ^
        docId.hashCode;
  }
}
