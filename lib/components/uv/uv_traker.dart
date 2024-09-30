
//import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uv_sensor_app/models/models.dart';

class UvTraker extends StatelessWidget {
  const UvTraker({super.key, required this.uvValue});

  final UVResponse uvValue;

  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      alignment: Alignment.center,
      child: Column(
        children: [
          _UVIndex(value: uvValue.iuv),
          Text("Índice IUV", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green),),
        ],
      )
    );
  }
}

class _UVIndex extends StatelessWidget {
  const _UVIndex({
    super.key,
    required this.value,
  });

  final int value;

  @override
  Widget build(BuildContext context) {
    return Text(
      "${value}",
      style: TextStyle(
        height: 1,
        //backgroundColor: Colors.red,
        color: Colors.green,
        fontSize: 120,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
