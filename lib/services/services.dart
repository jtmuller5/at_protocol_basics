// Called after the user is authenticated since these services need to be
// Initialized on a per user basis
import 'package:at_protocol_basics/services/system/system_service.dart';
import 'package:at_protocol_basics/services/user/user_service.dart';

import 'atProtocol/at_protocol_service.dart';
import 'get_it.dart';

Future<void> initializeServices() async {
  try {
    //await userService.initializeUserService();
  } catch(e){
    print('initializing error: ' + e.toString());
  }
}

AtProtocolService get atProtocolService {
  return getIt.get<AtProtocolService>();
}

SystemService get systemService{
  return getIt.get<SystemService>();
}

UserService get userService{
  return getIt.get<UserService>();
}