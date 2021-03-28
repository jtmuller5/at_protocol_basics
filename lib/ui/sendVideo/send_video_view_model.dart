import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:at_commons/at_commons.dart';
import 'package:at_protocol_basics/app/at_constants.dart';
import 'package:at_protocol_basics/services/services.dart';
import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:stacked/stacked.dart';
import 'package:base2e15/base2e15.dart';

class SendVideoViewModel extends BaseViewModel with WidgetsBindingObserver {
  List<CameraDescription> cameras;

  CameraController controller;

  XFile imageFile; // Placeholder for current image from camera
  XFile videoFile; // Placeholder for current video

  File sendVideo;

  bool get isRecording {
    return controller.value.isRecordingVideo;
  }

  Future<void> initialize() async {
    sendVideo = await fileService.getFile(extension: 'mp4');
    bool videoFolderExists = await fileService.createFolders(['videos']);

    cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      notifyListeners();
    });

    notifyListeners();
  }

  Future<void> startVideoRecording() async {
    if (!controller.value.isInitialized) {
      toastService.showToast('Error: select a camera first.');
      return;
    }

    if (controller.value.isRecordingVideo) {
      // A recording is already started, do nothing.
      return;
    }

    try {
      String fixedSavePath = await fileService.getSavePath(video: true);
      videoFile = XFile(fixedSavePath); // Save reference to temp file
      await controller.startVideoRecording();
    } on CameraException catch (e) {
      print('Camera Exception: ' + e.toString());
      return;
    }

    notifyListeners();
  }

  /// Stop the video recording and ask the user where they would like to save the new video
  /// Options will be 'In the app' and 'To gallery'
  Future<void> stopVideoRecording(BuildContext context) async {
    if (!controller.value.isRecordingVideo) {
      return null;
    }

    try {
      videoFile = await controller.stopVideoRecording();

      // 'app' or 'gallery'
      String option = await showDialog(
            context: context,
            builder: (context) => SimpleDialog(
              title: Text('Where would you like to save this video?'),
              children: [
                Center(
                  child: OutlinedButton(
                    onPressed: () {
                      ExtendedNavigator.root.pop('gallery');
                    },
                    child: Text('To Gallery'),
                  ),
                ),
                Center(
                  child: OutlinedButton(
                    onPressed: () {
                      ExtendedNavigator.root.pop('app');
                    },
                    child: Text('To App Directory'),
                  ),
                ),
                Center(
                  child: OutlinedButton(
                    onPressed: () {
                      ExtendedNavigator.root.pop('none');
                    },
                    child: Text('Cancel Save'),
                  ),
                )
              ],
            ),
          ) ??
          'none';

      print('Selected option: ' + option);
      await handleSaveOption(option);

      return;
    } on CameraException catch (e) {
      print('Camera Exception: ' + e.toString());
      notifyListeners();
      return;
    }
  }

  bool shareWith = false;

  void toggleShare(bool val){
    shareWith = val;
    notifyListeners();
  }

  Future<void> handleSaveOption(String option) async {
    switch (option) {
      case 'gallery':
        // Save the video to the user's device gallery
        await GallerySaver.saveVideo(videoFile.path);

        toastService.showToast('Video saved!');

        notifyListeners();
        break;

      case 'app':
        // 1 - Get the raw bytes from the video
        Stream<Uint8List> inputStream = videoFile.openRead();

        Uint8List before = await videoFile.readAsBytes();
        print('before: ' + before.length.toString());

        print('input stream: ' + inputStream.toString());

        // 2 - Encrypt those using this user's encryptor
        await inputStream.listen((event) async {
          // 3 - Write the encrypted string to local storage

          await sendVideo.writeAsBytes(Uint8List.fromList(event),mode: FileMode.append);
          notifyListeners();
        });

        AtKey atKey = AtKey();
        atKey.key = 'video';

        /// Share with the other sign
        if (shareWith) {
          atKey.sharedWith = AtConstants().atMap[atProtocolService.currentAtSign];
        }

        Uint8List videoBytes = sendVideo.readAsBytesSync();

        print('sent length: '+ videoBytes.length.toString());

        String encodedVideo= Base2e15.encode(
          videoBytes,
        );

        await atProtocolService.atClientImpl.put(atKey, encodedVideo);

        print('Video Sent!');

        await toastService.showToast('Video saved!');
        notifyListeners();

        break;
      case 'none':
        // User doesn't want to save video
        break;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (controller == null || !controller.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (controller != null) {
        // onNewCameraSelected(controller.description);
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
