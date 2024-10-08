
import 'package:flutter/material.dart';
import 'package:uv_sensor_app/models/models.dart';

class UVHistory extends StatelessWidget {
  UVHistory({super.key, required this.records});

  List<UVResponse> records;

  @override
  Widget build(BuildContext context){
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Historial de hoy", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18)),
          Divider(color: Colors.green, height: 2, thickness: 2,),
          _Records(records)
        ],
      ),
    );
  }
}

class _Records extends StatelessWidget {
  _Records(this.records);

  List<UVResponse> records;

  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: records.reversed.map((uvRecord){
          return _HistoryRecord(time: uvRecord.time.toString(), uvVal: uvRecord.iuv);
        }).toList(),
      ),
    );
  }
}

class _HistoryRecord extends StatelessWidget {
  const _HistoryRecord({super.key, required this.time, required this.uvVal});

  final String time;
  final int uvVal;

  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 10),
      constraints: BoxConstraints(minWidth: 55),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        children: [
          Text("${uvVal}", style: TextStyle(color: Colors.green, fontSize: 25, fontWeight: FontWeight.w500)),
          Text(time, style: TextStyle(color: Colors.green, fontSize: 13, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
