
import 'package:dartz/dartz.dart';
import 'package:uv_sensor_app/core/error/failure.dart';
import 'package:uv_sensor_app/features/iuv/domain/entities/iuv.dart';
import 'package:uv_sensor_app/features/iuv/domain/repositories/iuv_repository.dart';

class RemoteIUVUsecase {
  final IUVRepository repository;

  RemoteIUVUsecase({required this.repository});

  Future<Either<Failure, void>> sendData(IUV iuv) {
    return repository.sendIUV(iuv);
  }

  Future<Either<Failure, Stream<List<IUV>>>> listenData(){
    return repository.remoteRepositoryListen();
  }
}
