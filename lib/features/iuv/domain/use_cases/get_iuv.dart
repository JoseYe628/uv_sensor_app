
import 'package:dartz/dartz.dart';
import 'package:uv_sensor_app/core/error/failure.dart';
import 'package:uv_sensor_app/features/iuv/domain/entities/iuv.dart';
import 'package:uv_sensor_app/features/iuv/domain/repositories/iuv_repository.dart';

class GetIUVUseCase {
  final IUVRepository repository;

  GetIUVUseCase({required this.repository});

  Future<Either<Failure, IUV>> call(){
    return repository.getIUV();
  }
}
