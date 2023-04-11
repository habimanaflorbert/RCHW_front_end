import 'dart:convert';


class HouseHold {
  final String id;
  final String fatherFullName;
  final String fatherIdNo;
  final String motherFullName;
  final String motherIdNo;
  final int numberChild;
  final String phoneNumber;
  final String worker;
  final String workerDetail;
  final String village;
  final String villageDetail;
  final DateTime createdOn;
  

  HouseHold({required this.id, required this.fatherFullName, required this.fatherIdNo,required this.motherFullName,
       required this.motherIdNo,required this.worker,required this.createdOn,required this.numberChild,required this.village,required this.phoneNumber,required,required this.villageDetail,required this.workerDetail});

  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'father_full_name':fatherFullName,
      'father_id_no':fatherIdNo,
      'mother_full_name':motherFullName,
      'mother_id_no':motherIdNo,
      'number_child':numberChild,
      'phone_number':phoneNumber,
      'worker':worker,
      'worker_detail':workerDetail,
      'village_detail':villageDetail,
      'village':village,
      'created_on':createdOn
    };
  }

  factory HouseHold.fromMap(Map<String, dynamic> map) {
    return HouseHold(
      id:map['id'] ?? '',
      fatherFullName:map['father_full_name'] ?? '',
      fatherIdNo:map['father_id_no'] ?? '',
      motherFullName:map['mother_full_name'] ?? '',
      motherIdNo:map['mother_id_no'] ?? '',
      phoneNumber: map['number_child'] ?? '',
      workerDetail: map['worker_detail'] ?? '',
      villageDetail: map['village_detail']?? '',
      village: map['village'] ?? '',
      numberChild: map['number_child'] ?? '',
      worker:map['worker'] ?? '',
      createdOn: map['created_on'] ?? '',
    );
  }
 String toJson() => json.encode(toMap());

  factory HouseHold.fromJson(String source) => HouseHold.fromMap(json.decode(source));
}
