
import 'package:flutter/material.dart';
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
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          UvTraker(),
          UVMessageBox(),
        ],
      ),
    );
  }
}
