
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uv_sensor_app/features/iuv/presentation/bloc/iuv_firebase_cubit.dart';
import 'package:uv_sensor_app/features/iuv/presentation/bloc/iuv_firebase_state.dart';
import 'package:uv_sensor_app/utils/iuv_color.dart';

class UvTraker extends StatelessWidget {
  const UvTraker({super.key});


  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      alignment: Alignment.center,
      child: BlocBuilder<IUVFirebaseCubit, IUVFirebaseState>(
        builder: (BuildContext context, IUVFirebaseState state) {
          switch(state){
            case IUVFirebaseInitialState():
              return Text("Cargando información...");
            case IUVFirebaseErrorState():
              return Text("No se pudieron obtener los datos");
            case IUVFirebaseReadDataState():
              if(state.records.isEmpty){
                return Text("No hay records el día de hoy");
              } 
              return Column(
                children: [
                  _UVIndex(iuv: state.records.last.value),
                  Text("Índice IUV", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: getColorForUVIndex(state.records.last.value))),
                ],
              );
            default:
              return Text("Error inesperado...");
          }
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
    return AnimatedContainer(
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
    );
  }
}
