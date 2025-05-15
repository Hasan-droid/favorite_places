import 'package:favorite_places/main.dart';
import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/providers/user_places.dart';
import 'package:favorite_places/screens/new_place.dart';
import 'package:favorite_places/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class favoritePlacesScreen extends ConsumerStatefulWidget {
  favoritePlacesScreen({super.key});

  @override
  ConsumerState<favoritePlacesScreen> createState() {
    // TODO: implement createElement
    return _favoritePlacesScreen();
  }
}

class _favoritePlacesScreen extends ConsumerState<favoritePlacesScreen> {
  late Future<void> _placesFuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _placesFuture = ref.read(UserPlacesProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder(
        future: _placesFuture,
        builder:
            (context, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? Center(child: CircularProgressIndicator())
                    : PlacesList(places: places),
      ),
    );
  }
}
