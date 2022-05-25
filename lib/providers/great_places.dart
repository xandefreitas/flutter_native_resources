import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_native_resources/models/place.dart';
import 'package:flutter_native_resources/utils/db_util.dart';
import 'package:flutter_native_resources/utils/location_util.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items => [..._items];
  int get itemsCount => _items.length;
  Place itemByIndex(int index) => _items[index];

  void addPlace(
    String title,
    File image,
    LatLng position,
  ) async {
    String address = await LocationUtil.getAddressFrom(position);
    final newPlace = Place(
      id: Random().nextDouble().toString(),
      title: title,
      location: PlaceLocation(
        address: address,
        latitude: position.latitude,
        longitude: position.longitude,
      ),
      image: image,
    );

    _items.add(newPlace);
    DbUtil.insert(
      'places',
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
        'latitude': position.latitude,
        'longitude': position.longitude,
        'address': address,
      },
    );
    notifyListeners();
  }

  Future<void> loadPlaces() async {
    final dataList = await DbUtil.getData('places');
    _items = dataList
        .map((e) => Place(
              id: e['id'],
              title: e['title'],
              location: PlaceLocation(
                address: e['address'],
                latitude: e['latitude'],
                longitude: e['longitude'],
              ),
              image: File(e['image']),
            ))
        .toList();
    notifyListeners();
  }
}
