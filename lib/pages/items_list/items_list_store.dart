import 'package:minha_biblioteca/models/item.dart';
import 'package:minha_biblioteca/services/items_service.dart';
import 'package:mobx/mobx.dart';

// Include generated file
part 'items_list_store.g.dart';

// This is the class used by rest of your codebase
class ItemsListStore = _ItemsListStore with _$ItemsListStore;

// The store-class
abstract class _ItemsListStore with Store {
  final _service = ItemsService();

  @observable
  ObservableList<Item> items = ObservableList<Item>();

  @observable
  String? error;

  @observable
  bool loading = true;

  @action
  Future fetch() async {
    loading = true;
    try {
      items = ObservableList.of(await _service.fetch());
    } catch (ex) {
      print(ex);
      error = 'Não foi possível carregar os itens';
    }
    loading = false;
  }
}
