import 'package:at_platform_files/services/services.dart';
import 'package:at_platform_files/ui/readDataOnce/read_data_once_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ReadDataOnceView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ReadDataOnceViewModel>.reactive(
      viewModelBuilder: () => ReadDataOnceViewModel(),
      onModelReady: (model) {
        model.initialize();
      },
      builder: (context, model, child) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Read Data Once'),
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
                        child: Text('Read Data One'),
                        onPressed: () async {
                          await model.readCounterValue('one');
                        },
                      ),
                      Text(model.one)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RaisedButton(
                        child: Text('Read Data Two'),
                        onPressed: () async {
                          await model.readCounterValue('two');
                        },
                      ),
                      Text(model.two)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RaisedButton(
                        child: Text('Read Data Three'),
                        onPressed: () async {
                          await model.readCounterValue('three');
                        },
                      ),
                      Text(model.three)
                    ],
                  ),
                  SwitchListTile(
                    title: Text('Get ${model.readAtSign} values'),
                      value: model.mine,
                      onChanged: (value) {
                        model.toggleReader(value);
                      })
                ],
              ),
            ));
      },
    );
  }
}
