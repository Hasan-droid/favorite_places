import 'dart:io';
import 'package:riverpod/riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;

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

    print('temporary location: ${image.path}');
    print('persist location: $appDir');

    Place newPlace = Place(title, image, pickedLocation);

    //state enhirted from StateNotifier
    //mutation is a must , this way i create new copy of list and manipulated it
    state = [newPlace, ...state];
  }
}

//Notifier Provider
final UserPlacesProvider = StateNotifierProvider((ref) => UserPlacesNotifier());
