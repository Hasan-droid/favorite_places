import 'package:favorite_places/models/place.dart';
import 'package:riverpod/riverpod.dart';

//create class that has methods to manipulate users data
//List<Place> data to be manipulated
class UserPlacesNotifier extends StateNotifier<List<Place>> {
  //constructor
  //const [] is the initial state
  //const for mutation
  UserPlacesNotifier() : super(const []);

  void addPlace(String title) {
    Place newPlace = Place(title);

    //state enhirted from StateNotifier
    //mutation is a must , this way i create new copy of list and manipulated it
    state = [newPlace, ...state];
  }
}

//Notifier Provider
final UserPlacesProvider = StateNotifierProvider((ref) => UserPlacesNotifier());
