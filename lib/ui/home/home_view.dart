import 'package:at_protocol_basics/app/app_router.gr.dart';
import 'package:at_protocol_basics/services/services.dart';
import 'package:at_protocol_basics/ui/home/home_view_model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) async {
        await model.initialize();
      },
      builder: (context, model, child) {
        return Scaffold(
         appBar: AppBar(
            title: Text('Home'),
           actions: [
             IconButton(icon: Icon(Icons.logout), onPressed: () async {
               await atProtocolService.logout(context);
             })
           ],
          ),
            body: ListView(
              children: [
                ListTile(
                  title: Text('Write Data'),
                  onTap: (){
                    ExtendedNavigator.root.push(Routes.writeDataView);
                  },
                ),
                ListTile(
                  title: Text('Read Data Once'),
                  onTap: (){
                    ExtendedNavigator.root.push(Routes.readDataOnceView);
                  },
                ),
                ListTile(
                  title: Text('Delete Data'),
                  onTap: (){
                    ExtendedNavigator.root.push(Routes.deleteDataView);
                  },
                ),
                ListTile(
                  title: Text('Listen for Updates'),
                  onTap: (){
                    ExtendedNavigator.root.push(Routes.listenForUpdatesView);
                  },
                ),
                ListTile(
                  title: Text('Send Image'),
                  onTap: (){
                    ExtendedNavigator.root.push(Routes.sendImageView);
                  },
                ),
                ListTile(
                  title: Text('Send Video'),
                  onTap: (){
                    ExtendedNavigator.root.push(Routes.sendVideoView);
                  },
                ),
                ListTile(
                  title: Text('Receive Media'),
                  onTap: (){
                    ExtendedNavigator.root.push(Routes.receiveMediaView);
                  },
                ),
              ],
            )
        );
      },
    );
  }
}