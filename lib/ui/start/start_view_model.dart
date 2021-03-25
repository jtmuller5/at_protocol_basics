import 'package:at_protocol_basics/services/services.dart';
import 'package:stacked/stacked.dart';

class StartViewModel extends BaseViewModel {
  Future<void> initialize() async {
    await atProtocolService.onboard();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
