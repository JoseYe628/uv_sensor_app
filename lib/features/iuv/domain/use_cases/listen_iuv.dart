
import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:uv_sensor_app/core/error/failure.dart';
import 'package:uv_sensor_app/features/iuv/domain/entities/iuv.dart';
import 'package:uv_sensor_app/features/iuv/domain/repositories/iuv_repository.dart';

class ListenIUVUseCase {
  final IUVRepository repository;
  final StreamController<IUV> _dataIUVStreamController = StreamController<IUV>();

  ListenIUVUseCase({required this.repository});


  Stream<IUV> get dataStream => _dataIUVStreamController.stream;

  Future<Either<Failure, void>> call() async {
    var initialResp = await repository.initialRepository();
    initialResp.fold(
      (f){
        return Left(f);
      },
      (v){
        // ---
      }
    );
    var resp = await repository.listenIUV();
    return resp.fold(
      (f){
        return Left(f);
      },
      (v){
        repository.dataStream.listen((value){
          _dataIUVStreamController.add(value);
        });
        return const Right(null);
      }
    );
  }
}
