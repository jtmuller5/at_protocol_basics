import 'package:at_commons/at_commons.dart';
import 'package:at_protocol_basics/app/at_constants.dart';
import 'package:at_protocol_basics/services/services.dart';
import 'package:stacked/stacked.dart';

class ListenForUpdatesViewModel extends BaseViewModel {
  String one = '-';

  Future<void> initialize() async {
    String privateKey = await atProtocolService.getPrivateKey(atProtocolService.currentAtSign);
    atProtocolService.atClientImpl.startMonitor(privateKey, printResult);
  }

  void printResult(String val){
    print('Monitor result: ' + val.toString());
  }

  Future<void> listenToValue(String key) async {
    AtKey atKey = AtKey();
    atKey.key = key;

    // Get keys shared by the other sign

    atKey.sharedBy = AtConstants().atMap[atProtocolService.currentAtSign];

    String serverValue = await atProtocolService.get(atKey);

    print('Server value: ' + serverValue.toString());

    if (key == 'one') {
      one = serverValue ?? '-';
    }

    notifyListeners();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
