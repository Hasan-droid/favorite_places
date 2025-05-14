import 'package:uuid/uuid.dart';
import 'dart:io';

class PlaceLocation {
  final double longitude;
  final double latitude;
  final String address;

  PlaceLocation(this.longitude, this.latitude, this.address);
}

class Place {
  final String title;
  final String id;
  final File image;
  // final PlaceLocation location;
  Place(this.title, this.image) : id = const Uuid().v4();
}
