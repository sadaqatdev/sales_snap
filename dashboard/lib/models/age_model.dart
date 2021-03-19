import 'dart:convert';

class AgeModel {
  String age;
  String number;
  AgeModel({
    this.age,
    this.number,
  });

  Map<String, dynamic> toMap() {
    return {
      'age': age,
      'number': number,
    };
  }

  factory AgeModel.fromMap(Map<String, dynamic> map) {
    return AgeModel(
      age: map['age'],
      number: map['number'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AgeModel.fromJson(String source) =>
      AgeModel.fromMap(json.decode(source));

  @override
  String toString() => 'AgeModel(age: $age, number: $number)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AgeModel && other.age == age && other.number == number;
  }

  @override
  int get hashCode => age.hashCode ^ number.hashCode;
}
