import 'package:flutter/material.dart';

class YearPickerField extends StatefulWidget {
  final int initialYear;
  final void Function(int year) onSelect;

  const YearPickerField({
    Key? key,
    required this.initialYear,
    required this.onSelect,
  }) : super(key: key);
  @override
  _YearPickerFieldState createState() => _YearPickerFieldState();
}

class _YearPickerFieldState extends State<YearPickerField> {
  final _yearController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int _year = widget.initialYear;
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
                  setState(() {
                    _year = val.year;
                    _yearController.text = _year.toString();
                    widget.onSelect(val.year);
                  });
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
