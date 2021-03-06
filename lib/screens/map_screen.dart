import 'package:flutter/material.dart';
import 'package:flutter_native_resources/models/place.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isReadOnly;
  const MapScreen({
    Key? key,
    required this.initialLocation,
    this.isReadOnly = false,
  }) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecione...'),
        actions: [
          if (!widget.isReadOnly)
            IconButton(
              onPressed: _pickedPosition == null ? null : () => Navigator.pop(context, _pickedPosition),
              icon: Icon(Icons.check),
            ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.initialLocation.latitude, widget.initialLocation.longitude),
          zoom: 13,
        ),
        onTap: widget.isReadOnly ? null : _selectPosition,
        markers: (_pickedPosition == null && !widget.isReadOnly)
            ? {}
            : {
                Marker(
                  markerId: MarkerId('p1'),
                  position: _pickedPosition ?? widget.initialLocation.toLatLng(),
                ),
              },
      ),
    );
  }

  void _selectPosition(LatLng position) {
    setState(() {
      _pickedPosition = position;
    });
  }
}
