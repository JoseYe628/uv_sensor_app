
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

  DatabaseReference recordsDatabase = FirebaseDatabase.instance.ref('records/2024-10-01');
  List<UVResponse> uvRecords = [];

  @override
  void initState() {
    super.initState();
    recordsDatabase.limitToLast(10).onValue.listen((DatabaseEvent event) {
      var val = event.snapshot.value as Map<dynamic, dynamic>;
      var data = Map<String, int>.from(val);
      List<UVResponse> records = [];
      data.forEach((timeKey, iuvVal){
        records.add(UVResponse(timeKey, iuvVal));
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
      ? Center(
        child: CircularProgressIndicator(color: Colors.green, strokeWidth: 2,),
      ) 
      : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UvTraker(uvValue: uvRecords.last,),
              UVMessageBox(),
              UVHistory(),
              GridMenuInfo(),
            ],
          ),
        );
  }
}
