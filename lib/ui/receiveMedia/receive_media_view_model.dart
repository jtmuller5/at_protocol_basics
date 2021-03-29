import 'dart:io';
import 'dart:typed_data';

import 'package:at_commons/at_commons.dart';
import 'package:at_platform_files/app/at_constants.dart';
import 'package:at_platform_files/services/services.dart';
import 'package:stacked/stacked.dart';
import 'package:base2e15/base2e15.dart';
import 'package:video_player/video_player.dart';

class ReceiveMediaViewModel extends BaseViewModel {

  Uint8List pic;
  Uint8List video;

  bool mine = true;

  String readAtSign;

  VideoPlayerController videoPlayerController;

  void initialize() {
    readAtSign = atProtocolService.currentAtSign;
    notifyListeners();
  }

  void toggleReader(bool val) {
    mine = val;

    if (mine) {
      readAtSign = atProtocolService.currentAtSign;
    } else {
      readAtSign = AtConstants().atMap[atProtocolService.currentAtSign];
    }

    notifyListeners();
  }

  Future<void> readPic() async {
    AtKey atKey = AtKey();
    atKey.key = 'pic';

    // Get keys shared by the other sign
    if (!mine) {
      atKey.sharedBy = AtConstants().atMap[atProtocolService.currentAtSign];
    }

    String serverValue = await atProtocolService.get(atKey);

    print('Server value: ' + serverValue.toString());

    if (serverValue != null) {
      pic = Base2e15.decode(serverValue);
    }

    notifyListeners();
  }

  Future<void> readVideo() async {
    AtKey atKey = AtKey();
    atKey.key = 'video';

    // Get keys shared by the other sign
    if (!mine) {
      atKey.sharedBy = AtConstants().atMap[atProtocolService.currentAtSign];
    }

    String serverValue = await atProtocolService.get(atKey);

    if (serverValue != null) {

      File tempFile = await fileService.getFile(extension: 'mp4');

      video = Base2e15.decode(serverValue);

      print('received length: '+ video.length.toString());

      await tempFile.writeAsBytes(video);

      print('video bytes: ' + video.toString());

      videoPlayerController = VideoPlayerController.file(tempFile);

      await videoPlayerController.initialize();
      videoPlayerController.setLooping(true);
      videoPlayerController.play();
    }

    print('Server value: ' + serverValue.toString());

    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }

}