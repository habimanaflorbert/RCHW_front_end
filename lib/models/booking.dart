import 'dart:convert';

class Booking {
  final String? id;
  final String? fullName;
  final String? phoneNumber;
  final String? description;
  final String? villageDetailId;
  final String? villageDetailName;
  final String? workerName;
  final DateTime? dateCreated;
  Booking(
      {this.description,
      this.villageDetailId,
      this.villageDetailName,
      this.dateCreated,
      this.id,
      this.fullName,
      this.workerName,
      this.phoneNumber});

  Map<String, dynamic> toMap() {
    return {
      'id': id
    };
  }


  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      id: map['id'] ?? '',
      fullName: map['full_name'] ?? '',
      phoneNumber: map['phone_number'] ?? '',
      villageDetailId: map['village_detail']['id']?? '',
      villageDetailName: map['village_detail']['name']?? '',
      description: map['description'] ?? '',
      workerName: map['worker'] ?? '',
      dateCreated: DateTime.parse(map['created_on']) ,
    );
  }
  String toJson() => json.encode(toMap());

  factory Booking.fromJson(String source) =>
      Booking.fromMap(json.decode(source));

}
