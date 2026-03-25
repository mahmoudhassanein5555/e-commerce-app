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

import '../../feature/auth/login/data/api/login_api.dart' as _i889;
import '../../feature/auth/login/data/repositories/data_source/login_data_source_imp.dart'
    as _i165;
import '../../feature/auth/login/data/repositories/repo/login_repo_imp.dart'
    as _i916;
import '../../feature/auth/login/domain/repositories/data_source/login_data_source.dart'
    as _i152;
import '../../feature/auth/login/domain/repositories/repo/login_repo.dart'
    as _i724;
import '../../feature/auth/login/domain/use_case/login_use_case.dart' as _i494;
import '../../feature/auth/login/presentation/view_model/home_cubit/login_cubit.dart'
    as _i293;
import '../../feature/auth/register/data/api/register_api.dart' as _i361;
import '../../feature/auth/register/data/repositories/data_source/register_data_source_imp.dart'
    as _i334;
import '../../feature/auth/register/data/repositories/repo/register_repo_imp.dart'
    as _i508;
import '../../feature/auth/register/domain/repositories/data_source/register_data_source.dart'
    as _i458;
import '../../feature/auth/register/domain/repositories/repo/register_repo.dart'
    as _i582;
import '../../feature/auth/register/domain/use_case/register_use_case.dart'
    as _i200;
import '../../feature/auth/register/presentation/view_model/home_cubit/register_cubit.dart'
    as _i377;
import '../../feature/home/data/api/home_api.dart' as _i446;
import '../../feature/home/data/repositories/data_sources_imp/home_data_source_imp.dart'
    as _i650;
import '../../feature/home/data/repositories/reposatories_imp/home_repo_imp.dart'
    as _i1031;
import '../../feature/home/domain/repositories/data_source/home_data_source.dart'
    as _i1059;
import '../../feature/home/domain/repositories/repo/home_repo.dart' as _i874;
import '../../feature/home/domain/use_case/get_categories_use_case.dart'
    as _i283;
import '../../feature/home/domain/use_case/get_prodacts_use_case.dart' as _i853;
import '../../feature/home/presentation/view_model/home_cubit/home_cubit.dart'
    as _i747;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i889.LoginApi>(() => _i889.LoginApi());
    gh.factory<_i361.RegisterApi>(() => _i361.RegisterApi());
    gh.factory<_i446.HomeApi>(() => _i446.HomeApi());
    gh.factory<_i1059.HomeDataSource>(
        () => _i650.HomeDataSourceImp(gh<_i446.HomeApi>()));
    gh.factory<_i152.LoginDataSource>(
        () => _i165.LoginDataSourceImp(gh<_i889.LoginApi>()));
    gh.factory<_i458.RegisterDataSource>(
        () => _i334.RegisterDataSourceImp(gh<_i361.RegisterApi>()));
    gh.factory<_i724.LoginRepo>(
        () => _i916.LoginRepoImp(gh<_i152.LoginDataSource>()));
    gh.factory<_i874.HomeRepo>(
        () => _i1031.HomeRepoImp(gh<_i1059.HomeDataSource>()));
    gh.factory<_i582.RegisterRepo>(
        () => _i508.RegisterRepoImp(gh<_i458.RegisterDataSource>()));
    gh.factory<_i283.GetCategoriesUseCase>(
        () => _i283.GetCategoriesUseCase(gh<_i874.HomeRepo>()));
    gh.factory<_i853.GetProdactsUseCase>(
        () => _i853.GetProdactsUseCase(gh<_i874.HomeRepo>()));
    gh.factory<_i494.LoginUseCase>(
        () => _i494.LoginUseCase(gh<_i724.LoginRepo>()));
    gh.factory<_i293.LoginCubit>(
        () => _i293.LoginCubit(gh<_i494.LoginUseCase>()));
    gh.factory<_i200.RegisterUseCase>(
        () => _i200.RegisterUseCase(gh<_i582.RegisterRepo>()));
    gh.factory<_i377.RegisterCubit>(
        () => _i377.RegisterCubit(gh<_i200.RegisterUseCase>()));
    gh.factory<_i747.HomeCubit>(() => _i747.HomeCubit(
          gh<_i283.GetCategoriesUseCase>(),
          gh<_i853.GetProdactsUseCase>(),
        ));
    return this;
  }
}
