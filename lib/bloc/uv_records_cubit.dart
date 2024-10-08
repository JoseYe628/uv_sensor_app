
import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uv_sensor_app/models/uv_response.dart';

class UVRecordsState {
  final List<UVResponse> records;
  final bool recordsIsVoid;
  UVRecordsState(this.records, {this.recordsIsVoid = false});
}

class UVRecordsCubit extends Cubit<UVRecordsState>{
  UVRecordsCubit(): super(UVRecordsState([], recordsIsVoid: true));

  DatabaseReference recordsDatabase = FirebaseDatabase.instance.ref('records');

  void obtainRecords(){
    DateTime nowDateTime = DateTime.now();
    int todayAtMidnight = DateTime(nowDateTime.year, nowDateTime.month, nowDateTime.day).millisecondsSinceEpoch;
    recordsDatabase.limitToLast(10).orderByChild("timestamp").startAt(todayAtMidnight).onValue.listen((DatabaseEvent event) {
      if(event.snapshot.value == null){
        emit(UVRecordsState([], recordsIsVoid: true));
      }
      var val = event.snapshot.value as Map<dynamic, dynamic>;
      List<UVResponse> records = [];
      val.forEach((key, value) {
        var val = value as Map<dynamic, dynamic>;
        int timestamp = val['timestamp'];
        DateTime utcdatetime = DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: true);
        DateTime perudatetime = utcdatetime.toUtc().subtract(const Duration(hours: 5));
        var valorUV = val['valor'];
        UVResponse uvResponseData = UVResponse(perudatetime, valorUV);
        records.add(uvResponseData);
      });
      records.sort((a,b) => a.time.compareTo(b.time));
      emit(UVRecordsState(records));
    });
  }

  void changeRecords(List<UVResponse> newRecords) {
    emit(UVRecordsState(newRecords));
  }
}
