import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class InputLocation extends StatefulWidget {
  final void Function(PlaceLocation pickedLocation) onSelectLocation;
  const InputLocation({super.key, required this.onSelectLocation});

  @override
  State<InputLocation> createState() => _InputLocationState();
}

class _InputLocationState extends State<InputLocation> {
  bool isGetLocation = false;
  PlaceLocation? _pickedLocation;

  String get LocationImage {
    if (_pickedLocation == null) {
      return 'No location was obtained';
    }

    final lat = _pickedLocation!.latitude;
    final long = _pickedLocation!.latitude;

    //here i should return a string from google maps apis
    return "https://static.wikia.nocookie.net/marvelcrossroads/images/2/29/Man-of-steel-logo.png/revision/latest?cb=20160417001211";
  }

  setLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState(() {
      isGetLocation = true;
    });
    locationData = await location.getLocation();

    if (locationData.latitude == null || locationData.longitude == null) return;

    setState(() {
      _pickedLocation = PlaceLocation(
        locationData.longitude!,
        locationData.latitude!,
        "address in null because i don't care about google apis",
      );
      isGetLocation = false;
    });

    widget.onSelectLocation(_pickedLocation!);
  }

  @override
  Widget build(BuildContext context) {
    Widget previewLocation = Text(
      "No Location Selected Yet",
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        color: Theme.of(context).colorScheme.onBackground,
      ),
    );

    if (_pickedLocation != null) {
      previewLocation = Image.network(LocationImage);
    }
    if (isGetLocation) {
      previewLocation = Center(child: CircularProgressIndicator());
    }
    return Column(
      children: [
        Container(
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            ),
          ),
          alignment: Alignment.center,
          child: previewLocation,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.map),
              label: Text("Select a location"),
            ),
            TextButton.icon(
              onPressed: setLocation,
              icon: Icon(Icons.pin_drop_outlined),
              label: Text("Get current location"),
            ),
          ],
        ),
      ],
    );
  }
}
