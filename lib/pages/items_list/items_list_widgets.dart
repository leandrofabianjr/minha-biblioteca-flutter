import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:minha_biblioteca/models/item.dart';
import 'package:minha_biblioteca/pages/items_list/items_list_store.dart';
import 'package:minha_biblioteca/pages/loading/loading_page.dart';

class ItemsList extends StatelessWidget {
  final itemsList = ItemsListStore(
    page: 1,
    rowsPerPage: PaginatedDataTable.defaultRowsPerPage,
    sortAscending: false,
    sortColumnIndex: 0,
  )..fetch();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Items cadastrados')),
      body: Observer(
        builder: (context) {
          if (itemsList.loading) {
            return LoadingPage();
          }

          if (itemsList.items.length < 1) {
            return _buildNoItems(context);
          }

          return _buildDataTable(context);
        },
      ),
    );
  }

  Widget _buildDataTable(BuildContext context) {
    final headerTextStyle = TextStyle(color: Theme.of(context).primaryColor);
    return SingleChildScrollView(
      child: PaginatedDataTable(
        columns: [
          DataColumn(
            label: Text('Descrição', style: headerTextStyle),
            onSort: _sort,
          ),
          DataColumn(
            label: Text('Autores', style: headerTextStyle),
            onSort: _sort,
          ),
          DataColumn(
            label: Text('Gêneros', style: headerTextStyle),
            onSort: _sort,
          ),
          DataColumn(
            label: Text('Ano', style: headerTextStyle),
            onSort: _sort,
          ),
          DataColumn(
            label: Text('Editora', style: headerTextStyle),
            onSort: _sort,
          ),
          DataColumn(
            label: Text('Local', style: headerTextStyle),
            onSort: _sort,
          ),
        ],
        source: ItemsDataTableSource(items: itemsList.items),
        header: Text('Items'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Modular.to.pushNamed('/items/new');
            },
          ),
        ],
        availableRowsPerPage: [5, 10, 20, 50, 100],
        onRowsPerPageChanged: (rowsPerPage) =>
            itemsList.changePage(rowsPerPage: rowsPerPage!),
        onPageChanged: (page) => itemsList.changePage(page: page),
        rowsPerPage: itemsList.rowsPerPage,
        sortAscending: itemsList.sortAscending,
        sortColumnIndex: itemsList.sortColumnIndex,
      ),
    );
  }

  _sort(i, asc) {
    itemsList.sort(i, asc);
  }

  Widget _buildNoItems(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Não há itens cadastrados', style: TextStyle(fontSize: 16)),
          SizedBox(height: 8),
          TextButton(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 4),
                  Text('Crie um agora mesmo'),
                ],
              ),
            ),
            onPressed: () {
              Modular.to.pushNamed('/items/new');
            },
          )
        ],
      ),
    );
  }
}

class ItemsDataTableSource extends DataTableSource {
  final List<Item> items;

  ItemsDataTableSource({required this.items});
  @override
  DataRow? getRow(int index) {
    final item = items[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(item.description)),
        DataCell(Wrap(
          children: List<Widget>.generate(
            item.authors.length,
            (int i) => Chip(label: Text(item.authors[i].name)),
          ),
        )),
        DataCell(Wrap(
          children: List<Widget>.generate(
            item.genres.length,
            (int i) => Chip(label: Text(item.genres[i].description)),
          ),
        )),
        DataCell(Text(item.year.toString())),
        DataCell(Wrap(
          children: List<Widget>.generate(
            item.publishers.length,
            (int i) => Chip(label: Text(item.publishers[i].name)),
          ),
        )),
        DataCell(
          Chip(label: Text(item.location.description)),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => items.length;

  @override
  int get selectedRowCount => 0;
}
