import 'dart:convert';

class Contraception {
  final String? id;
  final String family;
  final String? familyDetail;
  final String? motherNames;
  final String? description;
  final String? worker;
  final DateTime? createdOn;

  Contraception(
      {this.id,
      required this.family,
      this.familyDetail,
      this.description,
      this.worker,
      this.createdOn,this.motherNames});

  Map<String, dynamic> toMap() {
    return {
      'family': family,
      'description': description,
    };
  }

  factory Contraception.fromMap(Map<String, dynamic> map) {
    return Contraception(
      id: map['id'] ?? '',
      family: map['family'] ?? '',
      familyDetail: map['family_detail']['father_full_name'] ?? '',
      motherNames: map['family_detail']['mother_full_name']?? '',
      description: map['description'] ?? '',
      worker: map['worker'] ?? '',
      createdOn: DateTime.parse(map['created_on']) ,
    );
  }
  String toJson() => json.encode(toMap());

  factory Contraception.fromJson(String source) =>
      Contraception.fromMap(json.decode(source));
}
