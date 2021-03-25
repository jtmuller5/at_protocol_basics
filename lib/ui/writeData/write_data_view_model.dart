import 'dart:typed_data';

import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:at_commons/at_builders.dart';
import 'package:at_commons/at_commons.dart';
import 'package:at_protocol_basics/app/at_constants.dart';
import 'package:at_protocol_basics/services/services.dart';
import 'package:stacked/stacked.dart';
import 'package:base2e15/base2e15.dart';

class WriteDataViewModel extends BaseViewModel {
  String one = '-';
  String two = '-';
  String three = '-';

  /// Should these values be shared with the other @ sign
  bool shareWith = false;

  Future<void> initialize() async {

  }

  int counter = 1;

  Future<void> incrementCounter(String key) async {
    AtKey atKey = AtKey();
    atKey.key = key;

    /// Share with the other sign
    if(shareWith) {
      atKey.sharedWith = AtConstants().atMap[atProtocolService.currentAtSign];
      //atKey.sharedBy = atProtocolService.currentAtSign;
    }

    counter++;

    await atProtocolService.atClientImpl.put(atKey, counter.toString());


    if (key == 'one') {
      print('atKey: '+ atKey.toString());

      /// This line enables this @sign to notify another @sign
      try {
       // atKey.key = 'one${atProtocolService.currentAtSign}';
        await atProtocolService.atClientImpl.notify(atKey, counter.toString(), OperationEnum.update);
      } on AtClientException catch (e) {
        print('notify exception: ' + e.errorMessage);
      }

     /* /// Start notification stream to their @ Sign
      var builder = NotifyVerbBuilder()
        ..atKey = 'one${atProtocolService.currentAtSign}'
        ..operation = OperationEnum.update
        ..value = '1'
        ..sharedWith = AtConstants().atMap[atProtocolService.currentAtSign];

      print('builder: '+ builder.buildCommand());

      String result = await atProtocolService.atClientImpl.getLocalSecondary().executeVerb(builder);

      print('Result: '+ result.toString());*/

      one = counter.toString();
    } else if (key == 'two') {
      two = counter.toString();
    } else if (key == 'three') {
      three = counter.toString();
    }

    notifyListeners();
  }

  void toggleShare(bool val){
    shareWith = val;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
