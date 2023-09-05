import 'dart:convert';

class Patient {
  final String? id;
  final String fullName;
  final String insuranceName;
  final String insuranceNumber;
  final String sickness;
  final String? village;
  final String? villageDetail;
  final String dateOfBirth;
  final String phoneNumber;
  final DateTime? createdOn;
  final String symptoms;
  final String causes;

  Patient(
      {this.id,
      required this.causes,
      required this.symptoms,
      required this.fullName,
      required this.insuranceName,
      required this.insuranceNumber,
      required this.sickness,
      required this.phoneNumber,
      this.villageDetail,
      this.createdOn,
      required this.dateOfBirth,
      this.village});

  Map<String, dynamic> toMap() {
    return {
      'full_name': fullName,
      'insurance_name': insuranceName,
      'insurance_number': insuranceNumber,
      'sickness': sickness,
      'phone': phoneNumber,
      'symptoms':symptoms,
      'causes':causes,
      'date_of_birth': dateOfBirth,
    };
  }

  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      id: map['id'] ?? '',
      fullName: map['full_name'] ?? '',
      insuranceName: map['insurance_name'] ?? '',
      insuranceNumber: map['insurance_number'] ?? '',
      sickness: map['sickness'] ?? '',
      village: map['village'] ?? '',
      phoneNumber: map['phone'] ?? '',
      villageDetail: map['villageDetail'] ?? '',
      dateOfBirth: map['date_of_birth'] ?? '',
      symptoms: map['symptoms']?? '',
      causes: map['causes']?? '',
      createdOn: DateTime.parse(map['created_on']),
    );
  }
  String toJson() => json.encode(toMap());

  factory Patient.fromJson(String source) =>
      Patient.fromMap(json.decode(source));
}
