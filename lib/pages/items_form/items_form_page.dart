import 'package:flutter/material.dart';

class ItemsFormPage extends StatefulWidget {
  @override
  _ItemsFormPageState createState() => _ItemsFormPageState();
}

class _ItemsFormPageState extends State<ItemsFormPage> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Item'),
      ),
      body: Form(
        key: _formKey,
        child: Column(),
      ),
    );
  }
}
