
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uv_sensor_app/features/iuv/domain/use_cases/local_iuv_usecase.dart';
import 'package:uv_sensor_app/features/iuv/domain/use_cases/remote_iuv_usecases.dart';
import 'package:uv_sensor_app/features/iuv/presentation/bloc/iuv_bluetooth_state.dart';


class IUVBluetoothCubit extends Cubit<IUVBluetoothState> {

  final LocalIUVUsecase _localIUVUsecase;
  final RemoteIUVUsecase _remoteIUVUsecase;

  IUVBluetoothCubit(this._localIUVUsecase, this._remoteIUVUsecase): super(IUVBluetoothDisconnectedState());

  Future<void> initListen() async {
    emit(IUVBluetoothLoadingState());
    var resp = await _localIUVUsecase.localRepositoryOn();
    resp.fold(
      (f) {
        emit(IUVBluetoothConnectionErrorState(failure: f));
      },
      (streamDataIUV) {
        streamDataIUV.listen((iuv) async {
          var sendingResult = await _remoteIUVUsecase.sendData(iuv);
          sendingResult.fold(
            (fail){
              emit(IUVBluetoothFirebaseSendingFailureState(failure: fail));
            },
            (v){
              emit(IUVBluetoothReadingState(iuv: iuv));
            }
          );
        },
        onDone: (){
          emit(IUVBluetoothDisconnectedState());
        });
      }
    );
    var connectionState = await _localIUVUsecase.listenRepositoryState();
    connectionState.fold(
      (f){
        emit(IUVBluetoothInternalErrorState(failure: f));
      },
      (streamStatusBluetooth){
        streamStatusBluetooth.listen((status){
          if(status == false){
            //bluetoothOff();
            emit(IUVBluetoothDisconnectedState());
          }
        },
        onDone: (){
          emit(IUVBluetoothDisconnectedState());
        });
      }
    );
  }

  Future<void> bluetoothOff() async {
    var resp = await _localIUVUsecase.localRepositoryOff();
    resp.fold(
      (f){
        emit(IUVBluetoothDisconnectionErrorState(failure: f));
      },
      (v){
        emit(IUVBluetoothDisconnectedState());
      }
    );
  }

}
