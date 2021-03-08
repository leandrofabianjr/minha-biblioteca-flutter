import 'package:minha_biblioteca/models/user.dart';

class Location {
  String? uuid;
  String description;
  User createdBy;
  String? createdAt;
  String? updatedAt;

  Location({
    this.uuid,
    required this.description,
    required this.createdBy,
    this.createdAt,
    this.updatedAt,
  });
}
