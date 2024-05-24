import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:wajed_app/common/address/bloc/cubit/address_cubit.dart';
import 'package:wajed_app/common/address/data/repo/address_repo.dart';
import 'package:wajed_app/common/alerts/bloc/cubit/alerts_cubit.dart';
import 'package:wajed_app/common/alerts/data/repo/alerts_repo.dart';
import 'package:wajed_app/common/app/data/repo/app_repo.dart';
import 'package:wajed_app/common/auth/data/repo/auth_repo.dart';
import 'package:wajed_app/common/category/bloc/cubit/category_cubit.dart';
import 'package:wajed_app/common/category/data/repo/categories_repo.dart';
import 'package:wajed_app/common/chate/bloc/cubit/chate_cubit.dart';
import 'package:wajed_app/common/chate/data/repo/chate_repo.dart';
import 'package:wajed_app/common/complaints/bloc/cubit/complaint_cubit.dart';
import 'package:wajed_app/common/complaints/data/repo/complaints_repo.dart';
import 'package:wajed_app/common/order/bloc/order_cubit/order_cubit.dart';
import 'package:wajed_app/common/order/data/repo/order_repo.dart';
import 'package:wajed_app/common/product/bloc/product_cubit/product_cubit.dart';
import 'package:wajed_app/common/product/data/repo/product_repo.dart';
import 'package:wajed_app/common/profile/bloc/profile_cubit/profile_cubit.dart';
import 'package:wajed_app/common/profile/data/repo/profile_repo.dart';
import 'package:wajed_app/driver/bloc/cubit/driver_cubit.dart';
import 'package:wajed_app/driver/data/repo/driver_repo.dart';
import 'package:wajed_app/market/home/bloc/cubit/home_market_cubit.dart';
import 'package:wajed_app/market/home/data/repo/home_market_repo.dart';
import 'package:wajed_app/user/cart/bloc/cart_cubit/cart_cubit.dart';
import 'package:wajed_app/user/cart/data/repo/cart_repo.dart';
import 'package:wajed_app/user/favoraite/bloc/favoraite_cubit/favoraite_cubit.dart';
import 'package:wajed_app/user/favoraite/data/repo/favoraite_repo.dart';
import 'package:wajed_app/user/home/bloc/home_cubit/home_cubit.dart';
import 'package:wajed_app/user/home/data/repo/home_repo.dart';
import 'package:wajed_app/user/offers/bloc/offer_cubit/offer_cubit.dart';
import 'package:wajed_app/user/offers/data/repo/offfer_repo.dart';
import 'package:wajed_app/user/rates/bloc/rate_cubit/rate_cubit.dart';
import 'package:wajed_app/user/rates/data/repo/rate_repo.dart';
import '../../common/app/bloc/cubit/app_cubit/app_cubit.dart';
import '../../common/auth/bloc/cubit/auth_cubit/auth_cubit.dart';
import '../../market/market/bloc/market_cubit/market_cubit.dart';
import '../../market/market/data/repo/market_repo.dart';
import '../network/api_service.dart';
import '../network/dio_factory.dart';

final sl = GetIt.instance;

class ServicesLocator {
  Future<void> init() async {
    Dio dio = await DioFactory.getDio();

    ///* services
    sl.registerLazySingleton<ApiService>(() => ApiService(dio));

    ///* repo
    sl.registerLazySingleton<BaseAuth>(() => AuthRepo());
    sl.registerLazySingleton<BaseOffer>(() => OffferRepo());
    sl.registerLazySingleton<BaseHomeUser>(() => HomeUserRepo());
    sl.registerLazySingleton<BaseMarket>(() => MarketRepo());
    sl.registerLazySingleton<BaseCart>(() => CartRepo());
    sl.registerLazySingleton<BaseAddress>(() => AddressRepo());
    sl.registerLazySingleton<BaseOrder>(() => OrdersRepo());
    sl.registerLazySingleton<BaseHomeMarket>(() => HomeMarketRepo());
    sl.registerLazySingleton<BaseApp>(() => AppRepo());
    sl.registerLazySingleton<CategoryBase>(() => CategoryRepo());
    sl.registerLazySingleton<BaseDriver>(() => DriverRepo());
    sl.registerLazySingleton<BaseChate>(() => ChateRepo());
    sl.registerLazySingleton<BaseAlert>(() => AlertsRepo());
    sl.registerLazySingleton<BaseComplaints>(() => ComplaintsRepo());
    sl.registerLazySingleton<BaseRate>(() => RateRepo());
    sl.registerLazySingleton<BaseFavoraite>(() => FavoraiteRepo());
    sl.registerLazySingleton<BaseProfile>(() => ProfileRepo());

    ///* bloc
    sl.registerFactory<CategoryCubit>(() => CategoryCubit(sl()));
    sl.registerFactory<AppCubit>(() => AppCubit());
    sl.registerFactory<AuthCubit>(() => AuthCubit(sl()));
    sl.registerFactory<HomeCubit>(() => HomeCubit(sl(), sl()));
    sl.registerFactory<MarketCubit>(() => MarketCubit(sl(), sl()));
    sl.registerFactory<BaseProduct>(() => ProductRepo());
    sl.registerFactory<CartCubit>(() => CartCubit(sl()));
    sl.registerFactory<AddressCubit>(() => AddressCubit(sl()));
    sl.registerFactory<OrderCubit>(() => OrderCubit(sl()));
    sl.registerLazySingleton<HomeMarketCubit>(
        () => HomeMarketCubit(sl(), sl()));
    sl.registerFactory<ProductCubit>(() => ProductCubit(sl(), sl()));
    sl.registerFactory<DriverCubit>(() => DriverCubit(sl(), sl()));
    sl.registerFactory<ChateCubit>(() => ChateCubit(sl()));
    sl.registerFactory<AlertsCubit>(() => AlertsCubit(sl()));
    sl.registerFactory<ComplaintCubit>(() => ComplaintCubit(sl()));
    sl.registerFactory<RateCubit>(() => RateCubit(sl()));
    sl.registerFactory<FavoraiteCubit>(() => FavoraiteCubit(sl()));

    sl.registerFactory<OfferCubit>(() => OfferCubit(sl()));
    sl.registerFactory<ProfileCubit>(() => ProfileCubit(sl(), sl()));
  }
}
