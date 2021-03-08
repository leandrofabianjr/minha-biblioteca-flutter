import 'package:minha_biblioteca/models/user.dart';

class Author {
  String? uuid;
  String name;
  User createdBy;
  String? createdAt;
  String? updatedAt;

  Author({
    this.uuid,
    required this.name,
    required this.createdBy,
    this.createdAt,
    this.updatedAt,
  });
}
