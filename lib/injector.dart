import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vega_innovattions_assignmen/features/sign_up/data/repositories/user_registration_repository_impl.dart';

import 'core/network/dio_client.dart';
import 'core/network/network_info.dart';
import 'features/common/data/datasources/news_remote_data_source.dart';
import 'features/common/data/repositories/news_repository_impl.dart';
import 'features/common/domain/repositories/news_repository.dart';
import 'features/common/domain/usecases/get_news.dart';
import 'features/common/presentation/blocs/authentication/authentication_bloc.dart';
import 'features/dashboard/presentation/bloc/breaking_news/breaking_news_bloc.dart';
import 'features/dashboard/presentation/bloc/top_news/top_news_bloc.dart';
import 'features/sign_in/data/datasources/user_details_local_data_source.dart';
import 'features/sign_in/data/repositories/user_details_repository_impl.dart';
import 'features/sign_in/domain/repositories/user_details_repository.dart';
import 'features/sign_in/domain/usecases/login_user.dart';
import 'features/sign_in/presentation/bloc/login_cubit.dart';
import 'features/sign_in/presentation/bloc/login_user/login_user_bloc.dart';
import 'features/sign_up/data/datasources/register_user_local_data_source.dart';
import 'features/sign_up/domain/repositories/user_registration_repository.dart';
import 'features/sign_up/domain/usecases/register_user.dart';
import 'features/sign_up/presentation/bloc/sign_up_cubit.dart';
import 'features/sign_up/presentation/bloc/sign_up_user/sign_up_user_bloc.dart';

final sl = GetIt.instance;

Future<void> setupLocators() async {
  /// Feature: Sign Up
  // Blocs
  sl.registerFactory<SignUpCubit>(() => SignUpCubit());
  sl.registerFactory<SignUpUserBloc>(() => SignUpUserBloc(registerUser: sl()));
  // Use Cases
  sl.registerLazySingleton<RegisterUser>(() => RegisterUser(userRegistrationRepository: sl()));
  // Repositories
  sl.registerLazySingleton<UserRegistrationRepository>(() => UserRegistrationRepositoryImpl(registerUserLocalDataSource: sl()));
  // Data Sources
  sl.registerLazySingleton<RegisterUserLocalDataSource>(() => RegisterUserLocalDataSourceImpl(sharedPreferences: sl()));

  /// Feature: Login
  // Blocs
  sl.registerFactory<LoginCubit>(() => LoginCubit());
  sl.registerFactory<LoginUserBloc>(() => LoginUserBloc(loginUser: sl()));
  // Use Cases
  sl.registerLazySingleton<LoginUser>(() => LoginUser(userDetailsRepository: sl()));
  // Repositories
  sl.registerLazySingleton<UserDetailsRepository>(() => UserDetailsRepositoryImpl(localDataSource: sl()));
  // Data Sources
  sl.registerLazySingleton<UserDetailsLocalDataSource>(() => UserDetailLocalDataSourceImpl(sharedPreferences: sl()));

  /// Feature: authentication
  // Blocs
  sl.registerLazySingleton<AuthenticationBloc>(() => AuthenticationBloc());

  /// Feature: News
  // Blocs
  sl.registerFactory<BreakingNewsBloc>(() => BreakingNewsBloc(getNews: sl()));
  sl.registerFactory<TopNewsBloc>(() => TopNewsBloc(getNews: sl()));
  // Use Cases
  sl.registerLazySingleton<GetNews>(() => GetNews(newsRepository: sl(),));
  // Repositories
  sl.registerLazySingleton<NewsRepository>(() => NewsRepositoryImpl(networkInfo: sl(), remoteDataSource: sl()));
  // Data Sources
  sl.registerLazySingleton<NewsRemoteDataSource>(() => NewsRemoteDataSourceImpl(dioClient: sl(),));

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
