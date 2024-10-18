
import 'package:get_it/get_it.dart';
import 'package:uv_sensor_app/features/iuv/data/datasources/iuv_bluetooth_datasource.dart';
import 'package:uv_sensor_app/features/iuv/data/repositories/iuv_repository_impl.dart';
import 'package:uv_sensor_app/features/iuv/domain/repositories/iuv_repository.dart';
import 'package:uv_sensor_app/features/iuv/domain/use_cases/bluetooth_off_case.dart';
import 'package:uv_sensor_app/features/iuv/domain/use_cases/listen_iuv.dart';
import 'package:uv_sensor_app/features/iuv/presentation/bloc/iuv_bluetooth_cubit.dart';

final sl = GetIt.instance;

Future<void> dependenceInjection() async {
  //Bloc
  sl.registerFactory(() => IUVBluetoothCubit(sl(), sl()));

  // Use cases
  sl.registerLazySingleton(() => ListenIUVUseCase(repository: sl()));
  sl.registerLazySingleton(() => BluetoothOffCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<IUVRepository>(() => IUVRepositoryImpl(iuvBluetoothDatasource: sl()));

  // Data sources
  sl.registerLazySingleton<IUVBluetoothDatasource>(() => FlutterBlueDatasource());
}
