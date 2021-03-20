import 'package:minha_biblioteca/models/item.dart';
import 'package:minha_biblioteca/models/user.dart';
import 'package:minha_biblioteca/services/items_service.dart';
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

  @observable
  String? errorMessage;

  @observable
  bool? success;

  _ItemsFormStore({
    this.description,
    this.year,
    this.authors,
    this.publishers,
    this.genres,
    this.location,
  });

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

    errorMessage = 'Preencha todos os campos corretamente';
    return false;
  }

  Future save() async {
    loading = true;

    try {
      if (!_isFormValid()) {
        return;
      }

      final user = User(
        email: '',
        name: '',
        uuid: 'cf86ad8f-83b6-4573-b8b4-4dda3a7277d7',
      );
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
      success = true;

      _clearForm();
    } catch (e) {
      print(e);
      errorMessage = 'Desculpe! Não foi possível criar o item.';
    }

    loading = false;
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
