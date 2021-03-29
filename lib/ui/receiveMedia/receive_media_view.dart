import 'package:at_platform_files/services/services.dart';
import 'package:at_platform_files/ui/receiveMedia/receive_media_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';

class ReceiveMediaView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ReceiveMediaViewModel>.reactive(
      viewModelBuilder: () => ReceiveMediaViewModel(),
      onModelReady: (model) {
        model.initialize();
      },
      builder: (context, model, child) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Receive Media'),
            ),
            body:  ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text('Signed In As: ' + atProtocolService.currentAtSign),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      child: Text('Read Pic'),
                      onPressed: () async {
                        await model.readPic();
                      },
                    ),
                  ],
                ),
                if(model.pic != null) Image.memory(model.pic),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      child: Text('Read Video'),
                      onPressed: () async {
                        await model.readVideo();
                      },
                    ),
                  ],
                ),
                if(model.video != null && model.videoPlayerController.value.isInitialized) Container(
                  height: 300,
                    width: systemService.screenWidth(context),
                    child: VideoPlayer(model.videoPlayerController)),
                SwitchListTile(
                    title: Text('Get ${model.readAtSign} values'),
                    value: model.mine,
                    onChanged: (value) {
                      model.toggleReader(value);
                    })
              ],
            )
        );
      },
    );
  }
}