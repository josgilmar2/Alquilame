// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:alquilame/repositories/auth_repository.dart' as _i4;
import 'package:alquilame/repositories/dwelling_repository.dart' as _i5;
import 'package:alquilame/repositories/user_repository.dart' as _i6;
import 'package:alquilame/rest/rest_client.dart' as _i3;
import 'package:alquilame/services/auth_service.dart' as _i8;
import 'package:alquilame/services/dwelling_service.dart' as _i7;
import 'package:alquilame/services/user_service.dart' as _i9;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart'
    as _i2; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.RestAuthenticatedClient>(_i3.RestAuthenticatedClient());
    gh.singleton<_i3.RestClient>(_i3.RestClient());
    gh.singleton<_i4.AuthRepository>(_i4.AuthRepository());
    gh.singleton<_i5.DwellingRepository>(_i5.DwellingRepository());
    gh.singleton<_i6.UserRepository>(_i6.UserRepository());
    gh.singleton<_i7.DwellingService>(_i7.DwellingService());
    gh.singleton<_i8.JwtAuthService>(_i8.JwtAuthService());
    gh.singleton<_i9.UserService>(_i9.UserService());
    return this;
  }
}
