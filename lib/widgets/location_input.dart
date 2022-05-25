import 'package:flutter/material.dart';
import 'package:flutter_native_resources/screens/map_screen.dart';
import 'package:flutter_native_resources/utils/location_util.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../models/place.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectedPosition;
  const LocationInput({Key? key, required this.onSelectedPosition}) : super(key: key);

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
                _getCurrentUserLocation();
                setState(() {
                  _isLoading = true;
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
              onPressed: () {
                _selectOnMap();
                setState(() {
                  _isLoading = true;
                });
              },
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
    try {
      final locationData = await Location().getLocation();

      showhPreviewImage(locationData.latitude!, locationData.longitude!);
      widget.onSelectedPosition(LatLng(locationData.latitude!, locationData.longitude!));
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      return;
    }
  }

  void showhPreviewImage(double latitude, double longitude) {
    final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(latitude: latitude, longitude: longitude);
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _selectOnMap() async {
    final selectedPosition = await Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: ((_) => MapScreen(
              initialLocation: PlaceLocation(
                latitude: 37.419857,
                longitude: -122.078827,
                address: '',
              ),
            )),
      ),
    );
    if (selectedPosition == null) {
      return;
    }

    showhPreviewImage(selectedPosition.latitude, selectedPosition.longitude);

    widget.onSelectedPosition(selectedPosition);
    setState(() {
      _isLoading = false;
    });
  }
}
