// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DropdownListItem<T> on _DropdownListItem<T>, Store {
  final _$selectedAtom = Atom(name: '_DropdownListItem.selected');

  @override
  bool get selected {
    _$selectedAtom.reportRead();
    return super.selected;
  }

  @override
  set selected(bool value) {
    _$selectedAtom.reportWrite(value, super.selected, () {
      super.selected = value;
    });
  }

  @override
  String toString() {
    return '''
selected: ${selected}
    ''';
  }
}

mixin _$DropdownWithSearchStore<T> on _DropdownWithSearchStore<T>, Store {
  final _$selectedListAtom =
      Atom(name: '_DropdownWithSearchStore.selectedList');

  @override
  ObservableList<T> get selectedList {
    _$selectedListAtom.reportRead();
    return super.selectedList;
  }

  @override
  set selectedList(ObservableList<T> value) {
    _$selectedListAtom.reportWrite(value, super.selectedList, () {
      super.selectedList = value;
    });
  }

  final _$searchListAtom = Atom(name: '_DropdownWithSearchStore.searchList');

  @override
  ObservableList<DropdownListItem<T>> get searchList {
    _$searchListAtom.reportRead();
    return super.searchList;
  }

  @override
  set searchList(ObservableList<DropdownListItem<T>> value) {
    _$searchListAtom.reportWrite(value, super.searchList, () {
      super.searchList = value;
    });
  }

  final _$loadingAtom = Atom(name: '_DropdownWithSearchStore.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$errorAtom = Atom(name: '_DropdownWithSearchStore.error');

  @override
  String get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$fetchAsyncAction = AsyncAction('_DropdownWithSearchStore.fetch');

  @override
  Future<dynamic> fetch() {
    return _$fetchAsyncAction.run(() => super.fetch());
  }

  final _$_DropdownWithSearchStoreActionController =
      ActionController(name: '_DropdownWithSearchStore');

  @override
  void startDelayedSearh(String term) {
    final _$actionInfo = _$_DropdownWithSearchStoreActionController.startAction(
        name: '_DropdownWithSearchStore.startDelayedSearh');
    try {
      return super.startDelayedSearh(term);
    } finally {
      _$_DropdownWithSearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void select(int searchListItemIndex) {
    final _$actionInfo = _$_DropdownWithSearchStoreActionController.startAction(
        name: '_DropdownWithSearchStore.select');
    try {
      return super.select(searchListItemIndex);
    } finally {
      _$_DropdownWithSearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void remove(T selectedItemToRemove) {
    final _$actionInfo = _$_DropdownWithSearchStoreActionController.startAction(
        name: '_DropdownWithSearchStore.remove');
    try {
      return super.remove(selectedItemToRemove);
    } finally {
      _$_DropdownWithSearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedList: ${selectedList},
searchList: ${searchList},
loading: ${loading},
error: ${error}
    ''';
  }
}
