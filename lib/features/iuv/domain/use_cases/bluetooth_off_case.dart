
import 'package:dartz/dartz.dart';
import 'package:uv_sensor_app/core/error/failure.dart';
import 'package:uv_sensor_app/features/iuv/domain/repositories/iuv_repository.dart';

class BluetoothOffCase {
  final IUVRepository repository;

  BluetoothOffCase({required this.repository});

  Future<Either<Failure, void>> call() async {
    var resp = await repository.bluetoothOff();
    return resp.fold(
      (f){
        return Left(f);
      },
      (v){
        return const Right(null);
      }
    );
  }
}
