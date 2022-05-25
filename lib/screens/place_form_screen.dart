import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_resources/providers/great_places.dart';
import 'package:flutter_native_resources/widgets/image_input.dart';
import 'package:flutter_native_resources/widgets/location_input.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class PlaceFormScreen extends StatefulWidget {
  const PlaceFormScreen({Key? key}) : super(key: key);

  @override
  State<PlaceFormScreen> createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  LatLng? _pickedPosition;

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
                    onChanged: (text) {
                      setState(() {});
                    },
                  ),
                  SizedBox(height: 8),
                  ImageInput(onSelectImage: this._selectImage),
                  SizedBox(height: 8),
                  LocationInput(onSelectedPosition: this._selectPosition),
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
            onPressed: isValidForm ? _submitForm : null,
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

  void _submitForm() {
    if (!isValidForm) {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false).addPlace(
      _titleController.text,
      _pickedImage!,
      _pickedPosition!,
    );
    Navigator.pop(context);
  }

  void _selectPosition(LatLng position) {
    setState(() {
      _pickedPosition = position;
    });
  }

  void _selectImage(File pickedImage) {
    setState(() {
      _pickedImage = pickedImage;
    });
  }

  bool get isValidForm => _titleController.text.isNotEmpty && _pickedImage != null && _pickedPosition != null;
}
