
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uv_sensor_app/bloc/uv_records_cubit.dart';
import 'package:uv_sensor_app/utils/iuv_color.dart';

class UvTraker extends StatelessWidget {
  const UvTraker({super.key});


  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      alignment: Alignment.center,
      child: BlocBuilder<UVRecordsCubit, UVRecordsState>(
        builder: (BuildContext context, UVRecordsState state) {
          if(state.records.isEmpty){
            if(state.recordsNotFound){
              return Text("No hay records el día de hoy");
            } else {
              return Text("Cargando records...");
            }
          }
          return Column(
            children: [
              _UVIndex(iuv: state.records.last.iuv),
              Text("Índice IUV", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: getColorForUVIndex(state.records.last.iuv)),),
            ],
          );
        }
      )
    );
  }
}

class _UVIndex extends StatelessWidget {
  const _UVIndex({super.key, required this.iuv});

  final int iuv;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UVRecordsCubit, UVRecordsState>(
      builder: (BuildContext context, UVRecordsState state) => AnimatedContainer(
        duration: Duration(seconds: 1),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        margin: EdgeInsets.symmetric(vertical: 10),
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
            color: getColorForUVIndex(iuv),
            fontSize: iuv >= 10 ? 100 : 140,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
