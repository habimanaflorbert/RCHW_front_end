import 'dart:convert';

class Document {
  final String id;
  final String documentName;
  final String userRelated;
  final String documentFile;
  final DateTime createdOn;
   Document({required this.id, required this.documentName, required this.userRelated,required this.documentFile,required this.createdOn});

  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'document_name':documentName,
      'user_related':userRelated,
      'document_file':documentFile,
      'created_on':createdOn
    };
  }
    factory Document.fromMap(Map<String, dynamic> map) {
    return Document(
      id:map['id'] ?? '',
      documentName:map['document_name'] ?? '',
      userRelated:map['user_related'] ?? '',
      documentFile:map['document_file'] ?? '',
      createdOn: DateTime.parse(map['created_on']),
    );
  }
 String toJson() => json.encode(toMap());

  factory Document.fromJson(String source) => Document.fromMap(json.decode(source));
}
