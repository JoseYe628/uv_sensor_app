
import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:uv_sensor_app/core/error/failure.dart';
import 'package:uv_sensor_app/features/iuv/data/models/iuv_model.dart';
import 'package:uv_sensor_app/features/iuv/domain/entities/iuv.dart';


const uuidService = "4fafc201-1fb5-459e-8fcc-c5c9c331914b";
const uuidCharacteristic = "beb5483e-36e1-4688-b7f5-ea07361b26a8";

abstract class IUVBluetoothDatasource {
  /*Stream<IUVModel> get dataStream;
  Stream<bool> get dataStatusStream;
  Future<void> turnOn(); // Enciende el bluetooth, se conecta al device y prepara el dataStrem
  Future<void> turnOff();
  Future<void> listenBluetoothStatus();*/
  Future<Stream<IUVModel>> bluetoothOn();
  Future<void> bluetoothOf();
}

class FlutterBlueDatasource implements IUVBluetoothDatasource {

  StreamSubscription<BluetoothConnectionState>? subscriptionStatusBluetooth;

  late Stream<IUVModel>? _dataStream;
  BluetoothDevice? _device;

  FlutterBlueDatasource();

  @override
  Future<Stream<IUVModel>> bluetoothOn() async {
    var subscription = FlutterBluePlus.onScanResults.listen((results) async {
      for(ScanResult result in results){
        if(result.device.advName == "MyESP32"){
          _device = result.device;
          await _device!.connect();
          var services =  await _device!.discoverServices();
          for(BluetoothService service in services){
            if(service.uuid.toString() == uuidService){
              var characteristics = service.characteristics;
              for(BluetoothCharacteristic characteristic in characteristics){
                if(characteristic.uuid.toString() == uuidCharacteristic){
                  var target = characteristic;
                  target.setNotifyValue(true);
                  _dataStream = target.onValueReceived.map<IUVModel>((data) => IUVModel.fromInt(int.parse(String.fromCharCodes(data))));
                  FlutterBluePlus.stopScan();
                  break;
                }
              }
            }
          }
        }
      }
    });

    FlutterBluePlus.cancelWhenScanComplete(subscription);
    await FlutterBluePlus.startScan(
      withNames:["MyESP32"], // *or* any of the specified names
      timeout: const Duration(seconds:5)
    );

    await Future.delayed(const Duration(seconds: 6));

    if(_dataStream != null){
      return _dataStream!;
    } else {
      throw BluetoothNotFoundDeviceFailure();
    }
  }

  @override
  Future<void> bluetoothOf() async {
    _device?.disconnect();
  }
}

