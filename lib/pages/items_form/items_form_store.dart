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
  Location? _location;

  final _$locationAtom = Atom(name: '_ItemsFormStore.location');

  Location? get location {
    _$locationAtom.reportRead();
    return _location;
  }

  set location(Location? value) {
    _$locationAtom.reportWrite(value, _location, () {
      _location = value;
    });
  }

  @observable
  bool hasErrors = false;

  _ItemsFormStore({
    this.description,
    this.year,
    this.authors,
    this.publishers,
    this.genres,
    Location? location,
  }) : _location = location;

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

  Future save() async {
    loading = true;

    try {
      if (hasErrors = !_isFormValid()) {
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
    } catch (e) {
      print(e);
    }

    loading = false;
  }
}
