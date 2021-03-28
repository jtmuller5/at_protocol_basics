import 'package:at_protocol_basics/ui/deleteData/delete_data_view.dart';
import 'package:at_protocol_basics/ui/home/home_view.dart';
import 'package:at_protocol_basics/ui/listenForUpdates/listen_for_updates_view.dart';
import 'package:at_protocol_basics/ui/readDataOnce/read_data_once_view.dart';
import 'package:at_protocol_basics/ui/receiveMedia/receive_media_view.dart';
import 'package:at_protocol_basics/ui/sendImage/send_image_view.dart';
import 'package:at_protocol_basics/ui/sendVideo/send_video_view.dart';
import 'package:at_protocol_basics/ui/start/start_view.dart';
import 'package:at_protocol_basics/ui/writeData/write_data_view.dart';
import 'package:atsign_authentication_helper/screens/scan_qr.dart';
import 'package:auto_route/auto_route_annotations.dart';

@AdaptiveAutoRouter(routes: <AutoRoute>[
  AutoRoute(page: StartView,initial: true),
  AutoRoute(page: HomeView),
  AutoRoute(page: ScanQrScreen),
  AutoRoute(page: WriteDataView),
  AutoRoute(page: ReadDataOnceView),
  AutoRoute(page: DeleteDataView),
  AutoRoute(page: ListenForUpdatesView),
  AutoRoute(page: SendImageView),
  AutoRoute(page: SendVideoView),
  AutoRoute(page: ReceiveMediaView)
])
class $AppRouter {}