import 'package:get_it/get_it.dart';
import 'package:togarak/core/exports.dart';
import '../../features/authsecond/data/datasource/auth_remote_datasourse.dart';
import '../../features/authsecond/data/repositories/auth_repositories.dart';
import '../../features/authsecond/domain/usecases/login_usecase.dart';
import '../../features/authsecond/presentation/bloc/auth2_bloc.dart';

final get = GetIt.instance;

Future<void> init() async {
  //dio
  get.registerSingleton(() => Dio());
  get.registerSingleton(() => ApiService());

  // DataSourses
  get.registerLazySingleton(() => AuthRemoteDataSources(get<ApiService>()));

  //repository
  get.registerLazySingleton(() => AuthRepositoryImpl(get<AuthRemoteDataSources>()));

  //useCases
  get.registerLazySingleton(() => LoginUseCase(get()));

  //bloc
  get.registerFactory(() => AuthBloc2(loginUseCase: get()));
}
