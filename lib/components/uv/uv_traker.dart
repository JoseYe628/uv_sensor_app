
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uv_sensor_app/bloc/uv_records_cubit.dart';

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
              Text("Índice IUV", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green),),
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
      builder: (BuildContext context, UVRecordsState state) => Text(
        "$iuv",
        style: TextStyle(
          height: 1,
          //backgroundColor: Colors.red,
          color: Colors.green,
          fontSize: 120,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
