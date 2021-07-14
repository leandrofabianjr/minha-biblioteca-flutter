// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items_form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ItemsFormStore on _ItemsFormStore, Store {
  final _$loadingAtom = Atom(name: '_ItemsFormStore.loading');

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

  final _$descriptionAtom = Atom(name: '_ItemsFormStore.description');

  @override
  String? get description {
    _$descriptionAtom.reportRead();
    return super.description;
  }

  @override
  set description(String? value) {
    _$descriptionAtom.reportWrite(value, super.description, () {
      super.description = value;
    });
  }

  final _$yearAtom = Atom(name: '_ItemsFormStore.year');

  @override
  int? get year {
    _$yearAtom.reportRead();
    return super.year;
  }

  @override
  set year(int? value) {
    _$yearAtom.reportWrite(value, super.year, () {
      super.year = value;
    });
  }

  final _$authorsAtom = Atom(name: '_ItemsFormStore.authors');

  @override
  ObservableList<Author>? get authors {
    _$authorsAtom.reportRead();
    return super.authors;
  }

  @override
  set authors(ObservableList<Author>? value) {
    _$authorsAtom.reportWrite(value, super.authors, () {
      super.authors = value;
    });
  }

  final _$publishersAtom = Atom(name: '_ItemsFormStore.publishers');

  @override
  ObservableList<Publisher>? get publishers {
    _$publishersAtom.reportRead();
    return super.publishers;
  }

  @override
  set publishers(ObservableList<Publisher>? value) {
    _$publishersAtom.reportWrite(value, super.publishers, () {
      super.publishers = value;
    });
  }

  final _$genresAtom = Atom(name: '_ItemsFormStore.genres');

  @override
  ObservableList<Genre>? get genres {
    _$genresAtom.reportRead();
    return super.genres;
  }

  @override
  set genres(ObservableList<Genre>? value) {
    _$genresAtom.reportWrite(value, super.genres, () {
      super.genres = value;
    });
  }

  final _$locationAtom = Atom(name: '_ItemsFormStore.location');

  @override
  Location? get location {
    _$locationAtom.reportRead();
    return super.location;
  }

  @override
  set location(Location? value) {
    _$locationAtom.reportWrite(value, super.location, () {
      super.location = value;
    });
  }

  @override
  String toString() {
    return '''
loading: ${loading},
description: ${description},
year: ${year},
authors: ${authors},
publishers: ${publishers},
genres: ${genres},
location: ${location}
    ''';
  }
}
