
import 'package:get_it/get_it.dart';
import 'package:uv_sensor_app/features/iuv/data/datasources/iuv_bluetooth_datasource.dart';
import 'package:uv_sensor_app/features/iuv/data/datasources/iuv_database_datasource.dart';
import 'package:uv_sensor_app/features/iuv/data/repositories/iuv_repository_impl.dart';
import 'package:uv_sensor_app/features/iuv/domain/repositories/iuv_repository.dart';
import 'package:uv_sensor_app/features/iuv/domain/use_cases/local_iuv_usecase.dart';
import 'package:uv_sensor_app/features/iuv/domain/use_cases/remote_iuv_usecases.dart';
import 'package:uv_sensor_app/features/iuv/presentation/bloc/iuv_bluetooth_cubit.dart';
import 'package:uv_sensor_app/features/iuv/presentation/bloc/iuv_firebase_cubit.dart';

final sl = GetIt.instance;

Future<void> dependenceInjection() async {
  //Bloc
  sl.registerFactory(() => IUVBluetoothCubit(sl(), sl()));
  sl.registerFactory(() => IUVFirebaseCubit(sl()));

  // Use cases
  sl.registerLazySingleton(() => LocalIUVUsecase(repository: sl()));
  sl.registerLazySingleton(() => RemoteIUVUsecase(repository: sl()));

  // Repository
  sl.registerLazySingleton<IUVRepository>(() => IUVRepositoryImpl(iuvBluetoothDatasource: sl(), iuvDatabaseDatasource: sl()));

  // Data sources
  sl.registerLazySingleton<IUVBluetoothDatasource>(() => FlutterBlueDatasource());
  sl.registerLazySingleton<IUVDatabaseDatasource>(() => IUVFirebaseDatasource());
}
