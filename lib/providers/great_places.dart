import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_native_resources/models/place.dart';
import 'package:flutter_native_resources/utils/db_util.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items => [..._items];
  int get itemsCount => _items.length;
  Place itemByIndex(int index) => _items[index];

  void addPlace(String title, File image) {
    final newPlace = Place(
      id: Random().nextDouble().toString(),
      title: title,
      location: PlaceLocation(address: '', latitude: 0.0, longitude: 0.0),
      image: image,
    );

    _items.add(newPlace);
    DbUtil.insert(
      'places',
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
      },
    );
    notifyListeners();
  }
}
