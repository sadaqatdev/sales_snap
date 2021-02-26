import 'dart:convert';

class WebDetails {
  // static final savedProduct = List<WebDetails>();
  String webUrl;
  String title;
  String imgUrl;
  String desc;
  String priceHtmlTag;
  String priceNumber;

  WebDetails({
    this.webUrl,
    this.title,
    this.imgUrl,
    this.desc,
    this.priceHtmlTag,
    this.priceNumber,
  });

  WebDetails copyWith({
    String webUrl,
    String title,
    String imgUrl,
    String desc,
    String priceHtmlTag,
    String priceNumber,
  }) {
    return WebDetails(
      webUrl: webUrl ?? this.webUrl,
      title: title ?? this.title,
      imgUrl: imgUrl ?? this.imgUrl,
      desc: desc ?? this.desc,
      priceHtmlTag: priceHtmlTag ?? this.priceHtmlTag,
      priceNumber: priceNumber ?? this.priceNumber,
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
    );
  }

  String toJson() => json.encode(toMap());

  factory WebDetails.fromJson(String source) =>
      WebDetails.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WebDetails(webUrl: $webUrl, title: $title, imgUrl: $imgUrl, desc: $desc, priceHtmlTag: $priceHtmlTag, priceNumber: $priceNumber)';
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
        o.priceNumber == priceNumber;
  }

  @override
  int get hashCode {
    return webUrl.hashCode ^
        title.hashCode ^
        imgUrl.hashCode ^
        desc.hashCode ^
        priceHtmlTag.hashCode ^
        priceNumber.hashCode;
  }
}
