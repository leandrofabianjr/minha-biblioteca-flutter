import 'package:mobx/mobx.dart';

// Include generated file
part 'items_list_store.g.dart';

// This is the class used by rest of your codebase
class ItemsListStore = _ItemsListStore with _$ItemsListStore;

// The store-class
abstract class _ItemsListStore with Store {
  @action
  void fetch() async {}
}
