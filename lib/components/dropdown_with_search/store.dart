import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:minha_biblioteca/components/dropdown_with_search/widgets.dart';
import 'package:mobx/mobx.dart';

part 'store.g.dart';

class DropdownListItem<T> = _DropdownListItem<T> with _$DropdownListItem<T>;

abstract class _DropdownListItem<T> with Store {
  final T itemData;

  @observable
  bool selected;

  _DropdownListItem(this.itemData, {this.selected = false});
}

class DropdownWithSearchStore<T> = _DropdownWithSearchStore<T>
    with _$DropdownWithSearchStore<T>;

abstract class _DropdownWithSearchStore<T> with Store implements Disposable {
  final OnSearch<T> onSearch;

  @observable
  ObservableList<T> selectedList;

  OnChangeSelectedList<T>? onChangeSelectedList;

  @observable
  ObservableList<DropdownListItem<T>> searchList =
      ObservableList<DropdownListItem<T>>();

  @observable
  bool loading = false;

  @observable
  String? error;

  String? term;

  Timer? _debounce;

  _DropdownWithSearchStore({
    required this.onSearch,
    List<T>? selectedList,
    this.onChangeSelectedList,
  }) : selectedList = ObservableList.of(
          selectedList == null ? <T>[] : selectedList,
        );

  void startDelayedSearh([String? term]) {
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

  Future fetch() async {
    loading = true;
    try {
      print('iniciou pesquisa');
      final response = await onSearch(term);
      final dropdownList = response
          .map(
            (i) => DropdownListItem<T>(i, selected: selectedList.contains(i)),
          )
          .toList();
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

  void select(T item, [uniqueItem = false]) {
    bool selected = true;
    if (uniqueItem) {
      selectedList
        ..clear()
        ..add(item);
      searchList.forEach((element) => element.selected = false);
    } else {
      selected = !selectedList.remove(item);
      if (selected) {
        selectedList.add(item);
      }
    }

    final searchListItemIndex = searchList.indexWhere(
      (i) => i.itemData == item,
    );

    // Foi preciso substituir o DropdownListItem para acionar o Observer
    // Somente alterando o DropdownListItem.selected, o widget era atualizado
    searchList[searchListItemIndex] = DropdownListItem<T>(
      item,
      selected: selected,
    );
    onChangeSelectedList!(selectedList);
  }
}
