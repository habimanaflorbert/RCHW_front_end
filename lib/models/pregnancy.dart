import 'dart:convert';

class Pregnancy {
  final String? id;
  final String fullName;
  final String village;
  final String phone;

  final DateTime? createdOn;
  Pregnancy(
      {this.id,
      required this.fullName,
      required this.phone,
      required this.village,
      this.createdOn});
  
  factory Pregnancy.fromMap(Map<String, dynamic> map) {
    return Pregnancy(
        id: map['id'] ?? '',
        fullName: map['full_name'],
        phone: map['phone'] ?? '',
        village: map['village_detail']['name'] ?? '',
        createdOn:DateTime.parse(map['created_on'])
     );
  }
  factory Pregnancy.fromJson(String source) => Pregnancy.fromMap(json.decode(source));
}
