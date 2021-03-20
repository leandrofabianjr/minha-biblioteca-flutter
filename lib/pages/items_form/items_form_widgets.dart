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
import 'package:minha_biblioteca/services/authors_service.dart';
import 'package:minha_biblioteca/services/genres_service.dart';
import 'package:minha_biblioteca/services/locations_service.dart';
import 'package:minha_biblioteca/services/publishers_service.dart';
import 'package:mobx/mobx.dart';

class ItemsForm extends StatefulWidget {
  final String? id;

  ItemsForm({
    this.id,
  }) : super();

  @override
  _ItemsFormState createState() => _ItemsFormState();
}

class _ItemsFormState extends State<ItemsForm> {
  late final store = ItemsFormStore();
  ReactionDisposer? _disposerErrorMessage;
  ReactionDisposer? _disposerSuccess;

  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    // a delay is used to avoid showing the snackbar too much when the connection drops in and out repeatedly
    _disposerErrorMessage = reaction(
      (_) => store.errorMessage,
      (_) {
        if (store.errorMessage != null) {
          _scaffoldMessengerKey.currentState.toast
              .error(message: store.errorMessage!);
          store.errorMessage = null;
        }
      },
    );
    _disposerSuccess = reaction(
      (_) => store.success,
      (_) {
        if (store.success != null && store.success!) {
          _scaffoldMessengerKey.currentState.toast.success(
              message: 'Item criado com sucesso',
              action: SnackBarAction(
                  label: 'Voltar para a listagem',
                  onPressed: () => Modular.to.pushNamed('/items')));
          store.success = null;
        }
      },
    );
  }

  @override
  void dispose() {
    _disposerErrorMessage!();
    _disposerSuccess!();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
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
                  initialYear: store.year ?? 2000,
                  onSelect: (val) => store.year = val,
                ),
                DropdownWithSearch<Author>(
                  context: context,
                  label: 'Autor(es)',
                  selectedList: store.authors,
                  onSearch: (term) => AuthorsService().search(
                    userId: 'd3363699-fc2f-4b00-af2f-0c68c20dd951',
                    limit: 10,
                    searchByName: term,
                  ),
                  onBuildLabel: (author) => Text(author.name),
                  placeholder: 'Procure por um autor',
                  onChangeSelectedList: (authors) {
                    store.authors = ObservableList.of(authors);
                  },
                ),
                DropdownWithSearch<Publisher>(
                  context: context,
                  label: 'Editora(s)',
                  selectedList: store.publishers,
                  onSearch: (term) => PublishersService().search(
                    userId: 'd3363699-fc2f-4b00-af2f-0c68c20dd951',
                    limit: 10,
                    searchByName: term,
                  ),
                  onBuildLabel: (publisher) => Text(publisher.name),
                  placeholder: 'Procure por uma editora',
                  onChangeSelectedList: (publishers) {
                    publishers.forEach((p) {
                      print(p.uuid);
                      print(p.name);
                    });
                    store.publishers = ObservableList.of(publishers);
                  },
                ),
                DropdownWithSearch<Genre>(
                  context: context,
                  label: 'Gênero(s)',
                  selectedList: store.genres,
                  onSearch: (term) => GenresService().search(
                    userId: 'd3363699-fc2f-4b00-af2f-0c68c20dd951',
                    limit: 10,
                    searchByDescription: term,
                  ),
                  onBuildLabel: (genre) => Text(genre.description),
                  placeholder: 'Procure por um gênero',
                  onChangeSelectedList: (genres) {
                    genres.forEach((g) {
                      print(g.uuid);
                      print(g.description);
                    });
                    store.genres = ObservableList.of(genres);
                  },
                ),
                DropdownWithSearch<Location>(
                  context: context,
                  label: 'Localização',
                  uniqueItem: true,
                  selectedList:
                      store.location != null ? [store.location!] : null,
                  onSearch: (term) {
                    print('-----------');
                    print('onSearch');
                    print('-----------');
                    return LocationsService().search(
                      userId: 'd3363699-fc2f-4b00-af2f-0c68c20dd951',
                      limit: 10,
                      searchByDescription: term,
                    );
                  },
                  onBuildLabel: (location) => Text(location.description),
                  placeholder: 'Procure por um local',
                  onChangeSelectedList: (locations) {
                    locations.forEach((l) {
                      print(l.uuid);
                      print(l.description);
                    });
                    store.location =
                        locations.length > 0 ? locations.first : null;
                  },
                ),
                Container(
                  padding: EdgeInsets.only(top: 16),
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: Text('Salvar'),
                    onPressed: () {
                      store.save();
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
