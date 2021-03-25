// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'atProtocol/at_protocol_service.dart' as _i5;
import 'system/system_service.dart' as _i3;
import 'system/toast_service.dart' as _i4;
import 'user/user_service.dart' as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String environment, _i2.EnvironmentFilter environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.SystemService>(() => _i3.SystemService());
  gh.factory<_i4.ToastService>(() => _i4.ToastService());
  gh.singleton<_i5.AtProtocolService>(_i5.AtProtocolService());
  gh.singleton<_i6.UserService>(_i6.UserService());
  return get;
}
