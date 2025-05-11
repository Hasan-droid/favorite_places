import 'package:favorite_places/main.dart';
import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/providers/user_places.dart';
import 'package:favorite_places/screens/new_place.dart';
import 'package:favorite_places/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class favoritePlacesScreen extends ConsumerWidget {
  favoritePlacesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(UserPlacesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Places"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return NewPlace();
                  },
                ),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: PlacesList(places: places),
    );
  }
}
