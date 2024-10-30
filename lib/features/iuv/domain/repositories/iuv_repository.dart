
import 'package:dartz/dartz.dart';
import 'package:uv_sensor_app/core/error/failure.dart';
import 'package:uv_sensor_app/features/iuv/domain/entities/iuv.dart';

abstract class IUVRepository {
  Future<Either<Failure, Stream<IUV>>> localRepositoryOn();
  Future<Either<Failure, void>> localRepositoryOff();
  Future<Either<Failure, Stream<List<IUV>>>> remoteRepositoryOn();
  Future<Either<Failure, void>> remoteSendData(IUV iuv);
}
