import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:minha_biblioteca/components/dropdown_with_search/store.dart';

typedef OnSearch<T> = Future<List<T>> Function(String term);
typedef OnChangeSelectedList<T> = void Function(List<T> selecteds);

class DropdownWithSearch<T> extends StatelessWidget {
  final BuildContext context;
  final OnSearch<T> onSearch;
  final Widget Function(T) onBuildLabel;
  final String placeholder;
  final OnChangeSelectedList<T>? onChangeSelectedList;
  final List<T>? selectedList;

  late final store = DropdownWithSearchStore(
    onSearch: onSearch,
    onChangeSelectedList: onChangeSelectedList,
    selectedList: selectedList,
  );

  DropdownWithSearch({
    Key? key,
    required this.context,
    required this.onSearch,
    required this.onBuildLabel,
    this.placeholder = 'Pesquisar',
    this.onChangeSelectedList,
    this.selectedList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 12, bottom: 4),
            child: Text(
              'Autor(es)',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: Theme.of(context).textTheme.caption!.fontSize,
              ),
            ),
          ),
          Observer(
            builder: (context) {
              print('selecionados');
              return Wrap(
                children: List<Widget>.generate(
                  store.selectedList.length,
                  (i) => Padding(
                    padding: EdgeInsets.only(right: 4, bottom: 4),
                    child: InputChip(
                      label: onBuildLabel(store.selectedList[i]),
                      onDeleted: () => store.remove(store.selectedList[i]),
                      deleteIcon: Icon(Icons.delete),
                      deleteIconColor: Theme.of(context).accentColor,
                    ),
                  ),
                )..add(
                    InputChip(
                      label: Text('Adicionar',
                          style: TextStyle(color: Colors.white)),
                      avatar: Icon(Icons.add, color: Colors.white),
                      onSelected: (_) {
                        showModalBottomSheet(
                          context: context,
                          builder: _buildBottomSheet,
                        );
                      },
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: TextField(
            controller: TextEditingController()..text = store.term,
            decoration: InputDecoration(
              labelText: placeholder,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.search),
            ),
            onChanged: store.startDelayedSearh,
          ),
        ),
        Expanded(
          child: Observer(builder: (context) {
            print('pesquisa');
            if (!store.loading) {
              if (store.searchList.length > 0) {
                return ListView.builder(
                  itemCount: store.searchList.length,
                  itemBuilder: (_, i) => CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: onBuildLabel(store.searchList[i].itemData),
                    onChanged: (_) {
                      store.select(i);
                    },
                    value: store.searchList[i].selected,
                    selected: store.searchList[i].selected,
                  ),
                );
              }
              return Center(
                child: Text(
                  store.term.isEmpty
                      ? 'Pesquise no campo acima'
                      : 'Nenhum resultado encontrado',
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
        ),
      ],
    );
  }
}
