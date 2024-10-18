
import 'package:dartz/dartz.dart';
import 'package:uv_sensor_app/core/error/failure.dart';
import 'package:uv_sensor_app/features/iuv/domain/entities/iuv.dart';

abstract class IUVRepository {
  Stream<IUV> get dataStream;
  Future<Either<Failure, void>> initialRepository();
  Future<Either<Failure, void>> listenIUV();
  Future<Either<Failure, void>> bluetoothOff();
}
