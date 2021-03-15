import 'dart:convert';

class NotificationModel {
  String title;
  String desc;
  String cuponCode;
  String price;
  String webUrl;
  NotificationModel({
    this.title,
    this.desc,
    this.cuponCode,
    this.price,
    this.webUrl,
  });

  NotificationModel copyWith({
    String title,
    String desc,
    String cuponCode,
    String price,
    String webUrl,
  }) {
    return NotificationModel(
      title: title ?? this.title,
      desc: desc ?? this.desc,
      cuponCode: cuponCode ?? this.cuponCode,
      price: price ?? this.price,
      webUrl: webUrl ?? this.webUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'desc': desc,
      'cuponCode': cuponCode,
      'price': price,
      'webUrl': webUrl,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return NotificationModel(
      title: map['title'],
      desc: map['desc'],
      cuponCode: map['cuponCode'],
      price: map['price'],
      webUrl: map['webUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Notification(title: $title, desc: $desc, cuponCode: $cuponCode, price: $price, webUrl: $webUrl)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is NotificationModel &&
        o.title == title &&
        o.desc == desc &&
        o.cuponCode == cuponCode &&
        o.price == price &&
        o.webUrl == webUrl;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        desc.hashCode ^
        cuponCode.hashCode ^
        price.hashCode ^
        webUrl.hashCode;
  }
}
