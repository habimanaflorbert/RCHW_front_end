import 'dart:convert';

class Malnutrition {
  final int? id;
  final String family;
  final String? familyDetail;
  final String childFullName;
  final bool? hasMalnutrition;
  final String? worker;
  final DateTime? createdOn;
  

  Malnutrition({this.id, required this.family, this.familyDetail,required this.childFullName,
      this.hasMalnutrition,this.worker, this.createdOn});

  Map<String, dynamic> toMap() {
    return {
      'family': family,
      'child_full_name': childFullName,
    };
  }

  factory Malnutrition.fromMap(Map<String, dynamic> map) {
    return Malnutrition(
      id:map['id'] ?? '',
      family:map['family'] ?? '',
      familyDetail:map['family_detail'] ?? '',
      childFullName:map['child_full_name'] ?? '',
      hasMalnutrition:map['has_malnutrition'] ?? '',
      worker:map['worker'] ?? '',
      createdOn: map['created_on'] ?? '',
    );
  }
 String toJson() => json.encode(toMap());

  factory Malnutrition.fromJson(String source) => Malnutrition.fromMap(json.decode(source));
}
