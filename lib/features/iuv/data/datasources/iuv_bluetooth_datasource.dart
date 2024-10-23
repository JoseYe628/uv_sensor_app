
import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:uv_sensor_app/core/error/failure.dart';
import 'package:uv_sensor_app/features/iuv/data/models/iuv_model.dart';


const uuidService = "4fafc201-1fb5-459e-8fcc-c5c9c331914b";
const uuidCharacteristic = "beb5483e-36e1-4688-b7f5-ea07361b26a8";

abstract class IUVBluetoothDatasource {
  Stream<IUVModel> get dataStream;
  Stream<bool> get dataStatusStream;
  Future<void> turnOn(); // Enciende el bluetooth, se conecta al device y prepara el dataStrem
  Future<void> turnOff();
  Future<void> listenBluetoothStatus();
}

class FlutterBlueDatasource implements IUVBluetoothDatasource {

  BluetoothDevice? _device;
  StreamSubscription<BluetoothConnectionState>? subscriptionStatusBluetooth;
  StreamController<IUVModel> _dataStreamController = StreamController<IUVModel>();
  StreamController<bool> _dataStatusStreamController = StreamController<bool>();

  FlutterBlueDatasource();


  @override
  Stream<IUVModel> get dataStream => _dataStreamController.stream;

  @override
  Stream<bool> get dataStatusStream => _dataStatusStreamController.stream;

  @override
  Future<void> turnOn() async {
    var scanSubscription = FlutterBluePlus.onScanResults.listen((results){
      for(ScanResult result in results){
        //print("Device: ${result.device.advName}");
        if(result.device.advName == "MyESP32"){
          FlutterBluePlus.stopScan();
          _connectWithDevice(result.device);
        }
      }
    },
    onError: (e){
      throw BluetoothInternalErrorFailure();
    });

    scanSubscription.onDone((){
      print("El escaneo se ha terminao...");
    });

    //FlutterBluePlus.cancelWhenScanComplete(scanSubscription);

    print("Empezando a escanear dispositivos");
    FlutterBluePlus.startScan(
      withNames:["MyESP32"],
      timeout: const Duration(seconds:5)
    );
    await Future.delayed(Duration(seconds: 6));
    scanSubscription.cancel();

    if(_device == null){
      throw BluetoothNotFoundDeviceFailure();
    }

  }

  Future<void> _connectWithDevice(BluetoothDevice device) async {
    await device.connect();
    _device = device;
    _discoverServices();
  }

  Future<void> _discoverServices() async {
    if(_device != null){
      List<BluetoothService> services = await _device!.discoverServices();
      for(BluetoothService service in services){
        if(service.uuid.toString() == uuidService){
          for(BluetoothCharacteristic characteristic in service.characteristics){
            if(characteristic.uuid.toString() == uuidCharacteristic){
              var targetCharacteristic = characteristic;
              targetCharacteristic.setNotifyValue(true);
              targetCharacteristic.onValueReceived.listen((value){
                String valueText = String.fromCharCodes(value);
                var iuvModel = IUVModel.fromInt(int.parse(valueText));
                _dataStreamController.add(iuvModel);
              },
              onDone: (){
                print("Hubo una desconexión");
                _dataStreamController.close();
                _dataStreamController = StreamController<IUVModel>();
              });
            }
          }
        }
      }
    } else {
      throw BluetoothNotFoundDeviceFailure();
    }
  }

  @override
  Future<void> turnOff() async {
    await _device?.disconnect();
    await subscriptionStatusBluetooth?.cancel();
    subscriptionStatusBluetooth = null;
    await _dataStreamController.close();
    _dataStreamController = StreamController<IUVModel>();
    await _dataStatusStreamController.close();
    _dataStatusStreamController = StreamController<bool>();
  }


  @override
  Future<void> listenBluetoothStatus() async {
    if(_device != null){
      subscriptionStatusBluetooth = _device!.connectionState.listen((status) async {
        if(status == BluetoothConnectionState.disconnected){
          _dataStatusStreamController.add(false);
          await turnOff();
        }
      },
      onDone: () async {
        await _dataStatusStreamController.close();
        _dataStatusStreamController = StreamController<bool>();
      });
    }
  }

}

