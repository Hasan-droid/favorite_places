import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';

class PlacesDetails extends StatelessWidget {
  Place place;
  PlacesDetails({super.key, required this.place});

  String get LocationImage {
    final lat = place.location.latitude;
    final long = place.location.latitude;

    //here i should return a string from google maps apis
    return "https://static.wikia.nocookie.net/marvelcrossroads/images/2/29/Man-of-steel-logo.png/revision/latest?cb=20160417001211";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(place.title)),
      body: Stack(
        children: [
          Image.file(
            place.image,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(LocationImage),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black54],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Text(
                    place.location.address,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
