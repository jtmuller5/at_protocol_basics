import 'package:at_protocol_basics/app/at_constants.dart';
import 'package:at_protocol_basics/services/services.dart';
import 'package:at_protocol_basics/ui/writeData/write_data_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class WriteDataView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WriteDataViewModel>.reactive(
      viewModelBuilder: () => WriteDataViewModel(),
      onModelReady: (model) {
        // model.initialize();
      },
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Write Data'),
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
                          await model.incrementCounter('one');
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
                          await model.incrementCounter('two');
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
                          await model.incrementCounter('three');
                        }),
                    Text(model.three)
                  ],
                ),
                CheckboxListTile(
                  title: Text('Share with ${AtConstants().atMap[atProtocolService.currentAtSign]}?'),
                  value: model.shareWith,
                  onChanged: (value) {
                    model.toggleShare(value);
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
