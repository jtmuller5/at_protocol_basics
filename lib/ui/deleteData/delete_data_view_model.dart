import 'package:at_commons/at_commons.dart';
import 'package:at_protocol_basics/app/at_constants.dart';
import 'package:at_protocol_basics/services/services.dart';
import 'package:stacked/stacked.dart';

class DeleteDataViewModel extends BaseViewModel{

  String one = '-';
  String two = '-';
  String three = '-';

  bool sharedWith = false;

  void initialize(){

  }

  void toggleShared(bool val){
    sharedWith = val;
    notifyListeners();
  }

  Future<void> deleteKey(String key) async {
    AtKey atKey = AtKey();
    atKey.key = key;

    if(sharedWith){
      atKey.sharedWith = AtConstants().atMap[atProtocolService.currentAtSign];
    }

    await atProtocolService.atClientImpl.delete(atKey);

    if (key == 'one') {
      one = 'DELETED';
    } else if (key == 'two') {
      two = 'DELETED';
    } else if (key == 'three') {
      three = 'DELETED';
    }

    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }

}