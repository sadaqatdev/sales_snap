import 'dart:convert';

class Intrest {
  String avatar;
  String lable;
  Intrest({
     this.avatar,
     this.lable,
  });



  Map<String, dynamic> toMap() {
    return {
      'avatar': avatar,
      'lable': lable,
    };
  }

  factory Intrest.fromMap(Map<String, dynamic> map) {
    return Intrest(
      avatar: map['avatar'],
      lable: map['lable'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Intrest.fromJson(String source) => Intrest.fromMap(json.decode(source));

  @override
  String toString() => 'Intrest(avatar: $avatar, lable: $lable)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Intrest &&
      other.avatar == avatar &&
      other.lable == lable;
  }

  @override
  int get hashCode => avatar.hashCode ^ lable.hashCode;
}
