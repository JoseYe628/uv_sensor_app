
import 'package:uv_sensor_app/core/error/failure.dart';
import 'package:uv_sensor_app/features/iuv/domain/entities/iuv.dart';

class IUVBluetoothState {
  final bool bluetoothIsOn;
  IUVBluetoothState({required this.bluetoothIsOn});
}

class IUVBluetoothLoadingState extends IUVBluetoothState {
  IUVBluetoothLoadingState(): super(bluetoothIsOn: false);
}

class IUVBluetoothDisconnectedState extends IUVBluetoothState {
  IUVBluetoothDisconnectedState(): super(bluetoothIsOn: false);
}

class IUVBluetoothReadingState extends IUVBluetoothState {
  final IUV iuv;
  IUVBluetoothReadingState({required this.iuv}): super(bluetoothIsOn: true);
}

class IUVBluetoothConnectionErrorState extends IUVBluetoothState {
  final Failure failure;
  IUVBluetoothConnectionErrorState({required this.failure}): super(bluetoothIsOn: false);
}

class IUVBluetoothDisconnectionErrorState extends IUVBluetoothState {
  final Failure failure;
  IUVBluetoothDisconnectionErrorState({required this.failure}): super(bluetoothIsOn: false);
}

class IUVBluetoothInternalErrorState extends IUVBluetoothState {
  final Failure failure;
  IUVBluetoothInternalErrorState({required this.failure}): super(bluetoothIsOn: false);
}

class IUVBluetoothFirebaseSendingFailureState extends IUVBluetoothState {
  final Failure failure;
  IUVBluetoothFirebaseSendingFailureState({required this.failure}): super(bluetoothIsOn: true);
}
