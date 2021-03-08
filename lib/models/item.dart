import 'package:minha_biblioteca/models/author.dart';
import 'package:minha_biblioteca/models/genre.dart';
import 'package:minha_biblioteca/models/publisher.dart';
import 'package:minha_biblioteca/models/user.dart';

class Item {
  String uuid;
  String description;
  int year;
  List<Author> authors;
  List<Genre> genre;
  List<Publisher> publisher;
  String location;
  User createdBy;
  String? createdAt;
  String? updatedAt;

  Item({
    this.uuid = 'generate uuid',
    required this.description,
    required this.year,
    required this.authors,
    required this.genre,
    required this.publisher,
    required this.location,
    required this.createdBy,
    this.createdAt,
    this.updatedAt,
  });
}
