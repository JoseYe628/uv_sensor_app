
import 'package:dartz/dartz.dart';
import 'package:uv_sensor_app/core/error/failure.dart';
import 'package:uv_sensor_app/features/iuv/domain/entities/iuv.dart';

abstract class IUVRepository {
  Future<Either<Failure, IUV>> getIUV();
  Future<Either<Failure, bool>> sendIUV();
  listenIUV();
}
