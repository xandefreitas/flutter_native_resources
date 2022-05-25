import 'package:flutter/material.dart';
import 'package:flutter_native_resources/providers/great_places.dart';
import 'package:flutter_native_resources/screens/place_detail_screen.dart';
import 'package:flutter_native_resources/screens/place_form_screen.dart';
import 'package:flutter_native_resources/utils/app_routes.dart';
import 'package:provider/provider.dart';

import 'screens/places_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return ChangeNotifierProvider(
      create: (ctx) => GreatPlaces(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            primary: Colors.deepPurpleAccent,
            secondary: Colors.deepPurple,
          ),
        ),
        home: PlacesListScreen(),
        routes: {
          AppRoutes.PLACE_FORM: (ctx) => PlaceFormScreen(),
          AppRoutes.PLACE_DETAIL: (ctx) => PlaceDetailScreen(),
        },
      ),
    );
  }
}
