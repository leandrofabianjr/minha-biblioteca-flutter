// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ItemsListStore on _ItemsListStore, Store {
  final _$itemsAtom = Atom(name: '_ItemsListStore.items');

  @override
  ObservableList<Item> get items {
    _$itemsAtom.reportRead();
    return super.items;
  }

  @override
  set items(ObservableList<Item>? value) {
    _$itemsAtom.reportWrite(value, super.items, () {
      super.items = value!;
    });
  }

  final _$errorAtom = Atom(name: '_ItemsListStore.error');

  @override
  String get error {
    _$errorAtom.reportRead();
    return super.error!;
  }

  @override
  set error(String? value) {
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

  final _$fetchAsyncAction = AsyncAction('_ItemsListStore.fetch');

  @override
  Future fetch() {
    return _$fetchAsyncAction.run(() => super.fetch());
  }

  @override
  String toString() {
    return '''
items: ${items},
error: ${error},
loading: ${loading}
    ''';
  }
}
