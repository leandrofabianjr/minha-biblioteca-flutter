import 'package:flutter/material.dart';
import 'package:minha_biblioteca/components/dropdown_with_search/widgets.dart';
import 'package:minha_biblioteca/components/year_picker_field.dart';
import 'package:minha_biblioteca/models/author.dart';
import 'package:minha_biblioteca/models/genre.dart';
import 'package:minha_biblioteca/models/location.dart';
import 'package:minha_biblioteca/models/publisher.dart';
import 'package:minha_biblioteca/services/authors_service.dart';
import 'package:minha_biblioteca/services/genres_service.dart';
import 'package:minha_biblioteca/services/locations_service.dart';
import 'package:minha_biblioteca/services/publishers_service.dart';

class ItemsForm extends StatefulWidget {
  final String? id;

  ItemsForm({
    this.id,
  }) : super();

  @override
  _ItemsFormState createState() => _ItemsFormState();
}

class _ItemsFormState extends State<ItemsForm> {
  final _formKey = GlobalKey<FormState>();
  String? _description;
  int _year = 2000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                initialValue: _description,
                decoration: InputDecoration(labelText: 'Descrição'),
                onSaved: (val) => _description = val!,
                validator: (val) =>
                    val!.length < 1 ? 'Campo obrigatório' : null,
              ),
              YearPickerField(
                initialYear: _year,
                onSelect: (year) => _year = _year,
              ),
              DropdownWithSearch<Author>(
                context: context,
                label: 'Autor(es)',
                onSearch: (term) => AuthorsService().search(
                  userId: 'd3363699-fc2f-4b00-af2f-0c68c20dd951',
                  limit: 10,
                  searchByName: term,
                ),
                onBuildLabel: (author) => Text(author.name),
                placeholder: 'Procure por um autor',
                onChangeSelectedList: (authors) {
                  authors.forEach((a) {
                    print(a.uuid);
                    print(a.name);
                  });
                },
              ),
              DropdownWithSearch<Publisher>(
                context: context,
                label: 'Editora(s)',
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
                },
              ),
              DropdownWithSearch<Genre>(
                context: context,
                label: 'Gênero(s)',
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
                },
              ),
              DropdownWithSearch<Location>(
                context: context,
                label: 'Localização',
                uniqueItem: true,
                onSearch: (term) => LocationsService().search(
                  userId: 'd3363699-fc2f-4b00-af2f-0c68c20dd951',
                  limit: 10,
                  searchByDescription: term,
                ),
                onBuildLabel: (location) => Text(location.description),
                placeholder: 'Procure por um local',
                onChangeSelectedList: (locations) {
                  locations.forEach((l) {
                    print(l.uuid);
                    print(l.description);
                  });
                },
              ),
              Container(
                padding: EdgeInsets.only(top: 16),
                width: double.maxFinite,
                child: ElevatedButton(
                  child: Text('Salvar'),
                  onPressed: () {
                    _formKey.currentState?.save();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
