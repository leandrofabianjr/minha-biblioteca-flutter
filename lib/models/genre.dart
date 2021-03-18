import 'package:equatable/equatable.dart';
import 'package:minha_biblioteca/models/user.dart';

class Genre extends Equatable {
  final String? uuid;
  final String description;
  final User? createdBy;
  final String? createdAt;
  final String? updatedAt;

  Genre({
    this.uuid,
    required this.description,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      uuid: json['uuid'],
      description: json['description'],
    );
  }

  @override
  List<Object?> get props => [uuid];
}
