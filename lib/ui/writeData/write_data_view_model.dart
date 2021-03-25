import 'package:at_commons/at_commons.dart';
import 'package:at_protocol_basics/app/at_constants.dart';
import 'package:at_protocol_basics/services/services.dart';
import 'package:stacked/stacked.dart';

class WriteDataViewModel extends BaseViewModel {
  String one = '-';
  String two = '-';
  String three = '-';

  /// Should these values be shared with the other @ sign
  bool shareWith = false;

  void initialize() {}

  int counter = 1;

  Future<void> incrementCounter(String key) async {
    AtKey atKey = AtKey();
    atKey.key = key;

    /// Share with the other sign
    if(shareWith) {
      atKey.sharedWith = AtConstants().atMap[atProtocolService.currentAtSign];
    }

    counter++;

    await atProtocolService.atClientImpl.put(atKey, counter.toString());

    if (key == 'one') {
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
