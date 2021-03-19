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
  List<Genre> genres;
  List<Publisher> publishers;
  Location location;
  User? user;
  String? createdAt;
  String? updatedAt;

  Item({
    this.uuid,
    required this.description,
    required this.year,
    required this.authors,
    required this.genres,
    required this.publishers,
    required this.location,
    this.user,
    this.createdAt,
    this.updatedAt,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      description: json['description'],
      year: json['year'],
      authors: (json['authors'] as List)
          .map((json) => Author.fromJson(json['author']))
          .toList(),
      genres: (json['genres'] as List)
          .map((json) => Genre.fromJson(json['genre']))
          .toList(),
      publishers: (json['publishers'] as List)
          .map((json) => Publisher.fromJson(json['publisher']))
          .toList(),
      location: Location.fromJson(json['location']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': this.uuid,
      'description': this.description,
      'year': this.year,
      'user_id': user?.uuid,
      'authors': {
        'data': this.authors.map((a) => {'author_id': a.uuid}).toList(),
      },
      'genres': {
        'data': this.genres.map((g) => {'genre_id': g.uuid}).toList(),
      },
      'publishers': {
        'data': this.publishers.map((p) => {'publisher_id': p.uuid}).toList(),
      },
      'location_id': this.location.uuid,
    };
  }
}
