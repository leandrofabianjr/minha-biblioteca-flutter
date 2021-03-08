import 'package:minha_biblioteca/models/user.dart';

class Publisher {
  String? uuid;
  String name;
  User createdBy;
  String? createdAt;
  String? updatedAt;

  Publisher({
    this.uuid,
    required this.name,
    required this.createdBy,
    this.createdAt,
    this.updatedAt,
  });
}
