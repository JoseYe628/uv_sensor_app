
import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:uv_sensor_app/core/error/failure.dart';
import 'package:uv_sensor_app/features/iuv/domain/entities/iuv.dart';
import 'package:uv_sensor_app/features/iuv/domain/repositories/iuv_repository.dart';

class LocalIUVUsecase {
  final IUVRepository repository;

  LocalIUVUsecase({required this.repository});

  Future<Either<Failure, Stream<IUV>>> localRepositoryOn() async {
    var repoUV = await repository.localRepositoryOn();
    return repoUV.fold(
      (fail){
        return Left(fail);
      },
      (stream){
        return Right(stream);
      }
    );
  }

  Future<Either<Failure, void>> localRepositoryOff() async {
    var offStatus = await repository.localRepositoryOff();
    return offStatus.fold(
      (fail){
        return Left(fail);
      },
      (v){
        return const Right(null);
      }
    );
  }

  Future<Either<Failure, Stream<bool>>> listenRepositoryState() async {
    var repoStatus = await repository.localRepositoryListen();
    return repoStatus.fold(
      (f){
        return Left(f);
      },
      (stream){
        return Right(stream);
      }
    );
  }

}
