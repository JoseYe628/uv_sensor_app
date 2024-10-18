
import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:uv_sensor_app/core/error/failure.dart';
import 'package:uv_sensor_app/features/iuv/data/datasources/iuv_bluetooth_datasource.dart';
import 'package:uv_sensor_app/features/iuv/domain/entities/iuv.dart';
import 'package:uv_sensor_app/features/iuv/domain/repositories/iuv_repository.dart';

class IUVRepositoryImpl implements IUVRepository {

  final IUVBluetoothDatasource iuvBluetoothDatasource;
  // TODO FirebaseDatasource

  final StreamController<IUV> _dataIUVStreamController = StreamController<IUV>();

  IUVRepositoryImpl({required this.iuvBluetoothDatasource});

  @override
  Stream<IUV> get dataStream => _dataIUVStreamController.stream;

  @override
  Future<Either<Failure, void>> initialRepository() async {
    try {
      await iuvBluetoothDatasource.searchDevice();
      await iuvBluetoothDatasource.connectToDevice();
      return const Right(null);
    } on BluetoothScanDevicesFailure {
      return Left(BluetoothScanDevicesFailure());
    } on BluetoothNotFoundDeviceFailure {
      return Left(BluetoothNotFoundDeviceFailure());
    }
  }

  @override
  Future<Either<Failure, void>> listenIUV() async {
    try {
      await iuvBluetoothDatasource.listenDataDevice();
      iuvBluetoothDatasource.dataStream.listen((value){
        _dataIUVStreamController.add(value);
      });
      return const Right(null);
    } on BluetoothDeviceDisconnectedFailure {
      return Left(BluetoothDeviceDisconnectedFailure());
    } on BluetoothNotFoundDCharacteristicsFailure {
      return Left(BluetoothNotFoundDCharacteristicsFailure());
    }
  }

  @override
  Future<Either<Failure, void>> bluetoothOff() async {
    try {
      await iuvBluetoothDatasource.disconnectWithDevice();
      return const Right(null);
    } on BluetoothDisconnectError {
      return Left(BluetoothDisconnectError());
    }
  }

}
