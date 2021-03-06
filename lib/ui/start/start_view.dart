import 'package:at_platform_files/app/app_router.gr.dart';
import 'package:at_platform_files/services/services.dart';
import 'package:at_platform_files/ui/home/home_view.dart';
import 'package:at_platform_files/ui/start/start_view_model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class StartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartViewModel>.reactive(
      viewModelBuilder: () => StartViewModel(),
      onModelReady: (model) async {
        await model.initialize();
      },
      builder: (context, model, child) {
        return Scaffold(
            body: model.isBusy?Center(
              child: CircularProgressIndicator(),
            ):Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text('I have an @Sign'),
                onPressed: () async {
                  /// Need to reinitialize these if the user recently logged out
                  if (atProtocolService.atClientService == null) {
                    await atProtocolService.getInstance();
                  }

                  await ExtendedNavigator.of(context).push(
                    Routes.scanQrScreen,
                    arguments: ScanQrScreenArguments(
                      nextScreen: HomeView(),
                      atClientServiceInstance: atProtocolService.atClientService,
                      atClientPreference: atProtocolService.atClientPreference,
                    ),
                  );
                },
              ),
              ElevatedButton(
                child: Text('I need an @Sign'),
                onPressed: () {
                  systemService.launchURL('https://atsign.com/get-an-sign/');
                },
              )
            ],
          ),
        ));
      },
    );
  }
}
