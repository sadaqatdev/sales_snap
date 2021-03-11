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
  });

  SavedProduct copyWith({
    String webUrl,
    String title,
    String imgUrl,
    String desc,
    String priceHtmlTag,
    String priceNumber,
    String price,
    int id,
    String msgToken,
  }) {
    return SavedProduct(
      webUrl: webUrl ?? this.webUrl,
      title: title ?? this.title,
      imgUrl: imgUrl ?? this.imgUrl,
      desc: desc ?? this.desc,
      priceHtmlTag: priceHtmlTag ?? this.priceHtmlTag,
      priceNumber: priceNumber ?? this.priceNumber,
      price: price ?? this.price,
      id: id ?? this.id,
      msgToken: msgToken ?? this.msgToken,
    );
  }

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
    return 'SavedProduct(webUrl: $webUrl, title: $title, imgUrl: $imgUrl, desc: $desc, priceHtmlTag: $priceHtmlTag, priceNumber: $priceNumber, price: $price, id: $id, msgToken: $msgToken)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SavedProduct &&
        o.webUrl == webUrl &&
        o.title == title &&
        o.imgUrl == imgUrl &&
        o.desc == desc &&
        o.priceHtmlTag == priceHtmlTag &&
        o.priceNumber == priceNumber &&
        o.price == price &&
        o.id == id &&
        o.msgToken == msgToken;
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
        msgToken.hashCode;
  }
}
