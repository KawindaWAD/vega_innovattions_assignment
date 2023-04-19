import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/dio_client.dart';
import 'core/network/network_info.dart';

final sl = GetIt.instance;

Future<void> setupLocators() async {
  /// Feature: Image Grid View
  // Blocs
  // sl.registerFactory<ImageGridBloc>(() => ImageGridBloc(getImageData: sl()));
  // Use Cases
  // sl.registerLazySingleton<GetImageData>(() => GetImageData(imageDataRepository: sl()));
  // Repositories
  // sl.registerLazySingleton<ImageDataRepository>(() => ImageDataRepositoryImpl(localDataSource: sl(), remoteDataSource: sl(), networkInfo: sl()));
  // Data Sources
  // sl.registerLazySingleton<ImageDataLocalDataSource>(() => ImageDataLocalDataSourceImpl(sharedPreferences: sl()));
  // sl.registerLazySingleton<ImageDataRemoteDataSource>(() => ImageDataRemoteDataSourceImpl(dioClient: sl()));

  /// Network
  sl.registerFactory<Dio>(() => Dio());
  sl.registerFactory<DioClient>(() => DioClient(public: sl<Dio>(),),);
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectionChecker: sl()));
  sl.registerLazySingleton<InternetConnectionChecker>(() => InternetConnectionChecker());

  /// Plugins
  // Shared Preferences
  final sharedPref = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPref);
}
