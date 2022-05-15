import 'package:flutter/material.dart';
import 'package:flutter_native_resources/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items => [..._items];
  int get itemsCount => _items.length;
  Place itemByIndex(int index) => _items[index];
}
