
import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:uv_sensor_app/core/error/failure.dart';
import 'package:uv_sensor_app/features/iuv/domain/entities/iuv.dart';
import 'package:uv_sensor_app/features/iuv/domain/repositories/iuv_repository.dart';

class LocalIUVUsecase {
  final IUVRepository repository;

  LocalIUVUsecase({required this.repository});

  Future<Either<Failure, Stream<IUV>>> localIUVOn() {
    return repository.localRepositoryOn();
  }

  Future<Either<Failure, void>> localIUVOff() {
    return repository.localRepositoryOff();
  }

}
