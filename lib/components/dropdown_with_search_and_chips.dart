import 'package:flutter/material.dart';

class DropdownWithSearchAndChips extends StatefulWidget {
  final BuildContext context;

  const DropdownWithSearchAndChips({Key? key, required this.context})
      : super(key: key);

  @override
  _DropdownWithSearchAndChipsState createState() =>
      _DropdownWithSearchAndChipsState();
}

class _DropdownWithSearchAndChipsState
    extends State<DropdownWithSearchAndChips> {
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
          Wrap(
            children: List<Widget>.generate(
              10,
              (index) => Padding(
                padding: EdgeInsets.only(right: 4, bottom: 4),
                child: InputChip(
                  label: Text('Autor 01'),
                  onDeleted: () => print('removeu'),
                  deleteIcon: Icon(Icons.delete),
                  deleteIconColor: Theme.of(context).accentColor,
                ),
              ),
            )..add(InputChip(
                label: Text('Adicionar', style: TextStyle(color: Colors.white)),
                avatar: Icon(Icons.add, color: Colors.white),
                onSelected: (_) {
                  showModalBottomSheet(
                    context: widget.context,
                    builder: _buildBottomSheet,
                  );
                },
                backgroundColor: Theme.of(context).primaryColor,
              )),
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
            decoration: InputDecoration(
              labelText: 'Pesquisar',
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 50,
            itemBuilder: (_, i) => CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: Text('Item $i'),
              value: false,
              onChanged: (val) {},
            ),
          ),
        ),
      ],
    );
  }
}
