import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:minha_biblioteca/pages/error/error_page.dart';
import 'package:minha_biblioteca/pages/loading/loading_page.dart';

class ListItemsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Items cadastrados')),
      body: Subscription(
        options: SubscriptionOptions(
          document: gql(
            r'''
            query {
              items {
                year
                description
                uuid
                user {
                  name
                }
              }
            }
            ''',
          ),
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
    final rows = <DataRow>[];

    items.forEach((item) {
      rows.add(
        DataRow(
          cells: [
            DataCell(Text(item['description'])),
            DataCell(Text('')),
            DataCell(Text('')),
            DataCell(Text(item['year'].toString())),
            DataCell(Text('')),
            DataCell(Text('')),
          ],
        ),
      );
    });

    return DataTable(
      columns: [
        DataColumn(label: Text('Descrição')),
        DataColumn(label: Text('Autores')),
        DataColumn(label: Text('Gêneros')),
        DataColumn(label: Text('Ano')),
        DataColumn(label: Text('Editora')),
        DataColumn(label: Text('Local')),
      ],
      rows: rows,
    );
  }
}
