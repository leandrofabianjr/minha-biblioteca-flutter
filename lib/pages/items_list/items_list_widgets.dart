import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:minha_biblioteca/graphql/gql_items.dart';
import 'package:minha_biblioteca/pages/error/error_page.dart';
import 'package:minha_biblioteca/pages/loading/loading_page.dart';

class ItemsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Items cadastrados')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Modular.to.navigate('/items/new'),
        child: Icon(Icons.add),
      ),
      body: Subscription(
        options: SubscriptionOptions(
          document: GqlItems.subscription,
        ),
        builder: (result) {
          if (result.hasException) {
            print('Error ----> ${result.exception}');
            return ErrorPage();
          }
          if (result.data != null) {
            final items = result.data?['items'] ?? [];
            print(items.toString());
            return _buildDataTable(items);
          }

          return LoadingPage();
        },
      ),
    );
  }

  DataTable _buildDataTable(List items) {
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
          items.length, (int i) => _buildDataRow(items[i])).toList(),
    );
  }

  _buildDataRow(dynamic item) {
    return DataRow(
      cells: [
        DataCell(Text(item['description'])),
        DataCell(Wrap(
          children: List<Widget>.generate(
            item['authors'].length,
            (int i) => Chip(label: Text(item['authors'][i]['author']['name'])),
          ),
        )),
        DataCell(Wrap(
          children: List<Widget>.generate(
            item['genres'].length,
            (int i) =>
                Chip(label: Text(item['genres'][i]['genre']['description'])),
          ),
        )),
        DataCell(Text(item['year'].toString())),
        DataCell(Wrap(
          children: List<Widget>.generate(
            item['publishers'].length,
            (int i) =>
                Chip(label: Text(item['publishers'][i]['publisher']['name'])),
          ),
        )),
        DataCell(
          Chip(label: Text(item['location']['description'])),
        ),
      ],
    );
  }
}
