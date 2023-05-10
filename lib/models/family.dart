import 'dart:convert';

class Family {
  final String? id;
  final String fatherFullName;
  final String fatherIdNo;
  final String motherFullName;
  final String motherIdNo;
  final int numberChild;
  final String phoneNumber;
  final String? worker;
  final String? workerDetail;
  final String? villageDetail;
  final String village;
  final DateTime? createdOn;

  Family(
      {this.id,
      required this.fatherFullName,
      required this.fatherIdNo,
      required this.motherFullName,
      required this.motherIdNo,
      required this.numberChild,
      required this.phoneNumber,
      this.createdOn,
      this.villageDetail,
      this.worker,
      required this.village,
      this.workerDetail});
  Map<String,dynamic> toMap() {
    return {
      'father_full_name': fatherFullName,
      'father_id_no': fatherIdNo,
      'mother_full_name': motherFullName,
      'mother_id_no': motherIdNo,
      'number_child': numberChild,
      'phone_number': phoneNumber,
      'village': village,

    };
  }

  factory Family.fromMap(Map<String, dynamic> map) {
    return Family(
        id: map['id'] ?? '',
        fatherFullName: map['father_full_name'] ?? '',
        fatherIdNo: map['father_id_no'] ?? '',
        motherFullName: map['mother_full_name'] ?? '',
        motherIdNo: map['mother_id_no'] ?? '',
        numberChild: map['number_child'] ?? 0,
        phoneNumber: map['phone_number'] ?? '',
        village: map['village'] ?? '',
        villageDetail: map['village_detail']['name']?? '',
        worker: map['worker'],
        createdOn:DateTime.parse(map['created_on'])
     );
  }
  String toJson() => json.encode(toMap());
  factory Family.fromJson(String source) => Family.fromMap(json.decode(source));
}
