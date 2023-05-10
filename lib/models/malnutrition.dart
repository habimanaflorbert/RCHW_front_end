import 'dart:convert';

class Malnutrition {
  final String? id;
  final String family;
  final String? familyDetail;
  final String childFullName;
  final String? motherName;
  final String? familyVillage;
  final bool? hasMalnutrition;
  final String? worker;
  final DateTime? createdOn;

  Malnutrition(
      {this.id,
      required this.family,
      this.familyDetail,
      required this.childFullName,
      this.hasMalnutrition,
      this.worker,
      this.createdOn,
      this.motherName,
      this.familyVillage});

  Map<String, dynamic> toMap() {
    return {
      'family': family,
      'child_full_name': childFullName,
    };
  }

  factory Malnutrition.fromMap(Map<String, dynamic> map) {
    return Malnutrition(
      id: map['id'] ?? '',
      family: map['family'] ?? '',
      familyDetail: map['family_detail']['father_full_name'] ?? '',
      motherName: map['family_detail']['mother_full_name'] ?? '',
      familyVillage: map['family_detail']['village_detail']['name'] ?? '',
      childFullName: map['child_full_name'] ?? '',
      hasMalnutrition: map['has_malnutrition'] ??  false,
      worker: map['worker'] ?? '',
      createdOn: DateTime.parse(map['created_on']),
    );
  }
  String toJson() => json.encode(toMap());

  factory Malnutrition.fromJson(String source) =>
      Malnutrition.fromMap(json.decode(source));
}
