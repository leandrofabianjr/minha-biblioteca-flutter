import 'package:equatable/equatable.dart';
import 'package:minha_biblioteca/models/user.dart';

class Publisher extends Equatable {
  final String? uuid;
  final String name;
  final User? createdBy;
  final String? createdAt;
  final String? updatedAt;

  Publisher({
    this.uuid,
    required this.name,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory Publisher.fromJson(Map<String, dynamic> json) {
    return Publisher(
      uuid: json['uuid'],
      name: json['name'],
    );
  }

  @override
  List<Object?> get props => [uuid];
}
