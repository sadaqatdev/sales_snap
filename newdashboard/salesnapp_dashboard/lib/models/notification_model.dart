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
  String validDate;
  String productTitle;
  String priceHtmlTag;
  NotificationModel({
    this.title,
    this.desc,
    this.cuponCode,
    this.price,
    this.webUrl,
    this.avatarUrl,
    this.timestamp,
    this.docId,
    this.validDate,
    this.productTitle,
    this.priceHtmlTag,
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
      'validDate': validDate,
      'productTitle': productTitle,
      'priceHtmlTag': priceHtmlTag,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      title: map['title'],
      desc: map['desc'],
      cuponCode: map['cuponCode'],
      price: map['price'],
      webUrl: map['webUrl'],
      avatarUrl: map['avatarUrl'],
      timestamp: map['timestamp'],
      docId: map['docId'],
      validDate: map['validDate'],
      productTitle: map['productTitle'],
      priceHtmlTag: map['priceHtmlTag'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NotificationModel(title: $title, desc: $desc, cuponCode: $cuponCode, price: $price, webUrl: $webUrl, avatarUrl: $avatarUrl, timestamp: $timestamp, docId: $docId, validDate: $validDate, productTitle: $productTitle, priceHtmlTag: $priceHtmlTag)';
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
        other.docId == docId &&
        other.validDate == validDate &&
        other.productTitle == productTitle &&
        other.priceHtmlTag == priceHtmlTag;
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
        docId.hashCode ^
        validDate.hashCode ^
        productTitle.hashCode ^
        priceHtmlTag.hashCode;
  }
}
