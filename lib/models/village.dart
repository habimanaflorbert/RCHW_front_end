import 'dart:convert';

class Village {
  final String? id;
  final String name;
  final String? sector;
  final String? province;
  final String? district;

  Village(
      {this.id, required this.name, this.sector, this.district, this.province});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'sector': sector,
    };
  }

  factory Village.fromMap(Map<String, dynamic> map) {

    return Village(
        id: map['id'] ?? '',
        name: map['name'] ?? '',
        sector: map['sector_detail']['name'] ?? '',
        province: map['sector_detail']['district_detail']['name'] ?? '',
        district: map['sector_detail']['district_detail']['province_detail']['name'] ?? ''
        );
  }
  String toJson() => json.encode(toMap());

  factory Village.fromJson(String source) =>
      Village.fromMap(json.decode(source));
}
