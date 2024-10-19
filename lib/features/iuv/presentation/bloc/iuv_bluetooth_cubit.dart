
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uv_sensor_app/core/error/failure.dart';
import 'package:uv_sensor_app/features/iuv/domain/use_cases/bluetooth_off_case.dart';
import 'package:uv_sensor_app/features/iuv/domain/use_cases/listen_iuv.dart';

class IUVBluetoothState {
  final bool bluetoothState;
  IUVBluetoothState({required this.bluetoothState});
}

class IUVBluetoothReadState extends IUVBluetoothState {
  final int value;
  final DateTime time;
  IUVBluetoothReadState({required this.value, required this.time}): super(bluetoothState: true);
}

class IUVBluetoothOffState extends IUVBluetoothState {
  IUVBluetoothOffState(): super(bluetoothState: false);
}

class IUVBluetoothFailureState extends IUVBluetoothState{
  final Failure failure;
  IUVBluetoothFailureState({required this.failure}): super(bluetoothState: false);
}

class IUVBluetoothLoading extends IUVBluetoothState {
  IUVBluetoothLoading(): super(bluetoothState: false);
}



class IUVBluetoothCubit extends Cubit<IUVBluetoothState> {

  final ListenIUVUseCase _listenIUVUseCase;
  final BluetoothOffCase _bluetoothOffCase;

  IUVBluetoothCubit(this._listenIUVUseCase, this._bluetoothOffCase): super(IUVBluetoothOffState());

  Future<void> initListen() async {
    emit(IUVBluetoothLoading());
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

  Future<void> bluetoothOff() async {
    var resp = await _bluetoothOffCase();
    resp.fold(
      (f){
        emit(IUVBluetoothFailureState(failure: f));
      },
      (v){
        emit(IUVBluetoothOffState());
      }
    );
  }

}
