import 'dart:convert';

class User {
  final String? id;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String? password;
  final String? type;
  final String? username;
  final String idNumber;
  final String? village;
  final int? malnutritionVillage;
  final int? familyVillage;
  final int? patient;
  final int? contraception;

  User(
      {this.id,
      this.malnutritionVillage,
      this.familyVillage,
      this.patient,
      this.contraception,
      required this.fullName,
      required this.email,
      required this.phoneNumber,
      this.password,
      this.type,
      required this.idNumber,
      this.username,
      this.village});

  Map<String, dynamic> toMap() {
    return {
      'full_name': fullName,
      'username': username,
      'email': email,
      'phone_number': phoneNumber,
      'identification_number': idNumber,
      'password': password,
      'user_village': village,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map['id'] ?? '',
        email: map['email'] ?? '',
        fullName: map['full_name'] ?? '',
        phoneNumber: map['phone_number'] ?? '',
        type: map['user_type'] ?? '',
        idNumber: map['identification_number'] ?? '',
        username: map['username'] ?? '',
        village: map['user_village_name'] ?? '',
        malnutritionVillage: map['malnutrition_village'] ?? 0,
        familyVillage: map['family_village'] ?? 0,
        patient: map['patient_month'] ?? 0,
        contraception: map['contraception_month'] ?? 0);
  }
  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
