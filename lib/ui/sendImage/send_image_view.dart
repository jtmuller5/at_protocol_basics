import 'package:at_protocol_basics/app/at_constants.dart';
import 'package:at_protocol_basics/services/services.dart';
import 'package:at_protocol_basics/ui/sendImage/send_image_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SendImageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SendImageViewModel>.reactive(
      viewModelBuilder: () => SendImageViewModel(),
      onModelReady: (model) {
        // model.initialize();
      },
      builder: (context, model, child) {
        return Scaffold(
         appBar: AppBar(
            title: Text('Send Image'),
          ),
            body: Center(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Signed In As: ' + atProtocolService.currentAtSign),
                  ),
                  RaisedButton(
                      child: Text('Select Image'),
                      onPressed: () async {
                    await model.selectImage();
                  }),
                  if(model.image != null)RaisedButton(
                      child: Text('Send Image'),
                      onPressed: () async {
                        await model.sendImage();
                      }),
                  CheckboxListTile(
                    title: Text('Share with ${AtConstants().atMap[atProtocolService.currentAtSign]}?'),
                    value: model.shareWith,
                    onChanged: (value) {
                      model.toggleShare(value);
                    },
                  )
                ],
              ),
            )
        );
      },
    );
  }
}