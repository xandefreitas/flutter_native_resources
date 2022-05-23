import 'package:flutter/material.dart';
import 'package:flutter_native_resources/utils/location_util.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;
  bool _isLoading = false;

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
              : _isLoading
                  ? Center(child: CircularProgressIndicator())
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
              onPressed: () {
                setState(() {
                  _isLoading = true;
                  _getCurrentUserLocation();
                });
              },
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

  Future<void> _getCurrentUserLocation() async {
    final locationData = await Location().getLocation();

    final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(latitude: locationData.latitude!, longitude: locationData.longitude!);
    setState(() {
      _previewImageUrl = staticMapImageUrl;
      _isLoading = false;
    });
  }
}
