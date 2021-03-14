import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:minha_biblioteca/components/dropdown_with_search/widgets.dart';
import 'package:mobx/mobx.dart';

part 'store.g.dart';

class DropdownWithSearchStore<T> = _DropdownWithSearchStore<T>
    with _$DropdownWithSearchStore;

abstract class _DropdownWithSearchStore<T> with Store implements Disposable {
  final OnSearch<T> _onSearch;

  @observable
  ObservableList<T> selectedList = ObservableList<T>();

  // ignore: avoid_init_to_null
  OnChangeSelectedList<T>? onChangeSelectedList = null;

  @observable
  ObservableList<T> searchList = ObservableList<T>();

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
      searchList
        ..clear()
        ..addAll(response);
      print('terminou pesquisa');
    } catch (ex) {
      print(ex);
      error = 'Não foi possível fazer a busca';
    }
    loading = false;
  }

  @action
  void select(T selected) {
    if (!selectedList.remove(selected)) {
      selectedList.add(selected);
    }
    onChangeSelectedList!(selectedList);
  }
}
