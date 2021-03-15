import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:minha_biblioteca/components/dropdown_with_search/widgets.dart';
import 'package:minha_biblioteca/models/author.dart';
import 'package:mobx/mobx.dart';

part 'store.g.dart';

class DropdownListItem<T> = _DropdownListItem<T> with _$DropdownListItem<T>;

abstract class _DropdownListItem<T> with Store {
  final T itemData;

  @observable
  bool selected = false;

  _DropdownListItem(this.itemData);
}

class DropdownWithSearchStore<T> = _DropdownWithSearchStore<T>
    with _$DropdownWithSearchStore<T>;

abstract class _DropdownWithSearchStore<T> with Store implements Disposable {
  final OnSearch<T> _onSearch;

  @observable
  ObservableList<T> selectedList;

  // ignore: avoid_init_to_null
  OnChangeSelectedList<T>? onChangeSelectedList = null;

  @observable
  ObservableList<DropdownListItem<T>> searchList =
      ObservableList<DropdownListItem<T>>();

  @observable
  bool loading = false;

  @observable
  String error = '';

  String term = '';

  // ignore: avoid_init_to_null
  Timer? _debounce = null;

  _DropdownWithSearchStore({
    required OnSearch<T> onSearch,
    // ignore: avoid_init_to_null
    List<T>? selectedList = null,
    this.onChangeSelectedList,
  })  : _onSearch = onSearch,
        selectedList = ObservableList.of(
          selectedList == null ? <T>[] : selectedList,
        );

  @action
  void startDelayedSearh(String term) {
    this.term = term;
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: 500), () {
      fetch();
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
  }

  @action
  Future fetch() async {
    loading = true;
    try {
      print('iniciou pesquisa');
      final response = await _onSearch(term);
      final dropdownList = response.map((i) => DropdownListItem<T>(i)).toList();
      searchList
        ..clear()
        ..addAll(dropdownList);
      print('terminou pesquisa');
    } catch (ex) {
      print(ex);
      error = 'Não foi possível fazer a busca';
    }
    loading = false;
  }

  @action
  void select(int searchListItemIndex) {
    print('--$searchListItemIndex');
    final item = searchList[searchListItemIndex];

    if (item.selected = !selectedList.remove(item.itemData)) {
      selectedList.add(item.itemData);
    }

    // Foi preciso substituir o DropdownListItem para acionar o Observer
    // Somente alterando o DropdownListItem.selected, o widget era atualizado
    searchList[searchListItemIndex] = DropdownListItem<T>(item.itemData);
    searchList[searchListItemIndex].selected = item.selected;
    onChangeSelectedList!(selectedList);
  }

  @action
  void remove(T selectedItemToRemove) {
    print('--${(selectedItemToRemove as Author).name}');
    final searchListItemIndex =
        searchList.indexWhere((item) => item.itemData == selectedItemToRemove);
    select(searchListItemIndex);
  }
}
