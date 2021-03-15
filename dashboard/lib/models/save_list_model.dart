import 'dart:convert';

class SaveListModel {
  String webUrl;

  String title;
  String imgUrl;
  String desc;
  String priceHtmlTag;
  String priceNumber;
  String price;
  int id;
  String uid;
  String msgToken;
  SaveListModel({
    this.webUrl,
    this.title,
    this.imgUrl,
    this.desc,
    this.priceHtmlTag,
    this.priceNumber,
    this.price,
    this.id,
    this.uid,
    this.msgToken,
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
      'uid': uid,
      'msgToken': msgToken,
    };
  }

  factory SaveListModel.fromMap(Map<String, dynamic> map) {
    return SaveListModel(
      webUrl: map['webUrl'],
      title: map['title'],
      imgUrl: map['imgUrl'],
      desc: map['desc'],
      priceHtmlTag: map['priceHtmlTag'],
      priceNumber: map['priceNumber'],
      price: map['price'],
      id: map['id'],
      uid: map['uid'],
      msgToken: map['msgToken'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SaveListModel.fromJson(String source) =>
      SaveListModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SaveListModel(webUrl: $webUrl, title: $title, imgUrl: $imgUrl, desc: $desc, priceHtmlTag: $priceHtmlTag, priceNumber: $priceNumber, price: $price, id: $id, uid: $uid, msgToken: $msgToken)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SaveListModel &&
        other.webUrl == webUrl &&
        other.title == title &&
        other.imgUrl == imgUrl &&
        other.desc == desc &&
        other.priceHtmlTag == priceHtmlTag &&
        other.priceNumber == priceNumber &&
        other.price == price &&
        other.id == id &&
        other.uid == uid &&
        other.msgToken == msgToken;
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
        uid.hashCode ^
        msgToken.hashCode;
  }
}
