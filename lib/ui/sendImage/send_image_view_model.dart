import 'dart:io';

import 'package:at_commons/at_commons.dart';
import 'package:at_platform_files/app/at_constants.dart';
import 'package:at_platform_files/services/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:base2e15/base2e15.dart';

class SendImageViewModel extends BaseViewModel {
  File image;

  bool shareWith = false;

  void initialize() {}

  Future<void> selectImage() async {
    image = await mediaService.selectImage(source: ImageSource.camera);

    notifyListeners();
  }

  Future<void> sendImage() async {
    AtKey atKey = AtKey();
    atKey.key = 'pic';

    /// Share with the other sign
    if (shareWith) {
      atKey.sharedWith = AtConstants().atMap[atProtocolService.currentAtSign];
    }


      String encodedImage = Base2e15.encode(
        image.readAsBytesSync(),
      );

      print('encoded image: '+ encodedImage.toString());

      await atProtocolService.atClientImpl.put(atKey, encodedImage);


      print('image sent');
    notifyListeners();
  }

  void toggleShare(bool val) {
    shareWith = val;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}