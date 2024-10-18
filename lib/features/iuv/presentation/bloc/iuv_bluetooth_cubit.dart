
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uv_sensor_app/core/error/failure.dart';
import 'package:uv_sensor_app/features/iuv/domain/use_cases/listen_iuv.dart';

abstract class IUVBluetoothState {}

class IuvBluetoothInitialState extends IUVBluetoothState{}

class IUVBluetoothReadState extends IUVBluetoothState {
  final int value;
  final DateTime time;
  IUVBluetoothReadState({required this.value, required this.time});
}

class IUVBluetoothFailureState extends IUVBluetoothState{
  final Failure failure;
  IUVBluetoothFailureState({required this.failure});
}


class IUVBluetoothCubit extends Cubit<IUVBluetoothState> {

  final ListenIUVUseCase _listenIUVUseCase;

  IUVBluetoothCubit(this._listenIUVUseCase): super(IuvBluetoothInitialState());

  void initCubit() async {
    var resp = await _listenIUVUseCase();
    resp.fold(
      (f) {
        emit(IUVBluetoothFailureState(failure: f));
      },
      (v) {
        _listenIUVUseCase.dataStream.listen((iuv){
          emit(IUVBluetoothReadState(value: iuv.value, time: iuv.time));
        });
      }
    );
  }
}
