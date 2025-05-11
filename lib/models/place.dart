import 'package:uuid/uuid.dart';

class Place {
  final String title;
  final String id;
  Place(this.title) : id = const Uuid().v4();
}
