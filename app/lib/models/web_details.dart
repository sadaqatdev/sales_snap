import 'dart:convert';

class SavedProduct {
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
  SavedProduct({
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
    };
  }

  factory SavedProduct.fromMap(Map<String, dynamic> map, id) {
    if (map == null) return null;

    return SavedProduct(
      webUrl: map['webUrl'],
      title: map['title'],
      imgUrl: map['imgUrl'],
      desc: map['desc'],
      priceHtmlTag: map['priceHtmlTag'],
      priceNumber: map['priceNumber'],
      price: map['price'],
      id: id,
      msgToken: map['msgToken'],
    );
  }

  @override
  String toString() {
    return 'SavedProduct(webUrl: $webUrl, title: $title, imgUrl: $imgUrl, desc: $desc, priceHtmlTag: $priceHtmlTag, priceNumber: $priceNumber, price: $price, id: $id, msgToken: $msgToken, uid: $uid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SavedProduct &&
        other.webUrl == webUrl &&
        other.title == title &&
        other.imgUrl == imgUrl &&
        other.desc == desc &&
        other.priceHtmlTag == priceHtmlTag &&
        other.priceNumber == priceNumber &&
        other.price == price &&
        other.id == id &&
        other.msgToken == msgToken &&
        other.uid == uid;
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
        uid.hashCode;
  }
}
