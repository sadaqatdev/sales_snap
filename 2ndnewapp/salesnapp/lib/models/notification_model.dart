import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String title;
  String desc;
  String cuponCode;
  String price;
  String webUrl;
  String avatarUrl;
  String productTitle;
  Timestamp timestamp;
  String docId;
  String validDate;
  String priceHtmlTag;
  String newPrice;
  NotificationModel({
    this.title,
    this.desc,
    this.cuponCode,
    this.price,
    this.webUrl,
    this.avatarUrl,
    this.productTitle,
    this.timestamp,
    this.docId,
    this.validDate,
    this.priceHtmlTag,
    this.newPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'desc': desc,
      'cuponCode': cuponCode,
      'price': price,
      'webUrl': webUrl,
      'avatarUrl': avatarUrl,
      'productTitle': productTitle,
      'timestamp': timestamp,
      'docId': docId,
      'validDate': validDate,
      'priceHtmlTag': priceHtmlTag,
      'newPrice': newPrice,
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
      productTitle: map['productTitle'],
      timestamp: map['timestamp'],
      docId: id,
      validDate: map['validDate'],
      priceHtmlTag: map['priceHtmlTag'],
      newPrice: map['newPrice'],
    );
  }

  String toJson() => json.encode(toMap());

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
        other.productTitle == productTitle &&
        other.timestamp == timestamp &&
        other.docId == docId &&
        other.validDate == validDate &&
        other.priceHtmlTag == priceHtmlTag &&
        other.newPrice == newPrice;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        desc.hashCode ^
        cuponCode.hashCode ^
        price.hashCode ^
        webUrl.hashCode ^
        avatarUrl.hashCode ^
        productTitle.hashCode ^
        timestamp.hashCode ^
        docId.hashCode ^
        validDate.hashCode ^
        priceHtmlTag.hashCode ^
        newPrice.hashCode;
  }
}
