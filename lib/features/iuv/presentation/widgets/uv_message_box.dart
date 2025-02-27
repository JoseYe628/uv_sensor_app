
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uv_sensor_app/features/iuv/presentation/bloc/iuv_firebase_cubit.dart';
import 'package:uv_sensor_app/features/iuv/presentation/bloc/iuv_firebase_state.dart';

class UVMessageBox extends StatelessWidget {
  const UVMessageBox({super.key});

  @override
  Widget build(BuildContext context){
    return BlocBuilder<IUVFirebaseCubit, IUVFirebaseState>(
      builder: (BuildContext context, IUVFirebaseState state){
          switch(state){
            case IUVFirebaseInitialState():
              return Container();
            case IUVFirebaseErrorState():
              return Container();
            case IUVFirebaseReadDataState():
              if(state.records.isEmpty){
                return Container();
              }
              return _Content(iuv: state.records.last.value);
            default:
              return Container();
          }
      }
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    super.key,
    required this.iuv,
  });

  final int iuv;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(horizontal: 40),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green, width: 2),
        borderRadius: const BorderRadius.all(Radius.circular(10))
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Alto", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 20),),
                Text(descriptionUV(iuv)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1),
            child: Icon(Icons.warning, color: Colors.green, size: 30),
          ),
        ],
      ),
    );
  }

  String descriptionUV(int uvIndex) {
    if (uvIndex >= 0 && uvIndex <= 2) {
      return "El índice UV es bajo. Es seguro estar al aire libre, pero no olvides aplicar protector solar si estarás expuesto por mucho tiempo.";
    } else if (uvIndex >= 3 && uvIndex <= 5) {
      return "El índice UV es moderado. Usa protector solar, gafas de sol y considera buscar sombra durante las horas más soleadas.";
    } else if (uvIndex >= 6 && uvIndex <= 7) {
      return "¡Atención! El índice UV es alto. Aplica protector solar de amplio espectro, usa ropa protectora y evita la exposición directa al sol entre las 10 a.m. y las 4 p.m.";
    } else if (uvIndex >= 8 && uvIndex <= 10) {
      return "¡Precaución! El índice UV es muy alto. Busca sombra, usa sombrero de ala ancha, gafas de sol, protector solar y limita el tiempo al aire libre.";
    } else if (uvIndex >= 11) {
      return "¡Alerta extrema! El índice UV es extremadamente alto. Evita estar al aire libre. Si es necesario, cúbrete completamente y aplica protector solar de manera frecuente.";
    } else {
      return "El índice UV ingresado no es válido.";
    }
  }

}
