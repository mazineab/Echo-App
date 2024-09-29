import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final ImagePicker _imagePicker = ImagePicker();

  Future<File?> chooseImageFromGallery() async {
    var file = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (file != null) return File(file.path);
    return null;
  }

  Future<File?> chooseImageFromCamera() async {
    var file = await _imagePicker.pickImage(source: ImageSource.camera);
    if (file != null) return File(file.path);
    return null;
  }
}
