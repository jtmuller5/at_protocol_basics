import 'dart:io';

import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:at_commons/at_commons.dart';
import 'package:at_platform_files/app/app_router.gr.dart';
import 'package:at_platform_files/app/at_constants.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

@singleton
class AtProtocolService {
  /// The current AtClientService used to initialize the AtClient
  AtClientService atClientService;

  /// The current AtClient implementation
  AtClientImpl atClientImpl;

  /// The currently logged in @Sign
  String get atSign {
    return atClientImpl.currentAtSign;
  }

  KeyChainManager manager;

  /// List of @Signs available on this device
  List<String> atSignList = [];

  AtClientPreference atClientPreference;

  String get currentAtSign {
    return atClientService.atClient.currentAtSign;
  }

  /// Create keyChainManager and get all previous AtSigns
  Future<void> setup() async {
    await getSigns();
  }

  Future<void> getInstance() async {
    Directory downloadDirectory;
    atClientService = AtClientService();

    /// The directory where keys will be stored
    if (Platform.isIOS) {
      downloadDirectory = await path_provider.getApplicationDocumentsDirectory();
    }

    /// Download path varies on non-iOS platforms
    else {
      downloadDirectory = await path_provider.getExternalStorageDirectory();
    }

    final appSupportDirectory = await path_provider.getApplicationSupportDirectory();

    String path = appSupportDirectory.path;

    atClientPreference = AtClientPreference()
      ..isLocalStoreRequired = true
      ..commitLogPath = path
      ..syncStrategy = SyncStrategy.IMMEDIATE
      ..rootDomain = AtConstants.ROOT_DOMAIN
      ..hiveStoragePath = path
      ..outboundConnectionTimeout = 600000000
      ..syncStrategy = SyncStrategy.IMMEDIATE
      ..downloadPath = downloadDirectory.path;
  }

  void reconnect() {
    //atClientService.atClient.getLocalSecondary();
    //atClientService.atClient.getRemoteSecondary();
    //onboard(atsign: attachedService.myAtSign.value);
  }

  Future<void> status() async {
    //atClientService.atClient.getLocalSecondary();
    //atClientService.atClient.getRemoteSecondary();
    var stats = await atClientService.getAtsignsWithStatus();
    print('status: ' + stats.toString());
  }

  /// Get all @Signs that this device has used to sign in
  Future<void> getSigns() async {
    manager = KeyChainManager.getInstance();
    atSignList = await manager.getAtSignListFromKeychain();
    print('Existing at signs: ' + atSignList.toString());
  }

  /// make the selected atSign the primary one before onboarding again
  Future<void> makePrimary(String atSign) async {
    await manager.makeAtSignPrimary(atSign);
  }

  /// Create an AtClient (AtClientImpl) to communicate with the person's
  /// secondary server
  Future<bool> onboard({String atsign}) async {
    atClientImpl = null;
    atClientService = AtClientService();
    Directory downloadDirectory;

    /// The directory where keys will be stored
    if (Platform.isIOS) {
      downloadDirectory = await path_provider.getApplicationDocumentsDirectory();
    }

    /// Download path varies on non-iOS platforms
    else {
      downloadDirectory = await path_provider.getExternalStorageDirectory();
    }

    final appSupportDirectory = await path_provider.getApplicationSupportDirectory();

    String path = appSupportDirectory.path;

    /// Setup AtClient preferences (cascade for cleanliness)
    atClientPreference = AtClientPreference()
      ..isLocalStoreRequired = true
      ..commitLogPath = path
      ..syncStrategy = SyncStrategy.IMMEDIATE
      ..rootDomain = AtConstants.ROOT_DOMAIN
      ..hiveStoragePath = path
      ..downloadPath = downloadDirectory.path;

    print('onboarding step 1');
    bool result = await atClientService
        .onboard(
      atClientPreference: atClientPreference,
      atsign: atsign,
    )
        .catchError((e) {
      print('Error in Onboarding: ${e.toString()}');
      return false;
    });

    print('result: ' + result.toString());
    result ??= false;

    /// Store the current At Sign for display
    atClientImpl = atClientService.atClient;

    return result;
  }

  ///Fetches atsign from device keychain.
  Future<String> getAtSign() async {
    return await atClientService.getAtSign();
  }

  Future<String> get(AtKey atKey) async {
    var result = await atClientImpl.get(atKey);
    return result.value;
  }

  Future<bool> put(AtKey atKey, String value) async {
    return await atClientImpl.put(
      atKey,
      value,
    );
  }

  Future<bool> delete(AtKey atKey) async {
    return await atClientImpl.delete(atKey);
  }

  ///Fetches privatekey for [atsign] from device keychain.
  Future<String> getPrivateKey(String atsign) async {
    return await atClientImpl.getPrivateKey(atsign);
  }

  Future<List<String>> getKeys({String sharedBy}) async {
    return await atClientImpl.getKeys(regex: 'server_demo', sharedBy: sharedBy);
  }

  Future<bool> saveKeys(String publicKey, String privateKey) {
    return atClientImpl.persistPublicKey(publicKey);
  }

  /// Clear all At Protocol values and return to the initial sign in view
  Future<void> logout(BuildContext context) async {
    await manager.deleteAtSignFromKeychain(currentAtSign);

    atClientService = null;
    atClientImpl = null;
    atClientPreference = null;

    await onboard();

    ExtendedNavigator.of(context).pushAndRemoveUntil(Routes.startView, (route) => false);
  }
}
