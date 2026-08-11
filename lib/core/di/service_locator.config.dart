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

import '../../feature/app_section/main_tab_cubit.dart' as _i334;
import '../../feature/auth/auth_cubit.dart' as _i1053;
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
import '../../feature/cart/data/repositories/data_sources_imp/product_cart_data_source_imp.dart'
    as _i319;
import '../../feature/cart/data/repositories/reposatories_imp/product_cart_repo_imp.dart'
    as _i138;
import '../../feature/cart/domain/repositories/data_source/product_cart_data_source.dart'
    as _i329;
import '../../feature/cart/domain/repositories/repo/product_cart_repo.dart'
    as _i380;
import '../../feature/cart/presentation/view_model/home_cubit/product_cart_cubit.dart'
    as _i4;
import '../../feature/checkout/presentation/view_model/checkout_cubit.dart'
    as _i644;
import '../../feature/details/data/api/details_api.dart' as _i160;
import '../../feature/details/data/repositories/data_sources_imp/product_details_data_source_imp.dart'
    as _i769;
import '../../feature/details/data/repositories/reposatories_imp/product_details_repo_imp.dart'
    as _i1071;
import '../../feature/details/domain/repositories/data_source/product_details_data_source.dart'
    as _i887;
import '../../feature/details/domain/repositories/repo/product_details_repo.dart'
    as _i308;
import '../../feature/details/domain/use_case/get_product_details_use_case.dart'
    as _i461;
import '../../feature/details/presentation/view_model/home_cubit/product_details_cubit.dart'
    as _i249;
import '../../feature/favorite/data/repositories/data_sources_imp/product_favorite_data_source_imp.dart'
    as _i363;
import '../../feature/favorite/data/repositories/reposatories_imp/product_favorite_repo_imp.dart'
    as _i38;
import '../../feature/favorite/domain/repositories/data_source/product_favorite_data_source.dart'
    as _i729;
import '../../feature/favorite/domain/repositories/repo/product_favorite_repo.dart'
    as _i1015;
import '../../feature/favorite/presentation/view_model/home_cubit/product_favorite_cubit.dart'
    as _i353;
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
import '../../feature/profile/data/api/profile_api.dart' as _i800;
import '../../feature/profile/data/repositories/profile_repo_imp.dart' as _i6;
import '../../feature/profile/domain/repositories/profile_repo.dart' as _i749;
import '../../feature/profile/domain/use_cases/get_profile_use_case.dart'
    as _i152;
import '../../feature/profile/presentation/view_model/profile_cubit.dart'
    as _i386;
import '../network/auth_local_data_source.dart' as _i677;

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
    gh.factory<_i644.CheckoutCubit>(() => _i644.CheckoutCubit());
    gh.factory<_i160.ProductDetailsApi>(() => _i160.ProductDetailsApi());
    gh.factory<_i446.HomeApi>(() => _i446.HomeApi());
    gh.factory<_i800.ProfileApi>(() => _i800.ProfileApi());
    gh.lazySingleton<_i334.MainTabCubit>(() => _i334.MainTabCubit());
    gh.factory<_i729.ProductFavoriteDataSource>(
        () => _i363.ProductFavoriteDataSourceImp());
    gh.lazySingleton<_i677.AuthLocalDataSource>(
        () => _i677.AuthLocalDataSourceImp());
    gh.factory<_i887.ProductDetailsDataSource>(
        () => _i769.ProductDetailsDataSourceImp(gh<_i160.ProductDetailsApi>()));
    gh.factory<_i329.ProductCartDataSource>(
        () => _i319.ProductCartDataSourceImp());
    gh.factory<_i386.ProfileCubit>(
        () => _i386.ProfileCubit(gh<_i677.AuthLocalDataSource>()));
    gh.factory<_i1015.ProductFavoriteRepo>(() =>
        _i38.ProductFavoriteRepoImp(gh<_i729.ProductFavoriteDataSource>()));
    gh.factory<_i1059.HomeDataSource>(
        () => _i650.HomeDataSourceImp(gh<_i446.HomeApi>()));
    gh.factory<_i353.FavoriteCubit>(
        () => _i353.FavoriteCubit(gh<_i1015.ProductFavoriteRepo>()));
    gh.factory<_i152.LoginDataSource>(
        () => _i165.LoginDataSourceImp(gh<_i889.LoginApi>()));
    gh.factory<_i458.RegisterDataSource>(
        () => _i334.RegisterDataSourceImp(gh<_i361.RegisterApi>()));
    gh.factory<_i380.ProductCartRepo>(
        () => _i138.ProductCartRepoImp(gh<_i329.ProductCartDataSource>()));
    gh.factory<_i749.ProfileRepo>(
        () => _i6.ProfileRepoImp(gh<_i800.ProfileApi>()));
    gh.factory<_i724.LoginRepo>(
        () => _i916.LoginRepoImp(gh<_i152.LoginDataSource>()));
    gh.factory<_i152.GetProfileUseCase>(
        () => _i152.GetProfileUseCase(gh<_i749.ProfileRepo>()));
    gh.lazySingleton<_i4.CartCubit>(
        () => _i4.CartCubit(gh<_i380.ProductCartRepo>()));
    gh.factory<_i308.ProductDetailsRepo>(() =>
        _i1071.ProductsDetailsRepoImp(gh<_i887.ProductDetailsDataSource>()));
    gh.factory<_i874.HomeRepo>(
        () => _i1031.HomeRepoImp(gh<_i1059.HomeDataSource>()));
    gh.factory<_i461.GetProductDetailsUseCase>(
        () => _i461.GetProductDetailsUseCase(gh<_i308.ProductDetailsRepo>()));
    gh.factory<_i582.RegisterRepo>(
        () => _i508.RegisterRepoImp(gh<_i458.RegisterDataSource>()));
    gh.factory<_i283.GetCategoriesUseCase>(
        () => _i283.GetCategoriesUseCase(gh<_i874.HomeRepo>()));
    gh.factory<_i853.GetProdactsUseCase>(
        () => _i853.GetProdactsUseCase(gh<_i874.HomeRepo>()));
    gh.factory<_i494.LoginUseCase>(
        () => _i494.LoginUseCase(gh<_i724.LoginRepo>()));
    gh.factory<_i200.RegisterUseCase>(
        () => _i200.RegisterUseCase(gh<_i582.RegisterRepo>()));
    gh.factory<_i377.RegisterCubit>(
        () => _i377.RegisterCubit(gh<_i200.RegisterUseCase>()));
    gh.lazySingleton<_i1053.AuthCubit>(() => _i1053.AuthCubit(
          gh<_i677.AuthLocalDataSource>(),
          gh<_i152.GetProfileUseCase>(),
        ));
    gh.factory<_i249.ProductDetailsCubit>(
        () => _i249.ProductDetailsCubit(gh<_i461.GetProductDetailsUseCase>()));
    gh.factory<_i747.HomeCubit>(() => _i747.HomeCubit(
          gh<_i283.GetCategoriesUseCase>(),
          gh<_i853.GetProdactsUseCase>(),
        ));
    gh.factory<_i293.LoginCubit>(() => _i293.LoginCubit(
          gh<_i494.LoginUseCase>(),
          gh<_i677.AuthLocalDataSource>(),
          gh<_i1053.AuthCubit>(),
        ));
    return this;
  }
}
