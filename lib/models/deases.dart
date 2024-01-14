import 'dart:convert';

class Dease {
  final String name;

  Dease(
      {required this.name});

  Map<String, dynamic> toMap() {
    return {
      'name': name
    };
  }

  factory Dease.fromMap(Map<String, dynamic> map) {

    return Dease(
        name: map['name'] ?? ''
        );
  }
  String toJson() => json.encode(toMap());

  factory Dease.fromJson(String source) =>
      Dease.fromMap(json.decode(source));
}
