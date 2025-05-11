import 'package:favorite_places/main.dart';
import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/new_place.dart';
import 'package:favorite_places/widgets/places_list.dart';
import 'package:flutter/material.dart';

class favoritePlacesScreen extends StatelessWidget {
  favoritePlacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Place> favoritePlaces = [Place("Damascus"), Place("Jordan")];

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
      body: PlacesList(places: favoritePlaces),
    );
  }
}
