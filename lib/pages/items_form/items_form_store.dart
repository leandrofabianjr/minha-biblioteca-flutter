import 'package:mobx/mobx.dart';

import 'package:minha_biblioteca/models/author.dart';
import 'package:minha_biblioteca/models/genre.dart';
import 'package:minha_biblioteca/models/location.dart';
import 'package:minha_biblioteca/models/publisher.dart';

// part 'items_form_store.g.dart';

class _$ItemsFormStore {}

class ItemsFormStore = _ItemsFormStore with _$ItemsFormStore;

abstract class _ItemsFormStore with Store {
  @observable
  bool loading = false;

  @observable
  // ignore: avoid_init_to_null
  String? description = null;

  @observable
  // ignore: avoid_init_to_null
  int? year = null;

  @observable
  // ignore: avoid_init_to_null
  ObservableList<Author>? authors = null;

  @observable
  // ignore: avoid_init_to_null
  ObservableList<Publisher>? publishers = null;

  @observable
  // ignore: avoid_init_to_null
  ObservableList<Genre>? genres = null;

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
    if (description!.length > 0 &&
        year != null &&
        authors!.length > 0 &&
        publishers!.length > 0 &&
        genres!.length > 0 &&
        location != null) {
      return true;
    }
    return false;
  }

  void save() {
    loading = true;

    if (hasErrors = _isFormValid()) {
      return;
    }

    loading = false;
  }
}
