import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';

class PlacesDetails extends StatelessWidget {
  Place place;
  PlacesDetails({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(place.title)),
      body: Center(
        child: Text(
          place.title,
          style: Theme.of(context).textTheme.bodyLarge!.merge(
            TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ),
      ),
    );
  }
}
