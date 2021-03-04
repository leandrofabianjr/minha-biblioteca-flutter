import 'package:flutter/material.dart';
import 'package:minha_biblioteca/pages/error/error_page.dart';
import 'package:minha_biblioteca/pages/loading/loading_page.dart';
import 'package:minha_biblioteca/services/items_service.dart';

class ListItemsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ItemsService().list(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            print(snapshot.data);
            return ErrorPage();
          }

          if (snapshot.connectionState == ConnectionState.done) {
            print(snapshot.data);
            return Scaffold(
              appBar: AppBar(title: Text('Items cadastrados')),
              body: DataTable(
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text('Descrição'),
                  ),
                  DataColumn(
                    label: Text('Autores'),
                  ),
                  DataColumn(
                    label: Text('Gêneros'),
                  ),
                  DataColumn(
                    label: Text('Ano'),
                  ),
                  DataColumn(
                    label: Text('Editora'),
                  ),
                  DataColumn(
                    label: Text('Local'),
                  ),
                ],
                rows: const <DataRow>[
                  // DataRow(
                  //   cells: <DataCell>[
                  //     DataCell(Text('Teste')),
                  //     DataCell(Text('19')),
                  //     DataCell(Text('Student')),
                  //   ],
                  // ),
                ],
              ),
            );
          }

          return LoadingPage();
        });
  }
}
