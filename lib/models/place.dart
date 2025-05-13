import 'package:uuid/uuid.dart';
import 'dart:io';

class Place {
  final String title;
  final String id;
  final File image;
  Place(this.title, this.image) : id = const Uuid().v4();
}
