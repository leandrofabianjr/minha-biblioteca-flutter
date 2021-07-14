import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:minha_biblioteca/components/dropdown_with_search/widgets.dart';
import 'package:minha_biblioteca/components/year_picker_field.dart';
import 'package:minha_biblioteca/components/toast.dart';
import 'package:minha_biblioteca/models/author.dart';
import 'package:minha_biblioteca/models/genre.dart';
import 'package:minha_biblioteca/models/location.dart';
import 'package:minha_biblioteca/models/publisher.dart';
import 'package:minha_biblioteca/pages/items_form/items_form_store.dart';

class ItemsForm extends StatefulWidget {
  final String? id;

  ItemsForm({
    this.id,
  }) : super();

  @override
  _ItemsFormState createState() => _ItemsFormState();
}

class _ItemsFormState extends State<ItemsForm> {
  final store = ItemsFormStore();

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Item'),
        ),
        body: Observer(builder: (context) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  initialValue: store.description,
                  decoration: InputDecoration(labelText: 'Descrição'),
                  onChanged: (val) => store.description = val,
                ),
                YearPickerField(
                  initialYear: store.initialYear,
                  onSelect: (val) => store.year = val,
                ),
                DropdownWithSearch<Author>(
                  context: context,
                  label: 'Autor(es)',
                  selectedList: store.authors,
                  onSearch: store.filterAuthors,
                  onBuildLabel: (author) => Text(author.name),
                  placeholder: 'Procure por um autor',
                  onChangeSelectedList: store.onChangeAuthors,
                ),
                DropdownWithSearch<Publisher>(
                  context: context,
                  label: 'Editora(s)',
                  selectedList: store.publishers,
                  onSearch: store.filterPublishers,
                  onBuildLabel: (publisher) => Text(publisher.name),
                  placeholder: 'Procure por uma editora',
                  onChangeSelectedList: store.onChangePublishers,
                ),
                DropdownWithSearch<Genre>(
                  context: context,
                  label: 'Gênero(s)',
                  selectedList: store.genres,
                  onSearch: store.filterGenres,
                  onBuildLabel: (genre) => Text(genre.description),
                  placeholder: 'Procure por um gênero',
                  onChangeSelectedList: store.onChangeGenres,
                ),
                DropdownWithSearch<Location>(
                  context: context,
                  label: 'Localização',
                  uniqueItem: true,
                  selectedList:
                      store.location != null ? [store.location!] : null,
                  onSearch: store.filterLocations,
                  onBuildLabel: (location) => Text(location.description),
                  placeholder: 'Procure por um local',
                  onChangeSelectedList: store.onChangeLocations,
                ),
                Container(
                  padding: EdgeInsets.only(top: 16),
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: Text('Salvar'),
                    onPressed: () async {
                      final errorMessage = await store.save();
                      if (errorMessage == null) {
                        ScaffoldMessenger.of(context).toast.success(
                              message: 'Item criado com sucesso',
                              action: SnackBarAction(
                                label: 'Voltar para a listagem',
                                onPressed: () => Modular.to.pop(),
                              ),
                            );
                      } else {
                        ScaffoldMessenger.of(context)
                            .toast
                            .error(message: errorMessage);
                      }
                    },
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
