import 'package:at_protocol_basics/app/at_constants.dart';
import 'package:at_protocol_basics/services/services.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'listen_for_updates_view_model.dart';

class ListenForUpdatesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ListenForUpdatesViewModel>.reactive(
      viewModelBuilder: () => ListenForUpdatesViewModel(),
      onModelReady: (model) async {
        await model.initialize();
      },
      builder: (context, model, child) {
        return Scaffold(
         appBar: AppBar(
            title: Text('Listen for Updates'),
          ),
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Signed In As: ' + atProtocolService.currentAtSign),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 36.0),
                    child: Text('Last data sent by ${AtConstants().atMap[atProtocolService.currentAtSign]}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600
                    ),),
                  ),
                  Text(model.one,
                  style: TextStyle(
                    fontSize: 50
                  ),),
                ],
              ),
            )
        );
      },
    );
  }
}