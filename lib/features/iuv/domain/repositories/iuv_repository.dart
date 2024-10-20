
import 'package:dartz/dartz.dart';
import 'package:uv_sensor_app/core/error/failure.dart';
import 'package:uv_sensor_app/features/iuv/domain/entities/iuv.dart';

abstract class IUVRepository {
  Future<Either<Failure, Stream<IUV>>> localRepositoryOn(); // Enciende repositorio local e inicializa localDataStream
  Future<Either<Failure, void>> localRepositoryOff();
  Future<Either<Failure, Stream<bool>>> localRepositoryListen();

  Future<Either<Failure, void>> sendIUV(IUV iuv);
  Future<Either<Failure, Stream<List<IUV>>>> remoteRepositoryListen();
}
