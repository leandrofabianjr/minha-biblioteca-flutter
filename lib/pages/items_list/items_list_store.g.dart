// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ItemsListStore on _ItemsListStore, Store {
  final _$errorAtom = Atom(name: '_ItemsListStore.error');

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

  final _$loadingAtom = Atom(name: '_ItemsListStore.loading');

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

  final _$itemsAtom = Atom(name: '_ItemsListStore.items');

  @override
  ObservableList<Item> get items {
    _$itemsAtom.reportRead();
    return super.items;
  }

  @override
  set items(ObservableList<Item> value) {
    _$itemsAtom.reportWrite(value, super.items, () {
      super.items = value;
    });
  }

  final _$totalCountAtom = Atom(name: '_ItemsListStore.totalCount');

  @override
  int get totalCount {
    _$totalCountAtom.reportRead();
    return super.totalCount;
  }

  @override
  set totalCount(int value) {
    _$totalCountAtom.reportWrite(value, super.totalCount, () {
      super.totalCount = value;
    });
  }

  final _$rowsPerPageAtom = Atom(name: '_ItemsListStore.rowsPerPage');

  @override
  int get rowsPerPage {
    _$rowsPerPageAtom.reportRead();
    return super.rowsPerPage;
  }

  @override
  set rowsPerPage(int value) {
    _$rowsPerPageAtom.reportWrite(value, super.rowsPerPage, () {
      super.rowsPerPage = value;
    });
  }

  final _$pageAtom = Atom(name: '_ItemsListStore.page');

  @override
  int get page {
    _$pageAtom.reportRead();
    return super.page;
  }

  @override
  set page(int value) {
    _$pageAtom.reportWrite(value, super.page, () {
      super.page = value;
    });
  }

  final _$sortAscendingAtom = Atom(name: '_ItemsListStore.sortAscending');

  @override
  bool get sortAscending {
    _$sortAscendingAtom.reportRead();
    return super.sortAscending;
  }

  @override
  set sortAscending(bool value) {
    _$sortAscendingAtom.reportWrite(value, super.sortAscending, () {
      super.sortAscending = value;
    });
  }

  final _$sortColumnIndexAtom = Atom(name: '_ItemsListStore.sortColumnIndex');

  @override
  int get sortColumnIndex {
    _$sortColumnIndexAtom.reportRead();
    return super.sortColumnIndex;
  }

  @override
  set sortColumnIndex(int value) {
    _$sortColumnIndexAtom.reportWrite(value, super.sortColumnIndex, () {
      super.sortColumnIndex = value;
    });
  }

  final _$fetchAsyncAction = AsyncAction('_ItemsListStore.fetch');

  @override
  Future<dynamic> fetch() {
    return _$fetchAsyncAction.run(() => super.fetch());
  }

  final _$_ItemsListStoreActionController =
      ActionController(name: '_ItemsListStore');

  @override
  dynamic sort(int columnIndex, bool ascending) {
    final _$actionInfo = _$_ItemsListStoreActionController.startAction(
        name: '_ItemsListStore.sort');
    try {
      return super.sort(columnIndex, ascending);
    } finally {
      _$_ItemsListStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changePage({int rowsPerPage = -1, int page = -1}) {
    final _$actionInfo = _$_ItemsListStoreActionController.startAction(
        name: '_ItemsListStore.changePage');
    try {
      return super.changePage(rowsPerPage: rowsPerPage, page: page);
    } finally {
      _$_ItemsListStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
error: ${error},
loading: ${loading},
items: ${items},
totalCount: ${totalCount},
rowsPerPage: ${rowsPerPage},
page: ${page},
sortAscending: ${sortAscending},
sortColumnIndex: ${sortColumnIndex}
    ''';
  }
}
