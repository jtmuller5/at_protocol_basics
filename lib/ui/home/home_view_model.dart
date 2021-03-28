import 'package:at_protocol_basics/services/services.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  Future<void> initialize() async {
    if (atProtocolService.atClientImpl == null) {
      await atProtocolService.onboard(atsign: atProtocolService.currentAtSign);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
