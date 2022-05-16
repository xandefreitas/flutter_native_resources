import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_resources/widgets/image_input.dart';

class PlaceFormScreen extends StatefulWidget {
  const PlaceFormScreen({Key? key}) : super(key: key);

  @override
  State<PlaceFormScreen> createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Lugar'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(labelText: 'Título'),
                  ),
                  SizedBox(height: 8),
                  ImageInput(onSelectImage: this._selectImage),
                ],
              ),
            ),
          ),
          Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).colorScheme.secondary,
              elevation: 0,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            ),
            onPressed: _submitForm,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add),
                Text('Adicionar'),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _submitForm() {}
  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }
}
