
import 'package:flutter/material.dart';
import 'package:uv_sensor_app/components/uv/uv_traker.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Índice de radiación UV", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          UvTraker()
        ],
      ),
    );
  }
}
