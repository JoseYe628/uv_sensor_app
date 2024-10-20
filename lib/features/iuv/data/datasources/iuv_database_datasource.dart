
import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:uv_sensor_app/core/error/failure.dart';
import 'package:uv_sensor_app/features/iuv/data/models/iuv_model.dart';

abstract class IUVDatabaseDatasource {
  Stream<List<IUVModel>> get dataStream;
  Future<void> send(IUVModel iuv);
  Future<void> listen();
}

class IUVFirebaseDatasource implements IUVDatabaseDatasource {
  DatabaseReference ref = FirebaseDatabase.instance.ref("records");

  StreamController<List<IUVModel>> _dataStreamController = StreamController<List<IUVModel>>();

  @override
  Stream<List<IUVModel>> get dataStream => _dataStreamController.stream;

  @override
  Future<void> send(IUVModel iuv) async {
    try {
      await ref.push().set({
        "valor": iuv.value,
        "timestamp": iuv.time.millisecondsSinceEpoch,
      });
    } catch (error){
      throw FirebaseSendFailure();
    }
  }


  @override
  Future<void> listen() async {
    DateTime nowDateTime = DateTime.now();
    int todayAtMidnight = DateTime(nowDateTime.year, nowDateTime.month, nowDateTime.day).millisecondsSinceEpoch;
    ref.limitToLast(10).orderByChild("timestamp").startAt(todayAtMidnight).onValue.listen((DatabaseEvent event){
      if(event.snapshot.value == null){
        // No hay elementos
        _dataStreamController.add([]);
      }
      var val = event.snapshot.value as Map<dynamic, dynamic>;
      List<IUVModel> records = [];
      val.forEach((key, value) {
        var val = value as Map<dynamic, dynamic>;
        int timestamp = val['timestamp'];
        DateTime utcdatetime = DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: true);
        DateTime perudatetime = utcdatetime.toUtc().subtract(const Duration(hours: 5));
        var valorUV = val['valor'];
        IUVModel uvModelData = IUVModel(value: valorUV, time: perudatetime);
        records.add(uvModelData);
      });
      records.sort((a,b) => a.time.compareTo(b.time));
      _dataStreamController.add(records);
    },
    onDone: () async {
      await _dataStreamController.close();
      _dataStreamController = StreamController<List<IUVModel>>();
    });
  }

}
