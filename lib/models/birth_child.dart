import 'dart:convert';

class ChildrenBorn {
  final String? id;
  final String fullName;
  final String village;
  final String fatherFullName;
  final String motherFullName;
  final DateTime? createdOn;
  ChildrenBorn(
      {this.id,
      required this.fullName,
      required this.fatherFullName,
      required this.motherFullName,
      required this.village,
      this.createdOn});

  factory ChildrenBorn.fromMap(Map<String, dynamic> map) {

    return ChildrenBorn(
        id: map['id'] ?? '',
        fullName: map['full_name'],
        fatherFullName: map['family_detail']['father_full_name'] ?? '',
        motherFullName: map['family_detail']['mother_full_name'] ?? '',
        village: map['village_detail']['name'] ?? '',
        createdOn: DateTime.parse(map['created_on']));
  }
  factory ChildrenBorn.fromJson(String source) =>
      ChildrenBorn.fromMap(json.decode(source));
}
