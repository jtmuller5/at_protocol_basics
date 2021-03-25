import 'package:at_protocol_basics/app/at_constants.dart';
import 'package:at_protocol_basics/services/services.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'delete_data_view_model.dart';

class DeleteDataView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DeleteDataViewModel>.reactive(
      viewModelBuilder: () => DeleteDataViewModel(),
      onModelReady: (model) {
        // model.initialize();
      },
      builder: (context, model, child) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Delete Data'),
            ),
            body: Center(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Signed In As: ' + atProtocolService.currentAtSign),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RaisedButton(
                          child: Text('One'),
                          onPressed: () async {
                            await model.deleteKey('one');
                          }),
                      Text(model.one)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RaisedButton(
                          child: Text('Two'),
                          onPressed: () async {
                            await model.deleteKey('two');
                          }),
                      Text(model.two)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RaisedButton(
                          child: Text('Three'),
                          onPressed: () async {
                            await model.deleteKey('three');
                          }),
                      Text(model.three)
                    ],
                  ),
                  CheckboxListTile(
                    title: Text('Delete for ${AtConstants().atMap[atProtocolService.currentAtSign]}?'),
                    value: model.sharedWith,
                    onChanged: (value) {
                      model.toggleShared(value);
                    },
                  )
                ],
              ),
            ));
      },
    );
  }
}
