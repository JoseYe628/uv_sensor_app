
import 'package:flutter/material.dart';
import 'package:uv_sensor_app/features/iuv/domain/entities/iuv.dart';
import 'package:uv_sensor_app/utils/iuv_color.dart';

class AdminTraker extends StatelessWidget {
  const AdminTraker({super.key, required this.iuv});

  final IUV iuv;


  @override
  Widget build(BuildContext context){
    return Container(
      //padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      //margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      alignment: Alignment.center,
      child: _UVIndex(iuv: iuv.value),
    );
  }
}

class _UVIndex extends StatelessWidget {
  const _UVIndex({super.key, required this.iuv});

  final int iuv;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 130),
      decoration: BoxDecoration(
        color: getColorForUVIndex(iuv).withAlpha(20),
        border: Border.all(color: getColorForUVIndex(iuv), width: 3),
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Text(
        "$iuv",
        style: TextStyle(
          height: 1,
          //backgroundColor: Colors.red,
          color: Colors.black,
          fontSize: iuv >= 10 ? 140 : 180,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
