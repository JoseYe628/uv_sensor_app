
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uv_sensor_app/components/info/grid_menu_info.dart';
import 'package:uv_sensor_app/components/uv/uv_components.dart';
import 'package:uv_sensor_app/models/models.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("UV App", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
      ),
      body: _UVElements(),
    );
  }
}


class _UVElements extends StatefulWidget {
  const _UVElements({super.key});

  @override
  State<_UVElements> createState() => _UVElementsState();
}

class _UVElementsState extends State<_UVElements> {

  DatabaseReference recordsDatabase = FirebaseDatabase.instance.ref('records');
  List<UVResponse> uvRecords = [];
  bool dataIsVoid = false;

  @override
  void initState() {
    super.initState();
    DateTime nowDateTime = DateTime.now();
    int todayAtMidnight = DateTime(nowDateTime.year, nowDateTime.month, nowDateTime.day).millisecondsSinceEpoch;
    recordsDatabase.limitToLast(10).orderByChild("timestamp").startAt(todayAtMidnight).onValue.listen((DatabaseEvent event) {
      if(event.snapshot.value == null){
        setState(() {
          dataIsVoid == true;
        });
      }
      var val = event.snapshot.value as Map<dynamic, dynamic>;
      List<UVResponse> records = [];
      val.forEach((key, value) {
        var val = value as Map<dynamic, dynamic>;
        int timestamp = val['timestamp'];
        DateTime utcdatetime = DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: true);
        DateTime perudatetime = utcdatetime.toUtc().subtract(const Duration(hours: 5));
        var valorUV = val['valor'];
        UVResponse uvResponseData = UVResponse(perudatetime ,val['valor']);
        records.add(uvResponseData);
      });
      records.sort((a,b) => a.time.compareTo(b.time));
      setState(() {
        uvRecords = records;
      });
    });
  }

  @override
  Widget build(BuildContext context){
    return uvRecords.isEmpty
    ? Container() 
    : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
            children: dataIsVoid ? [Text("No hay información el día de hoy")] : [
              UvTraker(uvValue: uvRecords.last,),
              UVMessageBox(),
              UVHistory(records: uvRecords),
              GridMenuInfo(),
            ],
          ),
        );
  }
}
