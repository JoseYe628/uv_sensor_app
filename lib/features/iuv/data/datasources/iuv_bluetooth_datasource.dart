
import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:uv_sensor_app/core/error/failure.dart';
import 'package:uv_sensor_app/features/iuv/data/models/iuv_model.dart';


const uuidService = "nombre_uuid_service";
const uuidCharacteristic = "nombre_uuid_characteristic";

abstract class IUVBluetoothDatasource {
  Stream<IUVModel> get dataStream;
  Future<void> searchDevice();
  Future<void> connectToDevice();
  Future<void> disconnectWithDevice();
  Future<void> listenDataDevice();
}

class FlutterBlueDatasource implements IUVBluetoothDatasource {

  BluetoothDevice? _device;
  final StreamController<IUVModel> _dataStreamController = StreamController<IUVModel>();

  FlutterBlueDatasource();


  @override
  Stream<IUVModel> get dataStream => _dataStreamController.stream;

  @override
  Future<void> searchDevice() async {
    var scanSubscription = FlutterBluePlus.onScanResults.listen((results) {
      if(results.isNotEmpty){
        _device = results.last.device;
      }
    }, onError: (e){throw BluetoothScanDevicesFailure();});

    FlutterBluePlus.cancelWhenScanComplete(scanSubscription);

    await FlutterBluePlus.startScan(
      withNames:["Esp32UVDevice"],
      timeout: const Duration(seconds:10)
    );

    if(_device == null){
      print("No se pudo encontrar el dispositivo");
      throw BluetoothNotFoundDeviceFailure();
    }
  }

  @override
  Future<void> connectToDevice() async {
    if(_device != null){
      await _device!.connect();
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

  @override
  Future<void> listenDataDevice() async {
    if(_device == null){
      throw BluetoothDeviceDisconnectedFailure();
    }
    List<BluetoothService> services = await _device!.discoverServices();
    for(BluetoothService service in services){
      if(service.uuid.toString() == uuidService){
        var characteristics = service.characteristics;
        for(BluetoothCharacteristic ch in characteristics){
          if(ch.uuid.toString() == uuidCharacteristic){
            ch.onValueReceived.listen((value){
              String iuvVal = String.fromCharCodes(value);
              IUVModel iuvModel = IUVModel.fromInt(int.parse(iuvVal));
              _dataStreamController.add(iuvModel);
            }, onError: (e){throw BluetoothNotFoundDCharacteristicsFailure();});
          }
        }
      }
    }
  }
  
}

