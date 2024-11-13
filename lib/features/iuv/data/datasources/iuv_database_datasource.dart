
import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:uv_sensor_app/core/error/failure.dart';
import 'package:uv_sensor_app/features/iuv/data/models/iuv_model.dart';

abstract class IUVDatabaseDatasource {
  Future<Stream<List<IUVModel>>> getStreamData();
  Future<void> send(IUVModel iuv);
}

class IUVFirebaseDatasource implements IUVDatabaseDatasource {

  DatabaseReference ref = FirebaseDatabase.instance.ref('records');

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
  Future<Stream<List<IUVModel>>> getStreamData() async {
    DateTime nowDateTime = DateTime.now();
    int todayAtMidnight = DateTime(nowDateTime.year, nowDateTime.month, nowDateTime.day).millisecondsSinceEpoch;
    var stream = ref.limitToLast(10).orderByChild("timestamp").startAt(todayAtMidnight).onValue.map((DatabaseEvent event){
      List<IUVModel> records = [];
      if(event.snapshot.value == null) { return records; }
      var val = event.snapshot.value as Map<dynamic, dynamic>;
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
      return records;
    });
    return stream;
  }

}
