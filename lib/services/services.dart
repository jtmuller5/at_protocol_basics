// Called after the user is authenticated since these services need to be
// Initialized on a per user basis
import 'atProtocol/at_protocol_service.dart';
import 'get_it.dart';

Future<void> initializeServices() async {
  try {
    await userService.initializeUserService();
  } catch(e){
    print('initializing error: ' + e.toString());
  }
}

AtProtocolService get atProtocolService {
  return getIt.get<AtProtocolService>();
}