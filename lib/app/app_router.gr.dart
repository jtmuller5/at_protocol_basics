// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:atsign_authentication_helper/screens/scan_qr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../ui/deleteData/delete_data_view.dart';
import '../ui/home/home_view.dart';
import '../ui/readDataOnce/read_data_once_view.dart';
import '../ui/start/start_view.dart';
import '../ui/writeData/write_data_view.dart';

class Routes {
  static const String startView = '/';
  static const String homeView = '/home-view';
  static const String scanQrScreen = '/scan-qr-screen';
  static const String writeDataView = '/write-data-view';
  static const String readDataOnceView = '/read-data-once-view';
  static const String deleteDataView = '/delete-data-view';
  static const all = <String>{
    startView,
    homeView,
    scanQrScreen,
    writeDataView,
    readDataOnceView,
    deleteDataView,
  };
}

class AppRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.startView, page: StartView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.scanQrScreen, page: ScanQrScreen),
    RouteDef(Routes.writeDataView, page: WriteDataView),
    RouteDef(Routes.readDataOnceView, page: ReadDataOnceView),
    RouteDef(Routes.deleteDataView, page: DeleteDataView),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    StartView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => StartView(),
        settings: data,
      );
    },
    HomeView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => HomeView(),
        settings: data,
      );
    },
    ScanQrScreen: (data) {
      final args = data.getArgs<ScanQrScreenArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => ScanQrScreen(
          key: args.key,
          nextScreen: args.nextScreen,
          atClientServiceInstance: args.atClientServiceInstance,
          atClientPreference: args.atClientPreference,
        ),
        settings: data,
      );
    },
    WriteDataView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => WriteDataView(),
        settings: data,
      );
    },
    ReadDataOnceView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => ReadDataOnceView(),
        settings: data,
      );
    },
    DeleteDataView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => DeleteDataView(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// ScanQrScreen arguments holder class
class ScanQrScreenArguments {
  final Key key;
  final Widget nextScreen;
  final AtClientService atClientServiceInstance;
  final AtClientPreference atClientPreference;
  ScanQrScreenArguments(
      {this.key,
      @required this.nextScreen,
      @required this.atClientServiceInstance,
      @required this.atClientPreference});
}
