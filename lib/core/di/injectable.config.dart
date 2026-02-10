// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:kailasha/pages/auth/cubit/auth_cubit.dart' as _i138;
import 'package:kailasha/repository/auth_repo.dart' as _i515;
import 'package:kailasha/repository/home_repo.dart' as _i686;
import 'package:kailasha/repository/schools_repo.dart' as _i5;
import 'package:kailasha/repository/setting_repo.dart' as _i919;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt $initGetIt({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i515.AuthRepository>(() => _i515.AuthRepository());
    gh.lazySingleton<_i686.HomeRepo>(() => _i686.HomeRepo());
    gh.lazySingleton<_i5.SchoolsRepo>(() => _i5.SchoolsRepo());
    gh.lazySingleton<_i919.SettingRepo>(() => _i919.SettingRepo());
    gh.lazySingleton<_i138.AuthCubit>(
      () => _i138.AuthCubit(gh<_i515.AuthRepository>()),
    );
    return this;
  }
}
