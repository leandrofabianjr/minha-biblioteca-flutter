import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:minha_biblioteca/models/item.dart';
import 'package:minha_biblioteca/pages/items_list/items_list_store.dart';
import 'package:minha_biblioteca/pages/loading/loading_page.dart';

class ItemsList extends StatelessWidget {
  final itemsList = ItemsListStore()..fetch();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Items cadastrados')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Modular.to.navigate('/items/new'),
        child: Icon(Icons.add),
      ),
      body: Observer(
        builder: (context) {
          if (!itemsList.loading) {
            print(itemsList.items.toString());
            return _buildDataTable();
          }
          return LoadingPage();
        },
      ),
    );
  }

  DataTable _buildDataTable() {
    return DataTable(
      columns: [
        DataColumn(label: Text('Descrição')),
        DataColumn(label: Text('Autores')),
        DataColumn(label: Text('Gêneros')),
        DataColumn(label: Text('Ano')),
        DataColumn(label: Text('Editora')),
        DataColumn(label: Text('Local')),
      ],
      rows: List<DataRow>.generate(
        itemsList.items.length,
        (int i) => _buildDataRow(itemsList.items[i]),
      ),
    );
  }

  _buildDataRow(Item item) {
    return DataRow(
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
}
