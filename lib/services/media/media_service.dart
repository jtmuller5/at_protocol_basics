import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@injectable
class MediaService {
  final picker = ImagePicker();

  /// Select an image from the user's device
  Future<File> selectImage({ImageSource source = ImageSource.gallery}) async {
    final pickedFile = await picker.getImage(source: source);

    if(pickedFile!= null) {
      return File(pickedFile.path);
    } else {
      return null;
    }
  }
}