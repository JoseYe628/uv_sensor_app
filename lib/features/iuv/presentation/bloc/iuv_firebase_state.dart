
import 'package:uv_sensor_app/core/error/failure.dart';
import 'package:uv_sensor_app/features/iuv/domain/entities/iuv.dart';

class IUVFirebaseState {}

class IUVFirebaseInitialState extends IUVFirebaseState{}
class IUVFirebaseErrorState extends IUVFirebaseState{
  final Failure failure;
  IUVFirebaseErrorState({required this.failure});
}
class IUVFirebaseReadDataState extends IUVFirebaseState {
  final List<IUV> records;

  IUVFirebaseReadDataState({required this.records});
}
