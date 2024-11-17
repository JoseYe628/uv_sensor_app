
import 'package:dartz/dartz.dart';
import 'package:uv_sensor_app/core/error/failure.dart';
import 'package:uv_sensor_app/features/iuv/domain/entities/iuv.dart';
import 'package:uv_sensor_app/features/iuv/domain/repositories/iuv_repository.dart';

class RemoteIUVUsecase {
  final IUVRepository repository;

  RemoteIUVUsecase({required this.repository});

  Future<Either<Failure, Stream<List<IUV>>>> getStreamRemoteData(){
    return repository.remoteRepositoryOn();
  }

  Future<Either<Failure, void>> sendRemoteData(IUV iuv, bool notify){
    return repository.remoteSendData(iuv, notify);
  }
}

