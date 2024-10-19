
import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:uv_sensor_app/core/error/failure.dart';
import 'package:uv_sensor_app/features/iuv/data/models/iuv_model.dart';


const uuidService = "4fafc201-1fb5-459e-8fcc-c5c9c331914b";
const uuidCharacteristic = "beb5483e-36e1-4688-b7f5-ea07361b26a8";

abstract class IUVBluetoothDatasource {
  Stream<IUVModel> get dataStream;
  Future<void> searchDevice();
  Future<void> disconnectWithDevice();
}

class FlutterBlueDatasource implements IUVBluetoothDatasource {

  BluetoothDevice? _device;
  final StreamController<IUVModel> _dataStreamController = StreamController<IUVModel>();

  FlutterBlueDatasource();


  @override
  Stream<IUVModel> get dataStream => _dataStreamController.stream;

  @override
  Future<void> searchDevice() async {

    print("Empezando a escanear dispositivos");
    FlutterBluePlus.startScan(
      //withNames:["MyESP32"],
      timeout: const Duration(seconds:15)
    );

    var scanSubscription = FlutterBluePlus.onScanResults.listen((results){
      for(ScanResult result in results){
        print("Device: ${result.device.advName}");
        if(result.device.advName == "MyESP32"){
          FlutterBluePlus.stopScan();
          _connectWithDevice(result.device);
        }
      }

    }, 
      onError: (e){throw BluetoothScanDevicesFailure();}
    );

    FlutterBluePlus.cancelWhenScanComplete(scanSubscription);
  }

  Future<void> _connectWithDevice(BluetoothDevice device) async {
    await device.connect();
    _device = device;
    print("El device está conectado");
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
              });
            }
          }
        }
      }
    }
  }

  @override
  Future<void> disconnectWithDevice() async {
    try {
      await _device?.disconnect();
    } catch(err){
      throw BluetoothDisconnectError();
    }
  }
}

