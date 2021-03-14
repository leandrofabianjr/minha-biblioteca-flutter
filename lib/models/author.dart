import 'package:equatable/equatable.dart';
import 'package:minha_biblioteca/models/user.dart';

class Author extends Equatable {
  final String? uuid;
  final String name;
  final User? createdBy;
  final String? createdAt;
  final String? updatedAt;

  Author({
    this.uuid,
    required this.name,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      uuid: json['uuid'],
      name: json['name'],
    );
  }

  @override
  List<Object?> get props => [uuid];
}
