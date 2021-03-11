import 'package:minha_biblioteca/models/author.dart';
import 'package:minha_biblioteca/models/genre.dart';
import 'package:minha_biblioteca/models/location.dart';
import 'package:minha_biblioteca/models/publisher.dart';
import 'package:minha_biblioteca/models/user.dart';

class Item {
  String? uuid;
  String description;
  int year;
  List<Author> authors;
  List<Genre> genre;
  List<Publisher> publisher;
  Location location;
  User createdBy;
  String? createdAt;
  String? updatedAt;

  Item({
    this.uuid,
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

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      this.description: ,
      this.year: ,
      this.authors: ,
      this.genre: ,
      this.publisher: ,
      this.location: ,
      this.createdBy: ,

    );
  }
}
