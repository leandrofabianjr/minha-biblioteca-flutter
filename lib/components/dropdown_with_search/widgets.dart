import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:minha_biblioteca/components/dropdown_with_search/store.dart';

typedef OnSearch<T> = Future<List<T>> Function(String? term);
typedef OnChangeSelectedList<T> = void Function(List<T> selecteds);

class DropdownWithSearch<T> extends StatelessWidget {
  final BuildContext context;
  final String label;
  final OnSearch<T> onSearch;
  final Widget Function(T) onBuildLabel;
  final String placeholder;
  final OnChangeSelectedList<T>? onChangeSelectedList;
  final List<T>? selectedList;
  final bool uniqueItem;

  late final store = DropdownWithSearchStore(
    onSearch: onSearch,
    onChangeSelectedList: onChangeSelectedList,
    selectedList: selectedList,
  );

  DropdownWithSearch({
    Key? key,
    required this.context,
    required this.label,
    required this.onSearch,
    required this.onBuildLabel,
    this.placeholder = 'Pesquisar',
    this.onChangeSelectedList,
    this.selectedList,
    this.uniqueItem = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 12, bottom: 4),
            child: Text(
              label,
              style: TextStyle(
                color: theme.primaryColor,
                fontSize: theme.textTheme.caption!.fontSize,
              ),
            ),
          ),
          Observer(
            builder: (context) {
              return Wrap(
                children: List<Widget>.generate(
                  store.selectedList.length,
                  (i) => Padding(
                    padding: EdgeInsets.only(right: 4, bottom: 4),
                    child: InputChip(
                      label: onBuildLabel(store.selectedList[i]),
                      onDeleted: () => store.select(store.selectedList[i]),
                      deleteIcon: Icon(Icons.delete),
                      deleteIconColor: theme.accentColor,
                    ),
                  ),
                )..add(
                    InputChip(
                      label: Text(uniqueItem ? 'Selecione' : 'Adicionar',
                          style: TextStyle(color: Colors.white)),
                      avatar: Icon(Icons.add, color: Colors.white),
                      onSelected: (_) {
                        showModalBottomSheet(
                          context: context,
                          builder: _buildBottomSheet,
                        );
                      },
                      backgroundColor: theme.primaryColor,
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
    store.startDelayedSearh();
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: TextField(
            controller: TextEditingController(text: store.term),
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
            if (!store.loading) {
              if (store.searchList.length > 0) {
                return ListView.builder(
                  itemCount: store.searchList.length,
                  itemBuilder: (_, i) => CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: onBuildLabel(store.searchList[i].itemData),
                    onChanged: (_) {
                      store.select(store.searchList[i].itemData, uniqueItem);
                    },
                    value: store.searchList[i].selected,
                    selected: store.searchList[i].selected,
                  ),
                );
              }
              return Center(
                child: Text(
                  store.term?.isEmpty ?? true
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
