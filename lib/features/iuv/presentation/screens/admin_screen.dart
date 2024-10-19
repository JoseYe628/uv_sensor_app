
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uv_sensor_app/features/iuv/presentation/bloc/iuv_bluetooth_cubit.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context){
    var bluetoothCubit = context.read<IUVBluetoothCubit>();
    return BlocBuilder<IUVBluetoothCubit, IUVBluetoothState>(
      builder: (context, bluetoothState) => Scaffold(
        appBar: AppBar(
          title: Text("UV App", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          actions: [
            Switch(
              value: bluetoothState.bluetoothState,
              onChanged: (val) async {
                if(val){
                  await bluetoothCubit.initListen();
                } else {
                  await bluetoothCubit.bluetoothOff();
                }
              },
            ),
          ],
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              Text(bluetoothState.bluetoothState ? "Se conectó el device" : "No se conectó"),
              TextAdvice(),
            ],
          ),
        )
      ),
    );
  }
}

class TextAdvice extends StatelessWidget {
  const TextAdvice({super.key});

  @override
  Widget build(BuildContext context){
    return BlocBuilder<IUVBluetoothCubit, IUVBluetoothState>(
      builder: (context, bstate) {
        switch(bstate){
          case IUVBluetoothLoading():
            return Text("Cargando...");
          case IUVBluetoothReadState():
            return Text("sí funciona: ${bstate.value}");
          case IUVBluetoothOffState():
            return Text("Error: Bluetooth está apagado");
          case IUVBluetoothFailureState():
            var text = (bstate as IUVBluetoothFailureState).failure.toString();
            return Text("Error: ${text}");
          default:
            return Text("Error no conocido");
        }
      }
    );
  }
}
