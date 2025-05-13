import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  bool isGetLocation = false;
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

    setState(() {
      isGetLocation = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget previewLocation = Text(
      "No Location Selected Yet",
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        color: Theme.of(context).colorScheme.onBackground,
      ),
    );
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
