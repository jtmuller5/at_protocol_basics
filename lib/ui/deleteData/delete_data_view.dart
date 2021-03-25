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