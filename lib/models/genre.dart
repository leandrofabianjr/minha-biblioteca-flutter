import 'package:minha_biblioteca/models/user.dart';

class Genre {
  String? uuid;
  String description;
  User? createdBy;
  String? createdAt;
  String? updatedAt;

  Genre({
    this.uuid,
    required this.description,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      description: json['description'],
    );
  }
}
