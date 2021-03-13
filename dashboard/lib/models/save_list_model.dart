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
  String token;

  SaveListModel({
    this.webUrl,
    this.title,
    this.imgUrl,
    this.desc,
    this.priceHtmlTag,
    this.priceNumber,
    this.price,
    this.id,
    this.token,
  });

  SaveListModel copyWith({
    String webUrl,
    String title,
    String imgUrl,
    String desc,
    String priceHtmlTag,
    String priceNumber,
    String price,
    int id,
    String token,
  }) {
    return SaveListModel(
      webUrl: webUrl ?? this.webUrl,
      title: title ?? this.title,
      imgUrl: imgUrl ?? this.imgUrl,
      desc: desc ?? this.desc,
      priceHtmlTag: priceHtmlTag ?? this.priceHtmlTag,
      priceNumber: priceNumber ?? this.priceNumber,
      price: price ?? this.price,
      id: id ?? this.id,
      token: token ?? this.token,
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
      'token': token,
    };
  }

  factory SaveListModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return SaveListModel(
      webUrl: map['webUrl'],
      title: map['title'],
      imgUrl: map['imgUrl'],
      desc: map['desc'],
      priceHtmlTag: map['priceHtmlTag'],
      priceNumber: map['priceNumber'],
      price: map['price'],
      id: map['id'],
      token: map['token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SaveListModel.fromJson(String source) =>
      SaveListModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SaveListModel(webUrl: $webUrl, title: $title, imgUrl: $imgUrl, desc: $desc, priceHtmlTag: $priceHtmlTag, priceNumber: $priceNumber, price: $price, id: $id, token: $token)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SaveListModel &&
        o.webUrl == webUrl &&
        o.title == title &&
        o.imgUrl == imgUrl &&
        o.desc == desc &&
        o.priceHtmlTag == priceHtmlTag &&
        o.priceNumber == priceNumber &&
        o.price == price &&
        o.id == id &&
        o.token == token;
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
        token.hashCode;
  }
}
