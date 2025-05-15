import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:riverpod/riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

import 'package:favorite_places/models/place.dart';

//create class that has methods to manipulate users data
//List<Place> data to be manipulated
class UserPlacesNotifier extends StateNotifier<List<Place>> {
  //constructor
  //const [] is the initial state
  //const for mutation
  UserPlacesNotifier() : super(const []);

  void addPlace(String title, File image, PlaceLocation pickedLocation) async {
    //the path in device the app want to store in it
    final appDir = await syspath.getApplicationDocumentsDirectory();

    final fileName = path.basename(image.path);

    //copy the image to persistent location
    //image were stored in a location ${image.path} where it was in cache , everything
    //on cache will be deleted , this why i used the "copy" method to move the image
    //to safe location not in the cache
    final copiedImage = await image.copy('${appDir.path}/$fileName');

    Place newPlace = Place(title, image, pickedLocation);

    final dbPath = await sql.getDatabasesPath();

    final db = await sql.openDatabase(
      path.join(dbPath, "places.db"),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE user_places (id TEXT PRIMARY KEY,title TEXT NOT NULL,image TEXT NOT NULL,latitude REAL NOT NULL,longitude REAL NOT NULL, address TEXT NOT NULL);",
        );
      },
      version: 1,
    );

    db.insert("user_places", {
      'id': newPlace.id, // Assuming Place has an id field
      'title': newPlace.title,
      'image': copiedImage.path, // Path to the copied image
      'latitude': pickedLocation.latitude,
      'longitude': pickedLocation.longitude,
      'address': pickedLocation.address,
    });

    //state enhirted from StateNotifier
    //mutation is a must , this way i create new copy of list and manipulated it
    state = [newPlace, ...state];
  }
}

//Notifier Provider
final UserPlacesProvider = StateNotifierProvider((ref) => UserPlacesNotifier());
