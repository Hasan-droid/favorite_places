import 'dart:io';

import 'package:favorite_places/main.dart';
import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/providers/user_places.dart';
import 'package:favorite_places/widgets/input_image.dart';
import 'package:favorite_places/widgets/input_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewPlace extends ConsumerStatefulWidget {
  const NewPlace({super.key});

  @override
  ConsumerState<NewPlace> createState() => _NewPlaceState();
}

class _NewPlaceState extends ConsumerState<NewPlace> {
  final _inputTextController = TextEditingController();
  PlaceLocation? _placeLocation;
  File? _image;

  void savePlace() {
    if (_inputTextController.text.isEmpty ||
        _image == null ||
        _placeLocation == null)
      return;

    ref
        .read(UserPlacesProvider.notifier)
        .addPlace(_inputTextController.text, _image!, _placeLocation!);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add New Place")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: _inputTextController,
              decoration: InputDecoration(labelText: "new place"),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            SizedBox(height: 12),
            InputImage(
              onSelectedImage: (image) {
                _image = image;
              },
            ),
            SizedBox(height: 12),
            InputLocation(
              onSelectLocation: (location) {
                _placeLocation = location;
              },
            ),
            SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: savePlace,
              icon: Icon(Icons.add),
              label: Text("NewPlace"),
            ),
          ],
        ),
      ),
    );
  }
}
