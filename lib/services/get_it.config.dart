// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'atProtocol/at_protocol_service.dart' as _i7;
import 'media/media_service.dart' as _i4;
import 'system/file_Service.dart' as _i3;
import 'system/system_service.dart' as _i5;
import 'system/toast_service.dart' as _i6;
import 'user/user_service.dart' as _i8; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String environment, _i2.EnvironmentFilter environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.FileService>(() => _i3.FileService());
  gh.factory<_i4.MediaService>(() => _i4.MediaService());
  gh.factory<_i5.SystemService>(() => _i5.SystemService());
  gh.factory<_i6.ToastService>(() => _i6.ToastService());
  gh.singleton<_i7.AtProtocolService>(_i7.AtProtocolService());
  gh.singleton<_i8.UserService>(_i8.UserService());
  return get;
}
