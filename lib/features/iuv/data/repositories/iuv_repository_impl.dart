
import 'package:dartz/dartz.dart';
import 'package:uv_sensor_app/core/error/failure.dart';
import 'package:uv_sensor_app/features/iuv/data/datasources/iuv_bluetooth_datasource.dart';
import 'package:uv_sensor_app/features/iuv/data/datasources/iuv_database_datasource.dart';
import 'package:uv_sensor_app/features/iuv/data/models/iuv_model.dart';
import 'package:uv_sensor_app/features/iuv/domain/entities/iuv.dart';
import 'package:uv_sensor_app/features/iuv/domain/repositories/iuv_repository.dart';

class IUVRepositoryImpl implements IUVRepository {

  final IUVBluetoothDatasource iuvBluetoothDatasource;
  final IUVDatabaseDatasource iuvDatabaseDatasource;

  IUVRepositoryImpl({required this.iuvBluetoothDatasource, required this.iuvDatabaseDatasource});

  @override
  Future<Either<Failure, Stream<IUV>>> localRepositoryOn() async {
    try {
      var streamResp =  await iuvBluetoothDatasource.bluetoothOn();
      return Right(streamResp);
    } on BluetoothInternalErrorFailure {
      return Left(BluetoothInternalErrorFailure());
    } on BluetoothNotFoundDeviceFailure {
      return Left(BluetoothNotFoundDeviceFailure());
    }
  }

  @override
  Future<Either<Failure, void>> localRepositoryOff() async {
    await iuvBluetoothDatasource.bluetoothOf();
    return const Right(null);
  }

  @override
  Future<Either<Failure, Stream<List<IUV>>>> remoteRepositoryOn() async {
    var stream = await iuvDatabaseDatasource.getStreamData();
    return Right(stream);
  }

  @override
  Future<Either<Failure, void>> remoteSendData(IUV iuv, bool notify) async {
    try{
      await iuvDatabaseDatasource.send(IUVModel.fromFactory(iuv), notify = notify);
      return const Right(null);
    } on FirebaseSendFailure {
      return Left(FirebaseSendFailure());
    }
  }
}
