
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uv_sensor_app/features/iuv/domain/entities/iuv.dart';
import 'package:uv_sensor_app/features/iuv/domain/use_cases/local_iuv_usecase.dart';
import 'package:uv_sensor_app/features/iuv/domain/use_cases/remote_iuv_usecases.dart';
import 'package:uv_sensor_app/features/iuv/presentation/bloc/iuv_bluetooth_state.dart';
import 'package:uv_sensor_app/utils/iuv_records_average.dart';


class IUVBluetoothCubit extends Cubit<IUVBluetoothState> {

  final LocalIUVUsecase _localIUVUsecase;
  final RemoteIUVUsecase _remoteIUVUsecase;
  IUVRecordsAverage records = IUVRecordsAverage.initialized();
  DateTime? latestSend ;

  StreamSubscription<IUV>? _subscriptionBluetooth;

  IUVBluetoothCubit(this._localIUVUsecase, this._remoteIUVUsecase): super(IUVBluetoothDisconnectedState());

  Future<void> bluetoothOn() async {
    emit(IUVBluetoothLoadingState());
    var resp = await _localIUVUsecase.localIUVOn();
    resp.fold(
      (fail){
        emit(IUVBluetoothInternalErrorState(failure: fail));
      },
      (stream){
        emit(IUVBluetoothConnectionSuccessState());
        _subscriptionBluetooth = stream.listen((iuv) async {
          if(iuv.value > 0 && iuv.value < 20){
            records.push(iuv);
            bool withNotify = false;
            if(iuv.value > 8){
              if(latestSend == null){
                latestSend = DateTime.now();
                withNotify = true;
              } else {
                withNotify = records.records.length < 10 ? false : records.isNotificationRequired(8);
                withNotify = withNotify && latestSend!.add(Duration(minutes: 10)).isAfter(iuv.time);
                if(withNotify){
                  latestSend = DateTime.now();
                }
              }
            }
            records.printRecords();
            print("WITH NOTIFY: ${withNotify}");
            // Enviar mensaje
            /*var resp = await _remoteIUVUsecase.sendRemoteData(iuv, withNotify);
            resp.fold(
              (f){
                emit(IUVBluetoothFirebaseSendingFailureState(failure: f));
              },
              (v){
                // --
              }
            );*/
          }
          emit(IUVBluetoothReadingState(iuv: iuv));
        });
      }
    );
  }

  Future<void> bluetoothOff() async {
    await _subscriptionBluetooth?.cancel();
    var result = await _localIUVUsecase.localIUVOff();
    result.fold(
      (f){
        emit(IUVBluetoothInternalErrorState(failure: f));
      },
      (v){
        emit(IUVBluetoothDisconnectedState());
      }
    );
  }

}
