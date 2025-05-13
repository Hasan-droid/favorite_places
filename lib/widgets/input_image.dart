import 'package:flutter/material.dart';
import "dart:io";
import "package:image_picker/image_picker.dart";

class InputImage extends StatefulWidget {
  const InputImage({super.key, required this.onSelectedImage});

  final void Function(File image) onSelectedImage;

  @override
  State<InputImage> createState() => _InputImageState();
}

class _InputImageState extends State<InputImage> {
  File? _image;

  void _takePicture() async {
    final imageDocument = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (imageDocument == null) return;

    setState(() {
      _image = File(imageDocument.path);
    });

    widget.onSelectedImage(_image!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ElevatedButton.icon(
      onPressed: _takePicture,
      icon: Icon(Icons.camera),
      label: Text("Upload Image"),
    );

    if (_image != null) {
      content = Image.file(
        _image!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }
    return GestureDetector(
      onTap: _takePicture,
      child: Container(
        height: 250,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          ),
        ),
        alignment: Alignment.center,
        child: content,
      ),
    );
  }
}
