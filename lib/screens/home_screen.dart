
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uv_sensor_app/bloc/uv_records_cubit.dart';
import 'package:uv_sensor_app/components/info/grid_menu_info.dart';
import 'package:uv_sensor_app/components/uv/uv_components.dart';

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

  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UvTraker(),
            UVMessageBox(),
            UVHistory(),
            GridMenuInfo(),
          ],
        ),
      );
  }
}
