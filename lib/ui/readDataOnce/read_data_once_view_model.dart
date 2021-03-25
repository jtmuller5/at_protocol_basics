import 'package:at_commons/at_commons.dart';
import 'package:at_protocol_basics/app/at_constants.dart';
import 'package:at_protocol_basics/services/services.dart';
import 'package:stacked/stacked.dart';

class ReadDataOnceViewModel extends BaseViewModel {
  String one = '-';
  String two = '-';
  String three = '-';

  bool mine = true;

  String readAtSign;

  void initialize() {
    readAtSign = atProtocolService.currentAtSign;
    notifyListeners();
  }

  void toggleReader(bool val) {
    mine = val;

      if (mine) {
        readAtSign = atProtocolService.currentAtSign;
      } else {
        readAtSign = AtConstants().atMap[atProtocolService.currentAtSign];
      }

    notifyListeners();
  }

  Future<void> readCounterValue(String key) async {
    AtKey atKey = AtKey();
    atKey.key = key;

    // Get keys shared by the other sign
    if (!mine) {
      atKey.sharedBy = AtConstants().atMap[atProtocolService.currentAtSign];
    }

    String serverValue = await atProtocolService.get(atKey);

    print('Server value: ' + serverValue.toString());

    if (key == 'one') {
      one = serverValue ?? '-';
    } else if (key == 'two') {
      two = serverValue ?? '-';
    } else if (key == 'three') {
      three = serverValue ?? '-';
    }

    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
