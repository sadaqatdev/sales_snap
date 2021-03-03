import 'dart:convert';

class WebDetails {
  String webUrl;
  String title;
  String imgUrl;
  String desc;
  String priceHtmlTag;
  String priceNumber;
  String price;
  int id;
  WebDetails(
      {this.webUrl,
      this.title,
      this.imgUrl,
      this.desc,
      this.priceHtmlTag,
      this.priceNumber,
      this.price,
      this.id});

  WebDetails copyWith({
    String webUrl,
    String title,
    String imgUrl,
    String desc,
    String priceHtmlTag,
    String priceNumber,
    String price,
  }) {
    return WebDetails(
      webUrl: webUrl ?? this.webUrl,
      title: title ?? this.title,
      imgUrl: imgUrl ?? this.imgUrl,
      desc: desc ?? this.desc,
      priceHtmlTag: priceHtmlTag ?? this.priceHtmlTag,
      priceNumber: priceNumber ?? this.priceNumber,
      price: price ?? this.price,
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
    };
  }

  factory WebDetails.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return WebDetails(
        webUrl: map['webUrl'],
        title: map['title'],
        imgUrl: map['imgUrl'],
        desc: map['desc'],
        priceHtmlTag: map['priceHtmlTag'],
        priceNumber: map['priceNumber'],
        price: map['price'],
        id: map['id']);
  }

  String toJson() => json.encode(toMap());

  factory WebDetails.fromJson(String source) =>
      WebDetails.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WebDetails(webUrl: $webUrl, title: $title, imgUrl: $imgUrl, desc: $desc, priceHtmlTag: $priceHtmlTag, priceNumber: $priceNumber, price: $price)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is WebDetails &&
        o.webUrl == webUrl &&
        o.title == title &&
        o.imgUrl == imgUrl &&
        o.desc == desc &&
        o.priceHtmlTag == priceHtmlTag &&
        o.priceNumber == priceNumber &&
        o.price == price;
  }

  @override
  int get hashCode {
    return webUrl.hashCode ^
        title.hashCode ^
        imgUrl.hashCode ^
        desc.hashCode ^
        priceHtmlTag.hashCode ^
        priceNumber.hashCode ^
        price.hashCode;
  }
}
