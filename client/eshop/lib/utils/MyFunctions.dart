// ignore_for_file: deprecated_member_use
import 'dart:convert';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

Future<String?> _openGallery() async {
  String base64Image;
  final picker = ImagePicker();
  final pickedFile = await picker.getImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    final imageFile = await pickedFile.readAsBytes();
    base64Image = base64Encode(imageFile);
    return base64Image;
  } else {
    return null;
  }
}

//Funcion para decodificar la imagen
Uint8List _decodeImageFromBase64(String base64String) {
  Uint8List bytes = base64Decode(base64String);
  return bytes;
}
