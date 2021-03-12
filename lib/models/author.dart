import 'package:minha_biblioteca/models/user.dart';

class Author {
  String? uuid;
  String name;
  User? createdBy;
  String? createdAt;
  String? updatedAt;

  Author({
    this.uuid,
    required this.name,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      name: json['name'],
    );
  }
}
