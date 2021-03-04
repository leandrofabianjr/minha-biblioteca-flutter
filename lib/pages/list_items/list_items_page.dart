import 'package:flutter/material.dart';

class ListItemsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
}
