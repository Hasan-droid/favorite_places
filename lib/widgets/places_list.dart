import 'package:flutter/material.dart';
import "package:favorite_places/models/place.dart";

class PlacesList extends StatelessWidget {
  List<Place> places;
  PlacesList({super.key, required this.places});

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Text(
        "No favorite places",
        style: Theme.of(context).textTheme.bodyLarge!.merge(
          TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      ),
    );
    if (places.isNotEmpty) {
      content = Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: places.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    places[index].title,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    }

    return content;
  }
}
