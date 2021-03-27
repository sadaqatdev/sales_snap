// To parse this JSON data, do
//
//     final oneSignaleNotification = oneSignaleNotificationFromJson(jsonString);

import 'dart:convert';

OneSignaleNotification oneSignaleNotificationFromJson(String str) =>
    OneSignaleNotification.fromJson(json.decode(str));

String oneSignaleNotificationToJson(OneSignaleNotification data) =>
    json.encode(data.toJson());

class OneSignaleNotification {
  OneSignaleNotification({
    this.payload,
    this.displayType,
    this.shown,
    this.appInFocus,
    this.silent,
  });

  Payload payload;
  int displayType;
  bool shown;
  bool appInFocus;
  dynamic silent;

  factory OneSignaleNotification.fromJson(Map<String, dynamic> json) =>
      OneSignaleNotification(
        payload: Payload.fromJson(json["payload"]),
        displayType: json["displayType"],
        shown: json["shown"],
        appInFocus: json["appInFocus"],
        silent: json["silent"],
      );

  Map<String, dynamic> toJson() => {
        "payload": payload.toJson(),
        "displayType": displayType,
        "shown": shown,
        "appInFocus": appInFocus,
        "silent": silent,
      };
}

class Payload {
  Payload({
    this.googleDeliveredPriority,
    this.googleSentTime,
    this.googleTtl,
    this.googleOriginalPriority,
    this.custom,
    this.from,
    this.alert,
    this.title,
    this.googleMessageId,
    this.googleCSenderId,
    this.androidNotificationId,
  });

  String googleDeliveredPriority;
  int googleSentTime;
  int googleTtl;
  String googleOriginalPriority;
  Custom custom;
  String from;
  String alert;
  String title;
  String googleMessageId;
  String googleCSenderId;
  int androidNotificationId;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        googleDeliveredPriority: json["google.delivered_priority"],
        googleSentTime: json["google.sent_time"],
        googleTtl: json["google.ttl"],
        googleOriginalPriority: json["google.original_priority"],
        custom: Custom.fromJson(json["custom"]),
        from: json["from"],
        alert: json["alert"],
        title: json["title"],
        googleMessageId: json["google.message_id"],
        googleCSenderId: json["google.c.sender.id"],
        androidNotificationId: json["androidNotificationId"],
      );

  Map<String, dynamic> toJson() => {
        "google.delivered_priority": googleDeliveredPriority,
        "google.sent_time": googleSentTime,
        "google.ttl": googleTtl,
        "google.original_priority": googleOriginalPriority,
        "custom": custom.toJson(),
        "from": from,
        "alert": alert,
        "title": title,
        "google.message_id": googleMessageId,
        "google.c.sender.id": googleCSenderId,
        "androidNotificationId": androidNotificationId,
      };
}

class Custom {
  Custom({
    this.a,
    this.i,
  });

  A a;
  String i;

  factory Custom.fromJson(Map<String, dynamic> json) => Custom(
        a: A.fromJson(json["a"]),
        i: json["i"],
      );

  Map<String, dynamic> toJson() => {
        "a": a.toJson(),
        "i": i,
      };
}

class A {
  A({
    this.copon,
    this.webUrl,
  });

  String copon;
  String webUrl;

  factory A.fromJson(Map<String, dynamic> json) => A(
        copon: json["copon"],
        webUrl: json["webUrl"],
      );

  Map<String, dynamic> toJson() => {
        "copon": copon,
        "webUrl": webUrl,
      };
}
