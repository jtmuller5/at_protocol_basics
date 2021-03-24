import 'package:at_protocol_basics/ui/start/start_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class StartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartViewModel>.reactive(
      viewModelBuilder: () => StartViewModel(),
      onModelReady: (model) {
        // model.initialize();
      },
      builder: (context, model, child) {
        return Scaffold(
         appBar: AppBar(
            title: Text('Title'),
          ),
            body: Column(
              children: [
                Container()
              ],
            )
        );
      },
    );
  }
}