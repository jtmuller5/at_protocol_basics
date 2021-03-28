import 'package:at_protocol_basics/ui/sendVideo/send_video_view_model.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'dart:math' as math;

class SendVideoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SendVideoViewModel>.reactive(
      viewModelBuilder: () => SendVideoViewModel(),
      onModelReady: (model) async {
        await model.initialize();
      },
      builder: (context, model, child) {
        if(model.controller != null && model.controller.value.isInitialized){
          var tmp = MediaQuery.of(context).size;
          var screenH = math.max(tmp.height, tmp.width);
          var screenW = math.min(tmp.height, tmp.width);
          tmp = model.controller.value.previewSize;
          var previewH = math.max(tmp.height, tmp.width);
          var previewW = math.min(tmp.height, tmp.width);
          var screenRatio = screenH / screenW;
          var previewRatio = previewH / previewW;
          return Scaffold(
            body:  Column(
              children: [
                Flexible(
                  child: OverflowBox(
                    maxHeight: screenRatio > previewRatio ? screenH : screenW / previewW * previewH,
                    maxWidth: screenRatio > previewRatio ? screenH / previewH * previewW : screenW,
                    child: CameraPreview(model.controller),
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(model.isRecording? Icons.pause:Icons.play_arrow),
              onPressed: (){
                model.isRecording? model.stopVideoRecording(context):model.startVideoRecording();
              },
            ),
          );
        } else{
          return Center(child: CircularProgressIndicator(),);
        }

      },
    );
  }
}