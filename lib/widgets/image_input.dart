import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class ImageInput extends StatefulWidget {
  final Function onSelectImage;
  ImageInput({
    required this.onSelectImage,
  });

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future<void> _takepicture() async {
    final picker = ImagePicker();
    final imageFIle = await picker.pickImage(
        source: ImageSource.camera, maxWidth: 600);

    if (imageFIle == null) {
      return;
    }
    setState(() {
      _storedImage = File(imageFIle.path);
    });

    final appDir = await getApplicationDocumentsDirectory();
    final filename = path.basename(imageFIle.path);
    final saveimage = await File(imageFIle.path).copy('${appDir.path}/$filename');

    print(saveimage);
    widget.onSelectImage(saveimage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 2,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storedImage != null
              ? Image.file(_storedImage as File,
                  fit: BoxFit.cover, width: double.infinity)
              : Text('No Image taken'),
          alignment: Alignment.center,
        ),
        SizedBox(width: 10),
        Expanded(
            child: TextButton.icon(
                onPressed: () {
                  _takepicture();
                },
                icon: Icon(Icons.camera),
                label: Text(
                  'Take a picture',
                  textAlign: TextAlign.center,
                ))),
      ],
    );
  }
}
