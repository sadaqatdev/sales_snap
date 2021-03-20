import 'dart:convert';

class BuyModel {
  String webUrl;
  String title;
  String imgUrl;
  String desc;
  String priceHtmlTag;
  String priceNumber;
  String price;
  String docId;
  String msgToken;
  String uid;
  String newPrice;
  BuyModel({
    this.webUrl,
    this.title,
    this.imgUrl,
    this.desc,
    this.priceHtmlTag,
    this.priceNumber,
    this.price,
    this.docId,
    this.msgToken,
    this.uid,
    this.newPrice,
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
      'docId': docId,
      'msgToken': msgToken,
      'uid': uid,
      'newPrice': newPrice,
    };
  }

  factory BuyModel.fromMap(Map<String, dynamic> map, id) {
    return BuyModel(
      webUrl: map['webUrl'],
      title: map['title'],
      imgUrl: map['imgUrl'],
      desc: map['desc'],
      priceHtmlTag: map['priceHtmlTag'],
      priceNumber: map['priceNumber'],
      price: map['price'],
      docId: id,
      msgToken: map['msgToken'],
      uid: map['uid'],
      newPrice: map['newPrice'],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BuyModel &&
        other.webUrl == webUrl &&
        other.title == title &&
        other.imgUrl == imgUrl &&
        other.desc == desc &&
        other.priceHtmlTag == priceHtmlTag &&
        other.priceNumber == priceNumber &&
        other.price == price &&
        other.docId == docId &&
        other.msgToken == msgToken &&
        other.uid == uid &&
        other.newPrice == newPrice;
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
        docId.hashCode ^
        msgToken.hashCode ^
        uid.hashCode ^
        newPrice.hashCode;
  }
}
