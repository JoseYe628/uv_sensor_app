
import 'dart:async';

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
      await iuvBluetoothDatasource.turnOn();
      return Right(iuvBluetoothDatasource.dataStream);
    } on BluetoothNotFoundDeviceFailure {
      return Left(BluetoothNotFoundDeviceFailure());
    } on BluetoothInternalErrorFailure {
      return Left(BluetoothInternalErrorFailure());
    }
  }

  @override
  Future<Either<Failure, void>> localRepositoryOff() async {
    try {
      await iuvBluetoothDatasource.turnOff();
      return const Right(null);
    } catch (error) {
      return Left(BluetoothInternalErrorFailure());
    }
  }

  @override
  Future<Either<Failure, Stream<bool>>> localRepositoryListen() async {
    await iuvBluetoothDatasource.listenBluetoothStatus();
    return Right(iuvBluetoothDatasource.dataStatusStream);
  }

  @override
  Future<Either<Failure, void>> sendIUV(IUV iuv) async {
    try {
      // var iuvModel = IUVModel.fromFactory(iuv);
      // await iuvDatabaseDatasource.send(iuvModel);
      return const Right(null);
    } on FirebaseSendFailure {
      return Left(FirebaseFailure());
    }
  }

  @override
  Future<Either<Failure, Stream<List<IUV>>>> remoteRepositoryListen() async {
    await iuvDatabaseDatasource.listen();
    return Right(iuvDatabaseDatasource.dataStream);
  }

}
