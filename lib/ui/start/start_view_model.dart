import 'package:at_protocol_basics/app/app_router.gr.dart';
import 'package:at_protocol_basics/services/services.dart';
import 'package:auto_route/auto_route.dart';
import 'package:stacked/stacked.dart';

class StartViewModel extends BaseViewModel {
  Future<void> initialize() async {
    setBusy(true);
    print('before onboarding');
    print('First At Sign: '+ atProtocolService?.atSignList?.first.toString());
    bool authenticated = await atProtocolService.onboard(atsign: atProtocolService?.atSignList?.first);

    print('auth: '+ authenticated.toString());

    if(authenticated){
      await ExtendedNavigator.root.pushAndRemoveUntil(Routes.homeView, (route) => false);
    }

   // await ExtendedNavigator.root.pushAndRemoveUntil(Routes.homeView, (route) => false);

    setBusy(false);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
