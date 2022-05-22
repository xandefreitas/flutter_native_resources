import 'package:flutter/material.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _previewImageUrl == null
              ? Text('Localização não informada!')
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {},
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                  ),
                  SizedBox(width: 8),
                  Text('Localização Atual')
                ],
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Row(
                children: [
                  Icon(
                    Icons.map,
                  ),
                  SizedBox(width: 8),
                  Text('Selecione no Mapa'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
