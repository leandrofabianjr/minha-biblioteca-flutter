import 'package:equatable/equatable.dart';
import 'package:minha_biblioteca/models/user.dart';

class Location extends Equatable {
  final String? uuid;
  final String description;
  final User? createdBy;
  final String? createdAt;
  final String? updatedAt;

  Location({
    this.uuid,
    required this.description,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      uuid: json['uuid'],
      description: json['description'],
    );
  }

  @override
  List<Object?> get props => [uuid];
}
