import 'package:minha_biblioteca/models/item.dart';
import 'package:minha_biblioteca/services/auth.dart';
import 'package:minha_biblioteca/services/authors_service.dart';
import 'package:minha_biblioteca/services/genres_service.dart';
import 'package:minha_biblioteca/services/items_service.dart';
import 'package:minha_biblioteca/services/locations_service.dart';
import 'package:minha_biblioteca/services/publishers_service.dart';
import 'package:mobx/mobx.dart';

import 'package:minha_biblioteca/models/author.dart';
import 'package:minha_biblioteca/models/genre.dart';
import 'package:minha_biblioteca/models/location.dart';
import 'package:minha_biblioteca/models/publisher.dart';
import 'package:uuid/uuid.dart';

part 'items_form_store.g.dart';

class ItemsFormStore = _ItemsFormStore with _$ItemsFormStore;

abstract class _ItemsFormStore with Store {
  @observable
  bool loading = false;

  @observable
  String? description;

  @observable
  int? year;

  @observable
  ObservableList<Author>? authors;

  @observable
  ObservableList<Publisher>? publishers;

  @observable
  ObservableList<Genre>? genres;

  @observable
  Location? location;

  get initialYear => year ?? 2000;

  _ItemsFormStore({
    this.description,
    this.year,
    this.authors,
    this.publishers,
    this.genres,
    this.location,
  });

  Future<List<Author>> filterAuthors(String? term) {
    return AuthorsService().search(
      searchByName: term,
    );
  }

  onChangeAuthors(List<Author> authors) {
    authors = ObservableList.of(authors);
  }

  Future<List<Publisher>> filterPublishers(String? term) {
    return PublishersService().search(
      searchByName: term,
    );
  }

  onChangePublishers(List<Publisher> publishers) {
    publishers = ObservableList.of(publishers);
  }

  Future<List<Genre>> filterGenres(String? term) {
    return GenresService().search(
      searchByDescription: term,
    );
  }

  onChangeGenres(List<Genre> genres) {
    genres = ObservableList.of(genres);
  }

  Future<List<Location>> filterLocations(String? term) {
    return LocationsService().search(
      searchByDescription: term,
    );
  }

  onChangeLocations(List<Location> locations) {
    location = locations.length > 0 ? locations.first : null;
  }

  bool _isFormValid() {
    if (description?.isNotEmpty != null && description!.isNotEmpty) {
      if (year != null) {
        if (authors?.length != null && authors!.length > 0) {
          if (publishers?.length != null && publishers!.length > 0) {
            if (genres?.length != null && genres!.length > 0) {
              if (location != null) {
                return true;
              }
            }
          }
        }
      }
    }

    return false;
  }

  Future<String?> save() async {
    loading = true;

    try {
      if (!_isFormValid()) {
        return 'Preencha todos os campos corretamente';
      }

      final user = await Auth().currentUser;
      await ItemsService().save(
        item: Item(
          uuid: Uuid().v4(),
          user: user,
          description: description!,
          year: year!,
          authors: authors!,
          genres: genres!,
          publishers: publishers!,
          location: location!,
        ),
      );
      _clearForm();
    } catch (e) {
      print(e);
      return 'Desculpe! Não foi possível criar o item.';
    }

    loading = false;
    return null;
  }

  void _clearForm() {
    description = null;
    year = null;
    authors?.clear();
    genres?.clear();
    publishers?.clear();
    location = null;
  }
}
