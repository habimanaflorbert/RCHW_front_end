import 'dart:convert';

class Village {
  final String? id;
  final String name;
  final String sector;


  Village({this.id, required this.name, required this.sector});
     

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'sector': sector,
 
    };
  }

  factory Village.fromMap(Map<String, dynamic> map) {
    return Village(
      id:map['id'] ?? '',
      name:map['name'] ?? '',
      sector:map['sector'] ?? '',
  
    );
  }
 String toJson() => json.encode(toMap());

  factory Village.fromJson(String source) => Village.fromMap(json.decode(source));
}
