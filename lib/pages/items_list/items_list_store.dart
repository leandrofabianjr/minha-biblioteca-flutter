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
  String error = '';

  @observable
  bool loading = true;

  @observable
  ObservableList<Item> items = ObservableList<Item>();

  @observable
  int totalCount = 0;

  @observable
  int rowsPerPage;

  @observable
  int page;

  @observable
  bool sortAscending;

  @observable
  int sortColumnIndex;

  _ItemsListStore({
    required this.rowsPerPage,
    required this.page,
    required this.sortAscending,
    required this.sortColumnIndex,
  });

  @action
  Future fetch() async {
    loading = true;
    try {
      final response = await _service.fetch(
        userId: '',
        limit: rowsPerPage,
        offset: (page - 1) * rowsPerPage,
      );
      items
        ..clear()
        ..addAll(response.data);
      totalCount = response.totalCount;
    } catch (ex) {
      print(ex);
      error = 'Não foi possível carregar os itens';
    }
    loading = false;
  }

  @action
  sort(int columnIndex, bool ascending) {
    sortColumnIndex = columnIndex;
    sortAscending = ascending;
  }

  @action
  changePage({int? rowsPerPage, int? page}) {
    if (rowsPerPage != null) this.rowsPerPage = rowsPerPage;
    if (page != null) this.page = page;
    fetch();
  }
}
