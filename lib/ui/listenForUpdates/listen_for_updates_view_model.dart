import 'package:at_commons/at_commons.dart';
import 'package:at_platform_files/app/at_constants.dart';
import 'package:at_platform_files/services/services.dart';
import 'package:stacked/stacked.dart';

class ListenForUpdatesViewModel extends BaseViewModel {
  String one = '-';

  Future<void> initialize() async {
    String privateKey = await atProtocolService.getPrivateKey(atProtocolService.currentAtSign);
    try {
      atProtocolService.atClientImpl.startMonitor(privateKey, printResult);
    } on ConnectionInvalidException catch (e){
      print('connection error: '+ e.toString());
    }
  }

  Future<void> printResult(String val) async {
    print('Monitor result: ' + val.toString());
    getNewValue('one');
  }

  Future<void> getNewValue(String key) async {
    AtKey atKey = AtKey();
    atKey.key = key;

    // Get keys shared by the other sign
    atKey.sharedBy = AtConstants().atMap[atProtocolService.currentAtSign];

    try {
      String serverValue = await atProtocolService.get(atKey);

      print('Server value: ' + serverValue.toString());

      one = serverValue ?? '-';
    } on UnAuthenticatedException catch (e){
      print('auth error: '+ e.message);
    }

    notifyListeners();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
