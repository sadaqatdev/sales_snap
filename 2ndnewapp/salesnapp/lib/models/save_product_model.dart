import 'package:cloud_firestore/cloud_firestore.dart';

class SavedProductModel {
  String webUrl;
  String title;
  String imgUrl;
  String desc;
  String priceHtmlTag;
  String priceNumber;
  String price;
  String id;
  String msgToken;
  String uid;
  Timestamp timestamp;
  SavedProductModel({
    this.webUrl,
    this.title,
    this.imgUrl,
    this.desc,
    this.priceHtmlTag,
    this.priceNumber,
    this.price,
    this.id,
    this.msgToken,
    this.uid,
    this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'webUrl': webUrl,
      'title': title,
      'imgUrl': imgUrl,
      'desc': desc,
      'priceHtmlTag': priceHtmlTag,
      'priceNumber': priceNumber,
      'price': price,
      'id': id,
      'msgToken': msgToken,
      'uid': uid,
      'timestamp': timestamp,
    };
  }

  factory SavedProductModel.fromMap(Map<String, dynamic> map, id) {
    if (map == null) return null;

    return SavedProductModel(
      webUrl: map['webUrl'],
      title: map['title'],
      imgUrl: map['imgUrl'],
      desc: map['desc'],
      priceHtmlTag: map['priceHtmlTag'],
      priceNumber: map['priceNumber'],
      price: map['price'],
      id: id,
      msgToken: map['msgToken'],
      timestamp: map['timestamp'],
    );
  }

  @override
  String toString() {
    return 'SavedProductModel(webUrl: $webUrl, title: $title, imgUrl: $imgUrl, desc: $desc, priceHtmlTag: $priceHtmlTag, priceNumber: $priceNumber, price: $price, id: $id, msgToken: $msgToken, uid: $uid, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SavedProductModel &&
        other.webUrl == webUrl &&
        other.title == title &&
        other.imgUrl == imgUrl &&
        other.desc == desc &&
        other.priceHtmlTag == priceHtmlTag &&
        other.priceNumber == priceNumber &&
        other.price == price &&
        other.id == id &&
        other.msgToken == msgToken &&
        other.uid == uid &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return webUrl.hashCode ^
        title.hashCode ^
        imgUrl.hashCode ^
        desc.hashCode ^
        priceHtmlTag.hashCode ^
        priceNumber.hashCode ^
        price.hashCode ^
        id.hashCode ^
        msgToken.hashCode ^
        uid.hashCode ^
        timestamp.hashCode;
  }
}
