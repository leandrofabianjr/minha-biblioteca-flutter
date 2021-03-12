import 'package:minha_biblioteca/models/user.dart';

class Publisher {
  String? uuid;
  String name;
  User? createdBy;
  String? createdAt;
  String? updatedAt;

  Publisher({
    this.uuid,
    required this.name,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory Publisher.fromJson(Map<String, dynamic> json) {
    return Publisher(
      name: json['name'],
    );
  }
}
