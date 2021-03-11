import 'package:flutter/material.dart';
import 'package:minha_biblioteca/components/dropdown_with_search_and_chips.dart';

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
              _buildYearFormField(),
              DropdownWithSearchAndChips(context: context),
              Container(
                padding: EdgeInsets.only(top: 16),
                width: double.maxFinite,
                child: ElevatedButton(
                  child: Text('Salvar'),
                  onPressed: () {
                    _formKey.currentState?.save();
                    print(_description);
                    print(_year);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildYearFormField() {
    final _yearController = TextEditingController();

    return TextFormField(
      controller: _yearController,
      decoration: InputDecoration(labelText: 'Ano'),
      keyboardType: TextInputType.number,
      validator: (val) => val!.length < 1 ? 'Campo obrigatório' : null,
      readOnly: true,
      onTap: () => showDialog(
        context: context,
        builder: (_) => SimpleDialog(
          title: Row(
            children: [
              Icon(Icons.calendar_today),
              Text('Selecione o ano'),
            ],
          ),
          children: [
            Container(
              width: MediaQuery.of(context).size.width * .5,
              height: MediaQuery.of(context).size.width * .5,
              child: YearPicker(
                selectedDate: DateTime(_year),
                firstDate: DateTime(0),
                lastDate: DateTime.now(),
                onChanged: (val) {
                  print(val);
                  _year = val.year;
                  _yearController.text = _year.toString();
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
